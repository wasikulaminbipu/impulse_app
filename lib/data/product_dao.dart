import 'package:flutter/foundation.dart' hide Category;
import 'package:impulse_app/data/fts_utils.dart';
// Data access layer for products.db (schema v2).
// Built on sqflite. See products_schema.sql and products_db_changes.md.

import 'package:impulse_app/models/product.dart';

import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/domain/search_scope.dart';

import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';

import 'package:impulse_app/data/app_databases.dart';

class ProductDao {
  final ProductsDb db;
  final LookupDao lookupDao;
  final ManufacturerDao manufacturerDao;
  final SearchQueryCache<ProductLabel> _searchCache = SearchQueryCache<ProductLabel>(capacity: 100);

  ProductDao(this.db, this.lookupDao, {ManufacturerDao? manufacturerDao})
      : manufacturerDao = manufacturerDao ?? ManufacturerDao(db);

  // ------------------------------------------------------------
  // Single product, fully hydrated (Product Detail Page)
  // ------------------------------------------------------------

  Future<Product?> getById(int id) async {
    final rows = await db.executor.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _hydrate(Product.fromRow(rows.first));
  }



  Future<Product> _hydrate(Product base) async {
    final results = await Future.wait([
      _getTargetGroupIds(base.id),
      _getCompositions(base.id),
      _getIndications(base.id),
      _getDirections(base.id),
      _getPrecautions(base.id),
      _getPresentations(base.id),
      base.manufacturerId == null
          ? Future.value(null)
          : manufacturerDao.getById(base.manufacturerId!),
      lookupDao.getCategories(),
      lookupDao.getTargetGroups(),
    ]);

    final tgIds = results[0] as List<int>;
    final allCategories = results[7] as List<Category>;
    final allTargetGroups = results[8] as List<TargetGroup>;
    
    final catMap = { for (var c in allCategories) c.id : c };
    final allTgMap = { for (var tg in allTargetGroups) tg.id : tg };

    return base.copyWith(
      targetGroupIds: tgIds,
      compositions: results[1] as List<Composition>,
      indications: results[2] as List<Indication>,
      directions: results[3] as List<Direction>,
      precautions: results[4] as List<Precaution>,
      presentations: results[5] as List<Presentation>,
      manufacturer: (results[6] as Manufacturer?) ?? const Manufacturer.empty(),
      category: catMap[base.categoryId] ?? const Category.empty(),
      targetGroups: tgIds.map((id) => allTgMap[id]).whereType<TargetGroup>().toList(),
    );
  }

  // ------------------------------------------------------------
  // Listing / browsing (Product Card grids, tab filtering)
  // Lightweight: relation lists (target groups and presentations) are batch
  // loaded in one go (avoiding N+1 queries) so callers can render a
  // card (title, image, category, target groups, pack size, price) correctly.
  // Use getById / getBySlug when the full detail page needs everything.
  // ------------------------------------------------------------

  Future<List<Product>> _hydrateList(List<Product> products) async {
    if (products.isEmpty) return products;
    final productIds = products.map((p) => p.id).toList();
    // Fetch target groups in batch
    final tgRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT product_id, target_group_id 
      FROM product_target_groups 
      WHERE product_id IN 
      ''',
      ids: productIds,
    );

    final tgMap = <int, List<int>>{};
    for (final r in tgRows) {
      final pid = r['product_id'] as int;
      final tgid = r['target_group_id'] as int;
      tgMap.putIfAbsent(pid, () => []).add(tgid);
    }

    // Fetch presentations in batch
    final presRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT * FROM presentations 
      WHERE product_id IN 
      ''',
      suffix: '''
      ORDER BY display_order
      ''',
      ids: productIds,
    );

    final presMap = <int, List<Presentation>>{};
    for (final r in presRows) {
      final p = Presentation.fromRow(r);
      presMap.putIfAbsent(p.productId, () => []).add(p);
    }

    // Lookup categories and target groups via cached maps
    final catMap = await lookupDao.getCategoryMap();
    final allTgMap = await lookupDao.getTargetGroupMap();

