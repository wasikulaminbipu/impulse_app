import 'package:drift/drift.dart' hide Column;
import 'package:flutter/foundation.dart' hide Category;
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/fts_utils.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';
import 'package:impulse_app/domain/search_scope.dart';
import 'package:impulse_app/models/product.dart';

/// Data access object for querying and hydrating product catalogs.
///
/// Backed by Drift [ProductsDb] and SQLite FTS5 for high-speed indexing,
/// batch-hydrated relations, and LRU search query caching.
class ProductDao {
  final ProductsDb db;
  final LookupDao lookupDao;
  final ManufacturerDao manufacturerDao;
  final SearchQueryCache<ProductLabel> _searchCache =
      SearchQueryCache<ProductLabel>(capacity: 100);

  ProductDao(this.db, this.lookupDao, {ManufacturerDao? manufacturerDao})
    : manufacturerDao = manufacturerDao ?? ManufacturerDao(db);

  Product _mapProductEntity(ProductEntity e) => Product(
    id: e.id,
    manufacturerId: e.manufacturerId,
    categoryId: e.categoryId,
    titleEn: e.titleEn,
    titleBn: e.titleBn,
    slug: e.slug,
    mottoEn: e.mottoEn,
    mottoBn: e.mottoBn,
    shortDescriptionEn: e.shortDescriptionEn,
    shortDescriptionBn: e.shortDescriptionBn,
    imageUrl: e.imageUrl,
    isActive: e.isActive,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    compositionBasisEn: e.compositionBasisEn,
    compositionBasisBn: e.compositionBasisBn,
  );

  /// Fetches a single [Product] by its [id] and fully hydrates all associated
  /// compositions, benefits, indications, directions, precautions, presentations,
  /// manufacturer, category, and target groups. Returns `null` if not found.
  Future<Product?> getById(int id) async {
    final row = await (db.select(
      db.products,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _hydrate(_mapProductEntity(row));
  }

  Future<Product> _hydrate(Product base) async {
    final results = await Future.wait([
      _getTargetGroupIds(base.id),
      _getCompositions(base.id),
      _getBenefits(base.id),
      _getIndications(base.id),
      _getDirections(base.id),
      _getPrecautions(base.id),
      _getPresentations(base.id),
      base.manufacturerId == null
          ? Future<Manufacturer?>.value()
          : manufacturerDao.getById(base.manufacturerId!),
      lookupDao.getCategories(),
      lookupDao.getTargetGroups(),
    ]);

    final tgIds = results[0]! as List<int>;
    final allCategories = results[8]! as List<Category>;
    final allTargetGroups = results[9]! as List<TargetGroup>;

    final catMap = {for (final c in allCategories) c.id: c};
    final allTgMap = {for (final tg in allTargetGroups) tg.id: tg};

    return base.copyWith(
      targetGroupIds: tgIds,
      compositions: results[1]! as List<Composition>,
      benefits: results[2]! as List<Benefit>,
      indications: results[3]! as List<Indication>,
      directions: results[4]! as List<Direction>,
      precautions: results[5]! as List<Precaution>,
      presentations: results[6]! as List<Presentation>,
      manufacturer: (results[7] as Manufacturer?) ?? const Manufacturer.empty(),
      category: catMap[base.categoryId] ?? const Category.empty(),
      targetGroups: tgIds
          .map((id) => allTgMap[id])
          .whereType<TargetGroup>()
          .toList(),
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

    final tgMap = <int, List<int>>{};
    final presMap = <int, List<Presentation>>{};
    const chunkSize = 500;

    for (var i = 0; i < productIds.length; i += chunkSize) {
      final end = (i + chunkSize > productIds.length)
          ? productIds.length
          : i + chunkSize;
      final chunk = productIds.sublist(i, end);

      // Fetch target groups in batch
      final tgRows = await (db.select(
        db.productTargetGroups,
      )..where((t) => t.productId.isIn(chunk))).get();
      for (final r in tgRows) {
        tgMap.putIfAbsent(r.productId, () => []).add(r.targetGroupId);
      }

      // Fetch presentations in batch
      final presRows =
          await (db.select(db.presentations)
                ..where((t) => t.productId.isIn(chunk))
                ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
              .get();
      for (final r in presRows) {
        final p = Presentation(
          id: r.id,
          productId: r.productId,
          productTypeId: r.productTypeId,
          contentTypeId: r.contentTypeId,
          size: r.size,
          mrp: r.mrp,
          imageUrl: r.imageUrl,
          displayOrder: r.displayOrder,
          bulkItem: r.bulkItem == 1,
        );
        presMap.putIfAbsent(p.productId, () => []).add(p);
      }
    }

    // Lookup categories and target groups via cached maps
    final catMap = await lookupDao.getCategoryMap();
    final allTgMap = await lookupDao.getTargetGroupMap();

    return products.map((p) {
      final tgIds = tgMap[p.id] ?? [];
      return p.copyWith(
        category: catMap[p.categoryId] ?? const Category.empty(),
        targetGroupIds: tgIds,
        targetGroups: tgIds
            .map((id) => allTgMap[id])
            .whereType<TargetGroup>()
            .toList(),
        presentations: presMap[p.id] ?? [],
      );
    }).toList();
  }

  Future<List<Product>> getAllLight({
    bool activeOnly = true,
    int? categoryId,
    int? targetGroupId,
  }) async {
    List<Product> products;
    if (targetGroupId != null) {
      final q = db.select(db.products).join([
        innerJoin(
          db.productTargetGroups,
          db.productTargetGroups.productId.equalsExp(db.products.id),
        ),
      ]);
      Expression<bool> predicate = db.productTargetGroups.targetGroupId.equals(
        targetGroupId,
      );
      if (activeOnly) {
        predicate = predicate & db.products.isActive.equals(1);
      }
      if (categoryId != null) {
        predicate = predicate & db.products.categoryId.equals(categoryId);
      }
      q.where(predicate);
      q.orderBy([OrderingTerm.asc(db.products.titleEn)]);
      final rows = await q.get();
      products = rows
          .map((r) => _mapProductEntity(r.readTable(db.products)))
          .toList();
    } else {
      final q = db.select(db.products);
      Expression<bool>? predicate;
      if (activeOnly) {
        predicate = db.products.isActive.equals(1);
      }
      if (categoryId != null) {
        predicate = (predicate != null)
            ? (predicate & db.products.categoryId.equals(categoryId))
            : db.products.categoryId.equals(categoryId);
      }
      if (predicate != null) {
        q.where((_) => predicate!);
      }
      q.orderBy([(t) => OrderingTerm.asc(t.titleEn)]);
      final rows = await q.get();
      products = rows.map(_mapProductEntity).toList();
    }
    return _hydrateList(products);
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
    final trimmed = query.trim();
    final cacheKey =
        '$categoryId:$targetGroupId:$isFeedAdditive:$scope:$trimmed:$limit:$offset';

    if (trimmed.isNotEmpty && offset == 0) {
      final cached = _searchCache.get(cacheKey);
      if (cached != null) return cached;
    }

    Expression<bool> buildBasePredicate() {
      Expression<bool> predicate = db.products.isActive.equals(1);

      if (targetGroupId != null) {
        final hasTg = existsQuery(
          db.selectOnly(db.productTargetGroups)
            ..addColumns([const Constant(1)])
            ..where(
              db.productTargetGroups.productId.equalsExp(db.products.id) &
                  db.productTargetGroups.targetGroupId.equals(targetGroupId),
            ),
        );
        predicate = predicate & hasTg;
      }

      if (categoryId != null) {
        predicate = predicate & db.products.categoryId.equals(categoryId);
      }

      if (isFeedAdditive) {
        final hasBulkPres = existsQuery(
          db.selectOnly(db.presentations)
            ..addColumns([const Constant(1)])
            ..where(
              db.presentations.productId.equalsExp(db.products.id) &
                  db.presentations.bulkItem.equals(1),
            ),
        );
        final hasFeedAdditiveDirection = existsQuery(
          db.selectOnly(db.directions)
            ..addColumns([const Constant(1)])
            ..join([
              innerJoin(
                db.species,
                db.species.id.equalsExp(db.directions.speciesId),
              ),
              innerJoin(
                db.targetGroups,
                db.targetGroups.id.equalsExp(db.species.targetGroupId),
              ),
            ])
            ..where(
              db.directions.productId.equalsExp(db.products.id) &
                  (db.targetGroups.nameEn.equals('Feed Additives') |
                      db.targetGroups.nameEn.equals('Feed Additive')),
            ),
        );
        predicate = predicate & (hasBulkPres | hasFeedAdditiveDirection);
      }
      return predicate;
    }

    if (trimmed.isNotEmpty) {
      final basePredicate = buildBasePredicate();
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
            try {
              final ftsRows = await db
                  .customSelect(
                    'SELECT rowid, bm25(products_fts, 10.0, 10.0, 5.0, 3.0, 2.0, 2.0) AS bm25_rank FROM products_fts WHERE products_fts MATCH ? ORDER BY bm25_rank ASC',
                    variables: [Variable.withString(sanitizedTokens)],
                  )
                  .get();
              if (ftsRows.isNotEmpty) {
                final rankMap = {
                  for (final r in ftsRows)
                    r.read<int>('rowid'): r.read<double>('bm25_rank'),
                };
                final q = db.select(db.products).join([
                  leftOuterJoin(
                    db.categories,
                    db.categories.id.equalsExp(db.products.categoryId),
                  ),
                ])..where(basePredicate & db.products.id.isIn(rankMap.keys));
                final productsWithCat = await q.get();
                for (final r in productsWithCat) {
                  final p = r.readTable(db.products);
                  final c = r.readTableOrNull(db.categories);
                  ftsCandidateList.add(_rowMap(p, c, rankMap[p.id]));
                }
                ftsCandidateList.sort(
                  (a, b) => ((a['bm25_rank'] as num?) ?? 0).compareTo(
                    (b['bm25_rank'] as num?) ?? 0,
                  ),
                );
              }
            } catch (e, st) {
              debugPrint('Product FTS search query error: $e\n$st');
            }
          }
        }

        // 1b. Trigram FTS query (for mid-word, SKU, and code substring matching)
        if (trimmed.length >= 3) {
          final isTrigramReady = await isFtsReady(
            db.executor,
            'products_trigram_fts',
          );
          if (isTrigramReady) {
            try {
              final triRows = await db
                  .customSelect(
                    'SELECT rowid FROM products_trigram_fts WHERE products_trigram_fts MATCH ?',
                    variables: [Variable.withString('"$trimmed"')],
                  )
                  .get();
              if (triRows.isNotEmpty) {
                final triIds = triRows
                    .map((r) => r.read<int>('rowid'))
                    .toList();
                final q = db.select(db.products).join([
                  leftOuterJoin(
                    db.categories,
                    db.categories.id.equalsExp(db.products.categoryId),
                  ),
                ])..where(basePredicate & db.products.id.isIn(triIds));
                final productsWithCat = await q.get();
                for (final r in productsWithCat) {
                  final p = r.readTable(db.products);
                  final c = r.readTableOrNull(db.categories);
                  triCandidateList.add(_rowMap(p, c));
                }
              }
            } catch (e, st) {
              debugPrint('Product Trigram search query error: $e\n$st');
            }
          }
        }
      }

      // 2. Scope-based LIKE query using Drift query builder
      final pattern = '%$trimmed%';
      Expression<bool> scopeCond;
      switch (scope) {
        case SearchScope.symptom:
          scopeCond = existsQuery(
            db.selectOnly(db.indications)
              ..addColumns([const Constant(1)])
              ..where(
                db.indications.productId.equalsExp(db.products.id) &
                    (db.indications.textEn.like(pattern) |
                        db.indications.textBn.like(pattern)),
              ),
          );
        case SearchScope.ingredient:
          scopeCond = existsQuery(
            db.selectOnly(db.compositions)
              ..addColumns([const Constant(1)])
              ..where(
                db.compositions.productId.equalsExp(db.products.id) &
                    (db.compositions.ingredientEn.like(pattern) |
                        db.compositions.ingredientBn.like(pattern)),
              ),
          );
        case SearchScope.name:
          scopeCond =
              db.products.titleEn.like(pattern) |
              db.products.titleBn.like(pattern) |
              db.products.shortDescriptionEn.like(pattern) |
              db.products.shortDescriptionBn.like(pattern);
        case SearchScope.all:
          final inComp = existsQuery(
            db.selectOnly(db.compositions)
              ..addColumns([const Constant(1)])
              ..where(
                db.compositions.productId.equalsExp(db.products.id) &
                    (db.compositions.ingredientEn.like(pattern) |
                        db.compositions.ingredientBn.like(pattern)),
              ),
          );
          final inBen = existsQuery(
            db.selectOnly(db.benefits)
              ..addColumns([const Constant(1)])
              ..where(
                db.benefits.productId.equalsExp(db.products.id) &
                    (db.benefits.textEn.like(pattern) |
                        db.benefits.textBn.like(pattern)),
              ),
          );
          final inInd = existsQuery(
            db.selectOnly(db.indications)
              ..addColumns([const Constant(1)])
              ..where(
                db.indications.productId.equalsExp(db.products.id) &
                    (db.indications.textEn.like(pattern) |
                        db.indications.textBn.like(pattern)),
              ),
          );
          scopeCond =
              db.products.titleEn.like(pattern) |
              db.products.titleBn.like(pattern) |
              db.products.shortDescriptionEn.like(pattern) |
              db.products.shortDescriptionBn.like(pattern) |
              db.categories.nameEn.like(pattern) |
              db.categories.nameBn.like(pattern) |
              inComp |
              inBen |
              inInd;
      }

      try {
        final likeQuery = db.select(db.products).join([
          leftOuterJoin(
            db.categories,
            db.categories.id.equalsExp(db.products.categoryId),
          ),
        ])..where(basePredicate & scopeCond);
        final likeRows = await likeQuery.get();
        for (final r in likeRows) {
          final p = r.readTable(db.products);
          final c = r.readTableOrNull(db.categories);
          likeCandidateList.add(_rowMap(p, c));
        }
      } catch (e, st) {
        debugPrint('Product LIKE search query error: $e\n$st');
      }

      // 3. Fuzzy fallback query
      try {
        final fuzzyRows = await _fuzzyFallbackSearch(trimmed, basePredicate);
        fuzzyCandidateList.addAll(fuzzyRows);
      } catch (e, st) {
        debugPrint('Product fuzzy search query error: $e\n$st');
      }

      // 4. Perform Hybrid Search Fusion via Reciprocal Rank Fusion (RRF)
      final activeRankedLists = <List<Map<String, dynamic>>>[];
      if (ftsCandidateList.isNotEmpty) {
        activeRankedLists.add(ftsCandidateList);
      }
      if (triCandidateList.isNotEmpty) {
        activeRankedLists.add(triCandidateList);
      }
      if (likeCandidateList.isNotEmpty) {
        activeRankedLists.add(likeCandidateList);
      }
      if (fuzzyCandidateList.isNotEmpty) {
        activeRankedLists.add(fuzzyCandidateList);
      }

      final fusedCandidates = reciprocalRankFusion<Map<String, dynamic>>(
        rankedResultLists: activeRankedLists,
        getId: (row) => (row['id'] as int).toString(),
      );

      // Score and sort all candidate results with Tier Precedence
      final qLower = trimmed.toLowerCase();
      int getScore(Map<String, dynamic> row) {
        final titleEn = (row['title_en'] as String? ?? '').toLowerCase();
        final titleBn = (row['title_bn'] as String? ?? '').toLowerCase();
        final catEn =
            (row['cat_name_en'] as String? ??
                    row['category_en'] as String? ??
                    '')
                .toLowerCase();
        final catBn =
            (row['cat_name_bn'] as String? ??
                    row['category_bn'] as String? ??
                    '')
                .toLowerCase();

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

      final rows = sortedList.skip(offset).take(limit).toList();
      final products = await _hydrateList(rows.map(Product.fromRow).toList());
      final labels = products.map((p) => p.toLabel()).toList();

      if (trimmed.isNotEmpty && offset == 0) {
        _searchCache.put(cacheKey, labels);
      }

      return labels;
    } else {
      // Direct type-safe Drift query for non-search browsing
      final q = db.select(db.products, distinct: true)
        ..where((_) => buildBasePredicate())
        ..orderBy([(t) => OrderingTerm.asc(t.titleEn)])
        ..limit(limit, offset: offset);

      final entityRows = await q.get();
      final products = await _hydrateList(
        entityRows.map(_mapProductEntity).toList(),
      );
      return products.map((p) => p.toLabel()).toList();
    }
  }

  Future<List<Product>> getByManufacturer(
    int manufacturerId, {
    bool activeOnly = true,
  }) async {
    final q = db.select(db.products)
      ..where(
        (t) =>
            t.manufacturerId.equals(manufacturerId) &
            (activeOnly ? t.isActive.equals(1) : const Constant(true)),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.titleEn)]);
    final rows = await q.get();
    return _hydrateList(rows.map(_mapProductEntity).toList());
  }