    return products.map((p) {
      final tgIds = tgMap[p.id] ?? [];
      return p.copyWith(
        category: catMap[p.categoryId] ?? const Category.empty(),
        targetGroupIds: tgIds,
        targetGroups: tgIds.map((id) => allTgMap[id]).whereType<TargetGroup>().toList(),
        presentations: presMap[p.id] ?? [],
      );
    }).toList();
  }

  Future<List<Product>> getAllLight({
    bool activeOnly = true,
    int? categoryId,
    int? targetGroupId,
  }) async {
    if (targetGroupId != null) {
      // Product can belong to multiple target groups (many-to-many), so it
      // may appear under more than one tab.
      final where = <String>['ptg.target_group_id = ?'];
      final args = <Object?>[targetGroupId];
      if (activeOnly) where.add('p.is_active = 1');
      if (categoryId != null) {
        where.add('p.category_id = ?');
        args.add(categoryId);
      }
      final rows = await db.executor.customQuery('''
        SELECT p.* FROM products p
        JOIN product_target_groups ptg ON ptg.product_id = p.id
        WHERE ${where.join(' AND ')}
        ORDER BY p.title_en
      ''', args);
      return _hydrateList(rows.map(Product.fromRow).toList());
    }

    final where = <String>[];
    final args = <Object?>[];
    if (activeOnly) where.add('is_active = 1');
    if (categoryId != null) {
      where.add('category_id = ?');
      args.add(categoryId);
    }
    final rows = await db.executor.query(
      'products',
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args.isEmpty ? null : args,
      orderBy: 'title_en',
    );
    return _hydrateList(rows.map(Product.fromRow).toList());
  }

  Future<List<ProductLabel>> getAllLabels({bool activeOnly = true}) async {
    final products = await getAllLight(activeOnly: activeOnly);
    return products.map((p) => p.toLabel()).toList();
  }

  Future<List<ProductLabel>> getFilteredLabels({
    int? categoryId,
    int? targetGroupId,
    bool isFeedAdditive = false,
    String query = '',
    SearchScope scope = SearchScope.all,
    required int limit,
    required int offset,
  }) async {
    final args = <dynamic>[];
    List<String> where = ['p.is_active = 1'];
    String join = '';
    String orderBy = 'ORDER BY p.title_en';
    
    if (targetGroupId != null) {
      join += 'JOIN product_target_groups ptg ON ptg.product_id = p.id\n        ';
      where.add('ptg.target_group_id = ?');
      args.add(targetGroupId);
    }
    
    if (isFeedAdditive) {
      where.add('''
        (
          EXISTS (SELECT 1 FROM presentations pr WHERE pr.product_id = p.id AND pr.bulk_item = 1)
          OR
          EXISTS (
            SELECT 1 FROM directions d 
            JOIN species s ON s.id = d.species_id 
            JOIN target_groups tg ON tg.id = s.target_group_id 
            WHERE d.product_id = p.id AND tg.name_en IN ('Feed Additives', 'Feed Additive')
          )
        )
      ''');
    }
    
    if (categoryId != null) {
      where.add('p.category_id = ?');
      args.add(categoryId);
    }
    
    final trimmed = query.trim();
    final cacheKey = '$categoryId:$targetGroupId:$isFeedAdditive:$scope:$trimmed:$limit:$offset';

    if (trimmed.isNotEmpty && offset == 0) {
      final cached = _searchCache.get(cacheKey);
      if (cached != null) return cached;
    }
    
    List<Map<String, dynamic>> rows = [];
    
    if (trimmed.isNotEmpty) {
      final ftsCandidateList = <Map<String, dynamic>>[];
      final triCandidateList = <Map<String, dynamic>>[];
      final likeCandidateList = <Map<String, dynamic>>[];
      final fuzzyCandidateList = <Map<String, dynamic>>[];

      // 1. FTS query (run when scope is ALL or NAME)
      if (scope == SearchScope.all || scope == SearchScope.name) {
        final sanitizedTokens = sanitizeFtsQuery(trimmed);
        if (sanitizedTokens.isNotEmpty) {
          final isReady = await isFtsReady(db.executor, 'products_fts');
          if (isReady) {
            final ftsWhere = List<String>.from(where);
            final ftsArgs = List<Object?>.from(args);
            ftsWhere.add('fts.products_fts MATCH ?');
            ftsArgs.add(sanitizedTokens);

            final ftsJoin = 'JOIN products_fts fts ON fts.rowid = p.id';
            final sqlQuery = '''
              SELECT DISTINCT p.*, c.name_en as cat_name_en, c.name_bn as cat_name_bn,
                     bm25(fts, 10.0, 5.0, 3.0, 1.0) AS bm25_rank
              FROM products p
              $ftsJoin
              LEFT JOIN categories c ON c.id = p.category_id
              $join
              WHERE ${ftsWhere.join(' AND ')}
              ORDER BY bm25_rank ASC
            ''';
            try {
              final ftsRows = await db.executor.customQuery(sqlQuery, ftsArgs);
              ftsCandidateList.addAll(ftsRows);
            } catch (_) {}
          }
        }
      }

      // 1b. Trigram FTS query (for mid-word, SKU, and code substring matching)
      if ((scope == SearchScope.all || scope == SearchScope.name) && trimmed.length >= 3) {
        final isTrigramReady = await isFtsReady(db.executor, 'products_trigram_fts');
        if (isTrigramReady) {
          final triWhere = List<String>.from(where);
          final triArgs = List<Object?>.from(args);
          triWhere.add('tri.products_trigram_fts MATCH ?');
          triArgs.add('"$trimmed"');

          final triJoin = 'JOIN products_trigram_fts tri ON tri.rowid = p.id';
          final triSqlQuery = '''
            SELECT DISTINCT p.*, c.name_en as cat_name_en, c.name_bn as cat_name_bn
            FROM products p
            $triJoin
            LEFT JOIN categories c ON c.id = p.category_id
            $join
            WHERE ${triWhere.join(' AND ')}
          ''';
          try {
            final triRows = await db.executor.customQuery(triSqlQuery, triArgs);
            triCandidateList.addAll(triRows);
          } catch (_) {}
        }
      }

      // 2. Scope-based LIKE query
      final pattern = '%$trimmed%';
      final baseWhere = List<String>.from(where);
      final baseArgs = List<Object?>.from(args);

      final likeWhere = List<String>.from(baseWhere);
      final likeArgs = List<Object?>.from(baseArgs);

      switch (scope) {
        case SearchScope.symptom:
          likeWhere.add('''
            EXISTS (
              SELECT 1 FROM indications ind 
              WHERE ind.product_id = p.id AND (ind.text_en LIKE ? OR ind.text_bn LIKE ?)
            )
          ''');
          likeArgs.addAll([pattern, pattern]);
          break;

        case SearchScope.ingredient:
          likeWhere.add('''
            EXISTS (
              SELECT 1 FROM compositions comp 
              WHERE comp.product_id = p.id AND (comp.ingredient_en LIKE ? OR comp.ingredient_bn LIKE ?)
            )
          ''');
          likeArgs.addAll([pattern, pattern]);
          break;

        case SearchScope.name:
          likeWhere.add('(p.title_en LIKE ? OR p.title_bn LIKE ? OR p.short_description_en LIKE ? OR p.short_description_bn LIKE ?)');
          likeArgs.addAll([pattern, pattern, pattern, pattern]);
          break;

        case SearchScope.all:
          likeWhere.add('''
            (
              p.title_en LIKE ? OR p.title_bn LIKE ? OR 
              p.short_description_en LIKE ? OR p.short_description_bn LIKE ? OR 
              c.name_en LIKE ? OR c.name_bn LIKE ? OR
              EXISTS (SELECT 1 FROM compositions comp WHERE comp.product_id = p.id AND (comp.ingredient_en LIKE ? OR comp.ingredient_bn LIKE ?)) OR
              EXISTS (SELECT 1 FROM indications ind WHERE ind.product_id = p.id AND (ind.text_en LIKE ? OR ind.text_bn LIKE ?))
            )
          ''');
          likeArgs.addAll([pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern]);
          break;
      }

      final likeSqlQuery = '''
        SELECT DISTINCT p.*, c.name_en as cat_name_en, c.name_bn as cat_name_bn FROM products p
        LEFT JOIN categories c ON c.id = p.category_id
        $join
        WHERE ${likeWhere.join(' AND ')}
      ''';
      try {
        final likeRows = await db.executor.customQuery(likeSqlQuery, likeArgs);
        likeCandidateList.addAll(likeRows);
      } catch (_) {}

      // 3. Fuzzy fallback query
      try {
        final fuzzyRows = await _fuzzyFallbackSearch(trimmed, baseWhere, baseArgs, join);
        fuzzyCandidateList.addAll(fuzzyRows);
      } catch (_) {}

      // 4. Perform Hybrid Search Fusion via Reciprocal Rank Fusion (RRF)
      final activeRankedLists = <List<Map<String, dynamic>>>[];
      if (ftsCandidateList.isNotEmpty) activeRankedLists.add(ftsCandidateList);
      if (triCandidateList.isNotEmpty) activeRankedLists.add(triCandidateList);
      if (likeCandidateList.isNotEmpty) activeRankedLists.add(likeCandidateList);
      if (fuzzyCandidateList.isNotEmpty) activeRankedLists.add(fuzzyCandidateList);

      final fusedCandidates = reciprocalRankFusion<Map<String, dynamic>>(
        rankedResultLists: activeRankedLists,
        getId: (row) => (row['id'] as int).toString(),
        k: 60,
      );

      // Score and sort all candidate results with Tier Precedence
      final qLower = trimmed.toLowerCase();
      int getScore(Map<String, dynamic> row) {
        final titleEn = (row['title_en'] as String? ?? '').toLowerCase();
        final titleBn = (row['title_bn'] as String? ?? '').toLowerCase();
        final catEn = (row['cat_name_en'] as String? ?? row['category_en'] as String? ?? '').toLowerCase();
        final catBn = (row['cat_name_bn'] as String? ?? row['category_bn'] as String? ?? '').toLowerCase();

        // Priority Tier 1: Exact title match
        if (titleEn == qLower || titleBn == qLower) return 1;

        // Priority Tier 2: Title starts with query
        if (titleEn.startsWith(qLower) || titleBn.startsWith(qLower)) return 2;

        // Priority Tier 3: Any word in title starts with query
        final wordsEn = titleEn.split(RegExp(r'\s+'));
        for (final w in wordsEn) {
          if (w.startsWith(qLower)) return 3;
        }

        // Priority Tier 4: Title contains query
        if (titleEn.contains(qLower) || titleBn.contains(qLower)) return 4;

        // Priority Tier 5: Category exact match
        if (catEn == qLower || catBn == qLower) return 5;

        // Priority Tier 6: Category contains query
        if (catEn.contains(qLower) || catBn.contains(qLower)) return 6;

        // Priority Tier 7: Other field matches (composition, indication, description, FTS, fuzzy)
        return 7;
      }

      final sortedList = List<Map<String, dynamic>>.from(fusedCandidates);
      sortedList.sort((a, b) {
        final scoreA = getScore(a);
        final scoreB = getScore(b);
        if (scoreA != scoreB) return scoreA.compareTo(scoreB);
        final titleA = (a['title_en'] as String? ?? '').toLowerCase();
        final titleB = (b['title_en'] as String? ?? '').toLowerCase();
        return titleA.compareTo(titleB);
      });

      rows = sortedList.skip(offset).take(limit).toList();
    } else {
      final sqlQuery = '''
        SELECT DISTINCT p.* FROM products p
        $join
        WHERE ${where.join(' AND ')}
        $orderBy
        LIMIT ? OFFSET ?
      ''';
      rows = await db.executor.customQuery(sqlQuery, [...args, limit, offset]);
    }

    final products = await _hydrateList(rows.map(Product.fromRow).toList());
    final labels = products.map((p) => p.toLabel()).toList();

    if (trimmed.isNotEmpty && offset == 0) {
      _searchCache.put(cacheKey, labels);
    }

    return labels;
  }

  Future<List<Product>> getByManufacturer(
    int manufacturerId, {
    bool activeOnly = true,
  }) async {
    final where = <String>['manufacturer_id = ?'];
    final args = <Object?>[manufacturerId];
    if (activeOnly) where.add('is_active = 1');
    final rows = await db.executor.query(
      'products',
      where: where.join(' AND '),
      whereArgs: args,
      orderBy: 'title_en',
    );
    return _hydrateList(rows.map(Product.fromRow).toList());
  }

  /// Fuzzy fallback search using Levenshtein distance matching on product title and category.
  Future<List<Map<String, dynamic>>> _fuzzyFallbackSearch(
    String query,
    List<String> baseWhere,
    List<Object?> baseArgs,
    String joinSql,
  ) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.length < 2) return [];

    final sqlQuery = '''
      SELECT DISTINCT p.*, c.name_en as cat_en, c.name_bn as cat_bn FROM products p
      LEFT JOIN categories c ON c.id = p.category_id
      $joinSql
      ${baseWhere.isNotEmpty ? 'WHERE ${baseWhere.join(' AND ')}' : ''}
    ''';
    final candidates = await db.executor.customQuery(sqlQuery, baseArgs);
    if (candidates.isEmpty) return [];

    return compute(
      computeFuzzyFallbackScores,
      FuzzyCandidateInput(query: query, candidates: candidates),
    );
  }

  /// Retrieves products that are alike / similar to the specified [productId]
  /// based on matching active ingredients (compositions), indications, or category.
  Future<List<Product>> getAlikeProducts(int productId, {int limit = 10}) async {
    final compositions = await _getCompositions(productId);
    final targetProductRows = await db.executor.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (targetProductRows.isEmpty) return const [];
    final categoryId = targetProductRows.first['category_id'] as int?;

    final ingredientTokens = compositions
        .map((c) => c.ingredientEn.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final where = <String>['p.id != ?', 'p.is_active = 1'];
    final args = <Object?>[productId];

    final conditions = <String>[];
    if (ingredientTokens.isNotEmpty) {
      for (final ing in ingredientTokens.take(3)) {
        conditions.add('''
          EXISTS (
            SELECT 1 FROM compositions comp 
            WHERE comp.product_id = p.id AND (comp.ingredient_en LIKE ? OR comp.ingredient_bn LIKE ?)
          )
        ''');
        final pat = '%$ing%';
        args.addAll([pat, pat]);
      }
    }

    if (categoryId != null) {
      conditions.add('p.category_id = ?');
      args.add(categoryId);
    }

    if (conditions.isNotEmpty) {
      where.add('(${conditions.join(' OR ')})');
    }

    final sqlQuery = '''
      SELECT DISTINCT p.* FROM products p
      WHERE ${where.join(' AND ')}
      LIMIT ?
    ''';
    args.add(limit);

    final rows = await db.executor.customQuery(sqlQuery, args);
    return _hydrateList(rows.map(Product.fromRow).toList());
  }

  // ------------------------------------------------------------
  // Full-text search (replaces LIKE '%query%')
  // ------------------------------------------------------------

  Future<List<Product>> search(String query, {int limit = 50}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final labels = await getFilteredLabels(query: trimmed, limit: limit, offset: 0);
    if (labels.isEmpty) return [];

    final ids = labels.map((l) => l.id).toList();
    final where = <String>['p.id IN (${ids.map((_) => '?').join(',')})'];
    final rows = await db.executor.customQuery(
      'SELECT DISTINCT p.* FROM products p WHERE ${where.first}',
      ids,
    );
    final rowMap = { for (var r in rows) r['id'] as int : r };
    final orderedRows = ids.map((id) => rowMap[id]).whereType<Map<String, dynamic>>().toList();
    return _hydrateList(orderedRows.map(Product.fromRow).toList());
  }

  // ------------------------------------------------------------
  // Relation loaders
  // ------------------------------------------------------------

  Future<List<int>> _getTargetGroupIds(int productId) async {
    final rows = await db.executor.query(
      'product_target_groups',
      columns: ['target_group_id'],
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    return rows.map((r) => r['target_group_id'] as int).toList();
  }

  Future<List<Composition>> _getCompositions(int productId) async {
    final rows = await db.executor.query(
      'compositions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Composition.fromRow).toList();
  }

  Future<List<Indication>> _getIndications(int productId) async {
    final rows = await db.executor.query(
      'indications',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Indication.fromRow).toList();
  }

  Future<List<Direction>> _getDirections(int productId) async {
    final rows = await db.executor.query(
      'directions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Direction.fromRow).toList();
  }

  Future<List<Precaution>> _getPrecautions(int productId) async {
    final rows = await db.executor.query(
      'precautions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Precaution.fromRow).toList();
  }

  Future<List<Presentation>> _getPresentations(int productId) async {
    final rows = await db.executor.query(
      'presentations',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Presentation.fromRow).toList();
  }

  /// Finds close matching product title suggestions using Levenshtein distance
  /// when direct search returns no results.
  Future<List<String>> findFuzzyProductSuggestions(String query, {int maxSuggestions = 3}) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.length < 3) return const [];

    try {
      final rows = await db.executor.customQuery(
        'SELECT DISTINCT title_en FROM products WHERE title_en IS NOT NULL LIMIT 200'
      );
      
      final candidates = <MapEntry<String, int>>[];
      for (final row in rows) {
        final title = row['title_en'] as String?;
        if (title == null || title.isEmpty) continue;
        final titleLower = title.toLowerCase();
        
        // Calculate distance on full title or first word
        final firstWord = titleLower.split(' ').first;
        final dist = levenshteinDistance(trimmed, firstWord);
        
        if (dist > 0 && dist <= 2) {
          candidates.add(MapEntry(title, dist));
        }
      }

      candidates.sort((a, b) => a.value.compareTo(b.value));
      return candidates.map((e) => e.key).take(maxSuggestions).toList();
    } catch (_) {
      return const [];
    }
  }

  /// Retrieves all product titles, category names, and target group names
  /// for pre-populating the in-memory Autocomplete Trie.
  Future<List<String>> getAllSearchTerms() async {
    final terms = <String>{};
    try {
      final titleRows = await db.executor.customQuery(
        'SELECT DISTINCT title_en, title_bn FROM products WHERE is_active = 1'
      );
      for (final r in titleRows) {
        final en = r['title_en'] as String?;
        final bn = r['title_bn'] as String?;
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      final catRows = await db.executor.customQuery(
        'SELECT DISTINCT name_en, name_bn FROM categories'
      );
      for (final r in catRows) {
        final en = r['name_en'] as String?;
        final bn = r['name_bn'] as String?;
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      final tgRows = await db.executor.customQuery(
        'SELECT DISTINCT name_en, name_bn FROM target_groups'
      );
      for (final r in tgRows) {
        final en = r['name_en'] as String?;
        final bn = r['name_bn'] as String?;
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      final indRows = await db.executor.customQuery(
        'SELECT DISTINCT text_en, text_bn FROM indications'
      );
      for (final r in indRows) {
        final en = r['text_en'] as String?;
        final bn = r['text_bn'] as String?;
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      final compRows = await db.executor.customQuery(
        'SELECT DISTINCT ingredient_en, ingredient_bn FROM compositions'
      );
      for (final r in compRows) {
        final en = r['ingredient_en'] as String?;
        final bn = r['ingredient_bn'] as String?;
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }
    } catch (e, st) {
      debugPrint('Error fetching search terms for trie: $e\n$st');
    }
    return terms.toList();
  }
}