  Map<String, dynamic> _rowMap(
    ProductEntity p,
    CategoryEntity? c, [
    double? bm25Rank,
  ]) {
    return {
      'id': p.id,
      'title_en': p.titleEn,
      'title_bn': p.titleBn,
      'slug': p.slug,
      'category_id': p.categoryId,
      'manufacturer_id': p.manufacturerId,
      'image_url': p.imageUrl,
      'motto_en': p.mottoEn,
      'motto_bn': p.mottoBn,
      'composition_basis_en': p.compositionBasisEn,
      'composition_basis_bn': p.compositionBasisBn,
      'short_description_en': p.shortDescriptionEn,
      'short_description_bn': p.shortDescriptionBn,
      'is_active': p.isActive,
      'created_at': p.createdAt,
      'updated_at': p.updatedAt,
      'cat_name_en': c?.nameEn,
      'cat_name_bn': c?.nameBn,
      'category_en': c?.nameEn,
      'category_bn': c?.nameBn,
      'cat_en': c?.nameEn,
      'cat_bn': c?.nameBn,
      'bm25_rank': ?bm25Rank,
    };
  }

  /// Fuzzy fallback search using Levenshtein distance matching on product title and category.
  Future<List<Map<String, dynamic>>> _fuzzyFallbackSearch(
    String query,
    Expression<bool> basePredicate,
  ) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.length < 2) return [];

    final q = db.select(db.products).join([
      leftOuterJoin(
        db.categories,
        db.categories.id.equalsExp(db.products.categoryId),
      ),
    ])..where(basePredicate);

    final rows = await q.get();
    final candidates = rows.map((r) {
      final p = r.readTable(db.products);
      final c = r.readTableOrNull(db.categories);
      return _rowMap(p, c);
    }).toList();
    if (candidates.isEmpty) return [];

    return compute(
      computeFuzzyFallbackScores,
      FuzzyCandidateInput(query: query, candidates: candidates),
    );
  }

  /// Retrieves products that are alike / similar to the specified [productId]
  /// based on matching active ingredients (compositions), indications, or category.
  Future<List<Product>> getAlikeProducts(
    int productId, {
    int limit = 10,
  }) async {
    final compositions = await _getCompositions(productId);
    final targetProduct = await (db.select(
      db.products,
    )..where((t) => t.id.equals(productId))).getSingleOrNull();

    if (targetProduct == null) return const [];
    final categoryId = targetProduct.categoryId;

    final ingredientTokens = compositions
        .map((c) => c.ingredientEn.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final q = db.select(db.products, distinct: true);
    Expression<bool> predicate =
        db.products.id.equals(productId).not() & db.products.isActive.equals(1);

    Expression<bool>? conditions;
    if (ingredientTokens.isNotEmpty) {
      for (final ing in ingredientTokens.take(3)) {
        final pat = '%$ing%';
        final matchIng = existsQuery(
          db.selectOnly(db.compositions)
            ..addColumns([const Constant(1)])
            ..where(
              db.compositions.productId.equalsExp(db.products.id) &
                  (db.compositions.ingredientEn.like(pat) |
                      db.compositions.ingredientBn.like(pat)),
            ),
        );
        conditions = (conditions != null) ? (conditions | matchIng) : matchIng;
      }
    }

    final matchCat = db.products.categoryId.equals(categoryId);
    conditions = (conditions != null) ? (conditions | matchCat) : matchCat;
    predicate = predicate & conditions;

    q.where((_) => predicate);
    q.limit(limit);

    final rows = await q.get();
    return _hydrateList(rows.map(_mapProductEntity).toList());
  }

  // ------------------------------------------------------------
  // Full-text search (replaces LIKE '%query%')
  // ------------------------------------------------------------

  Future<List<Product>> search(String query, {int limit = 50}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final labels = await getFilteredLabels(
      query: trimmed,
      limit: limit,
      offset: 0,
    );
    if (labels.isEmpty) return [];

    final ids = labels.map((l) => l.id).toList();
    final rows = await (db.select(
      db.products,
    )..where((t) => t.id.isIn(ids))).get();
    final rowMap = {for (final r in rows) r.id: _mapProductEntity(r)};
    final orderedRows = ids
        .map((id) => rowMap[id])
        .whereType<Product>()
        .toList();
    return _hydrateList(orderedRows);
  }

  // ------------------------------------------------------------
  // Relation loaders
  // ------------------------------------------------------------

  Future<List<int>> _getTargetGroupIds(int productId) async {
    final rows = await (db.select(
      db.productTargetGroups,
    )..where((t) => t.productId.equals(productId))).get();
    return rows.map((r) => r.targetGroupId).toList();
  }

  Future<List<Composition>> _getCompositions(int productId) async {
    final rows =
        await (db.select(db.compositions)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Composition(
            id: r.id,
            productId: r.productId,
            ingredientEn: r.ingredientEn,
            ingredientBn: r.ingredientBn,
            concentration: r.concentration,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  Future<List<Benefit>> _getBenefits(int productId) async {
    final rows =
        await (db.select(db.benefits)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Benefit(
            id: r.id,
            productId: r.productId,
            textEn: r.textEn,
            textBn: r.textBn,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  Future<List<Indication>> _getIndications(int productId) async {
    final rows =
        await (db.select(db.indications)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Indication(
            id: r.id,
            productId: r.productId,
            textEn: r.textEn,
            textBn: r.textBn,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  Future<List<Direction>> _getDirections(int productId) async {
    final rows =
        await (db.select(db.directions)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Direction(
            id: r.id,
            productId: r.productId,
            contentTypeId: r.contentTypeId,
            speciesId: r.speciesId,
            doseValueMin: r.doseValueMin,
            doseValueMax: r.doseValueMax,
            doseUnitId: r.doseUnitId,
            doseBasisId: r.doseBasisId,
            durationDaysMin: r.durationDaysMin,
            durationDaysMax: r.durationDaysMax,
            administrationEn: r.administrationEn,
            administrationBn: r.administrationBn,
            dosageEn: r.dosageEn,
            dosageBn: r.dosageBn,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  Future<List<Precaution>> _getPrecautions(int productId) async {
    final rows =
        await (db.select(db.precautions)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Precaution(
            id: r.id,
            productId: r.productId,
            textEn: r.textEn,
            textBn: r.textBn,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  Future<List<Presentation>> _getPresentations(int productId) async {
    final rows =
        await (db.select(db.presentations)
              ..where((t) => t.productId.equals(productId))
              ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
            .get();
    return rows
        .map(
          (r) => Presentation(
            id: r.id,
            productId: r.productId,
            productTypeId: r.productTypeId,
            contentTypeId: r.contentTypeId,
            size: r.size,
            mrp: r.mrp,
            imageUrl: r.imageUrl,
            displayOrder: r.displayOrder,
            bulkItem: r.bulkItem == 1,
          ),
        )
        .toList();
  }

  /// Finds close matching product title suggestions using Levenshtein distance
  /// when direct search returns no results.
  Future<List<String>> findFuzzyProductSuggestions(
    String query, {
    int maxSuggestions = 3,
  }) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.length < 3) return const [];

    try {
      final q = db.selectOnly(db.products, distinct: true)
        ..addColumns([db.products.titleEn])
        ..where(db.products.titleEn.isNotNull())
        ..limit(200);
      final rows = await q.get();

      final candidates = <MapEntry<String, int>>[];
      for (final row in rows) {
        final title = row.read(db.products.titleEn);
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
      // 1. Products
      final titleQuery = db.selectOnly(db.products, distinct: true)
        ..addColumns([db.products.titleEn, db.products.titleBn])
        ..where(db.products.isActive.equals(1));
      final titleRows = await titleQuery.get();
      for (final r in titleRows) {
        final en = r.read(db.products.titleEn);
        final bn = r.read(db.products.titleBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      // 2. Categories
      final catQuery = db.selectOnly(db.categories, distinct: true)
        ..addColumns([db.categories.nameEn, db.categories.nameBn]);
      final catRows = await catQuery.get();
      for (final r in catRows) {
        final en = r.read(db.categories.nameEn);
        final bn = r.read(db.categories.nameBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      // 3. Target Groups
      final tgQuery = db.selectOnly(db.targetGroups, distinct: true)
        ..addColumns([db.targetGroups.nameEn, db.targetGroups.nameBn]);
      final tgRows = await tgQuery.get();
      for (final r in tgRows) {
        final en = r.read(db.targetGroups.nameEn);
        final bn = r.read(db.targetGroups.nameBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      // 4. Benefits
      final benQuery = db.selectOnly(db.benefits, distinct: true)
        ..addColumns([db.benefits.textEn, db.benefits.textBn]);
      final benRows = await benQuery.get();
      for (final r in benRows) {
        final en = r.read(db.benefits.textEn);
        final bn = r.read(db.benefits.textBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      // 5. Indications
      final indQuery = db.selectOnly(db.indications, distinct: true)
        ..addColumns([db.indications.textEn, db.indications.textBn]);
      final indRows = await indQuery.get();
      for (final r in indRows) {
        final en = r.read(db.indications.textEn);
        final bn = r.read(db.indications.textBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }

      // 6. Compositions
      final compQuery = db.selectOnly(db.compositions, distinct: true)
        ..addColumns([
          db.compositions.ingredientEn,
          db.compositions.ingredientBn,
        ]);
      final compRows = await compQuery.get();
      for (final r in compRows) {
        final en = r.read(db.compositions.ingredientEn);
        final bn = r.read(db.compositions.ingredientBn);
        if (en != null && en.isNotEmpty) terms.add(en);
        if (bn != null && bn.isNotEmpty) terms.add(bn);
      }
    } catch (e, st) {
      debugPrint('Error fetching search terms for trie: $e\n$st');
    }
    return terms.toList();
  }
}
