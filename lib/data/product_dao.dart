import 'package:impulse_dex/data/fts_utils.dart';
// Data access layer for products.db (schema v2).
// Built on sqflite. See products_schema.sql and products_db_changes.md.

import 'package:impulse_dex/models/product.dart';
import 'package:drift/drift.dart';
import 'package:impulse_dex/data/db_extensions.dart';

import 'package:impulse_dex/data/lookup_dao.dart';
import 'package:impulse_dex/data/manufacturer_dao.dart';

class ProductDao {
  final QueryExecutor db;
  final LookupDao lookupDao;
  final ManufacturerDao manufacturerDao;

  ProductDao(this.db, this.lookupDao, {ManufacturerDao? manufacturerDao})
      : manufacturerDao = manufacturerDao ?? ManufacturerDao(db);

  // ------------------------------------------------------------
  // Single product, fully hydrated (Product Detail Page)
  // ------------------------------------------------------------

  Future<Product?> getById(int id) async {
    final rows = await db.query(
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
    final placeholders = List.filled(productIds.length, '?').join(',');

    // Fetch target groups in batch
    final tgRows = await db.customQuery('''
      SELECT product_id, target_group_id 
      FROM product_target_groups 
      WHERE product_id IN ($placeholders)
    ''', productIds);

    final tgMap = <int, List<int>>{};
    for (final r in tgRows) {
      final pid = r['product_id'] as int;
      final tgid = r['target_group_id'] as int;
      tgMap.putIfAbsent(pid, () => []).add(tgid);
    }

    // Fetch presentations in batch
    final presRows = await db.customQuery('''
      SELECT * FROM presentations 
      WHERE product_id IN ($placeholders)
      ORDER BY display_order
    ''', productIds);

    final presMap = <int, List<Presentation>>{};
    for (final r in presRows) {
      final p = Presentation.fromRow(r);
      presMap.putIfAbsent(p.productId, () => []).add(p);
    }

    // Lookup categories and target groups
    final allCategories = await lookupDao.getCategories();
    final catMap = { for (var c in allCategories) c.id : c };
    
    final allTargetGroups = await lookupDao.getTargetGroups();
    final allTgMap = { for (var tg in allTargetGroups) tg.id : tg };

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
      final rows = await db.customQuery('''
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
    final rows = await db.query(
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
    required int limit,
    required int offset,
  }) async {
    List<Product> products;
    if (query.isNotEmpty) {
      products = await search(query, limit: 1000);
      
      Set<int> feedAdditiveProductIds = {};
      if (isFeedAdditive && products.isNotEmpty) {
        final productIds = products.map((p) => p.id).toList();
        final placeholders = List.filled(productIds.length, '?').join(',');
        final rows = await db.customQuery('''
          SELECT DISTINCT p.id FROM products p
          WHERE p.id IN ($placeholders) AND (
            EXISTS (SELECT 1 FROM presentations pr WHERE pr.product_id = p.id AND pr.bulk_item = 1)
            OR
            EXISTS (
              SELECT 1 FROM directions d 
              JOIN species s ON s.id = d.species_id 
              JOIN target_groups tg ON tg.id = s.target_group_id 
              WHERE d.product_id = p.id AND tg.name_en IN ('Feed Additives', 'Feed Additive')
            )
          )
        ''', productIds);
        feedAdditiveProductIds = rows.map((r) => r['id'] as int).toSet();
      }

      products = products.where((p) {
        if (categoryId != null && p.categoryId != categoryId) return false;
        if (targetGroupId != null && !p.targetGroupIds.contains(targetGroupId)) {
          return false;
        }
        if (isFeedAdditive && !feedAdditiveProductIds.contains(p.id)) {
          return false;
        }
        return true;
      }).toList();

      // manual pagination
      if (offset >= products.length) return [];
      products = products.sublist(
        offset,
        (offset + limit > products.length) ? products.length : offset + limit,
      );
    } else {
      // no query, use db query with pagination
      final where = <String>['p.is_active = 1'];
      final args = <Object?>[];

      String join = '';
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

      final rows = await db.customQuery(
        '''
        SELECT DISTINCT p.* FROM products p
        $join
        WHERE ${where.join(' AND ')}
        ORDER BY p.title_en
        LIMIT ? OFFSET ?
      ''',
        [...args, limit, offset],
      );

      products = await _hydrateList(rows.map(Product.fromRow).toList());
    }
    return products.map((p) => p.toLabel()).toList();
  }

  // ------------------------------------------------------------
  // Manufacturer Detail Page: products by manufacturer.
  // Single WHERE manufacturer_id = ? query now that manufacturers are a
  // standalone entity (no more fuzzy-matching manufacturer name).
  // ------------------------------------------------------------

  Future<List<Product>> getByManufacturer(
    int manufacturerId, {
    bool activeOnly = true,
  }) async {
    final where = <String>['manufacturer_id = ?'];
    final args = <Object?>[manufacturerId];
    if (activeOnly) where.add('is_active = 1');
    final rows = await db.query(
      'products',
      where: where.join(' AND '),
      whereArgs: args,
      orderBy: 'title_en',
    );
    return _hydrateList(rows.map(Product.fromRow).toList());
  }

  // ------------------------------------------------------------
  // Full-text search (replaces LIKE '%query%')
  // ------------------------------------------------------------

  Future<List<Product>> search(String query, {int limit = 50}) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(trimmed);

    try {
      final rows = await db.customQuery(
        '''
        SELECT p.* FROM products p
        JOIN products_fts fts ON fts.rowid = p.id
        WHERE products_fts MATCH ?
        ORDER BY p.title_en
        LIMIT ?
        ''',
        [sanitized, limit],
      );
      return _hydrateList(rows.map(Product.fromRow).toList());
    } catch (e) {
      final pattern = '%$trimmed%';
      final rows = await db.customQuery(
        '''
        SELECT * FROM products
        WHERE title_en LIKE ? OR title_bn LIKE ? OR short_description_en LIKE ? OR short_description_bn LIKE ?
        ORDER BY title_en
        LIMIT ?
        ''',
        [pattern, pattern, pattern, pattern, limit],
      );
      return _hydrateList(rows.map(Product.fromRow).toList());
    }
  }

  // ------------------------------------------------------------
  // Relation loaders
  // ------------------------------------------------------------

  Future<List<int>> _getTargetGroupIds(int productId) async {
    final rows = await db.query(
      'product_target_groups',
      columns: ['target_group_id'],
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    return rows.map((r) => r['target_group_id'] as int).toList();
  }

  Future<List<Composition>> _getCompositions(int productId) async {
    final rows = await db.query(
      'compositions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Composition.fromRow).toList();
  }

  Future<List<Indication>> _getIndications(int productId) async {
    final rows = await db.query(
      'indications',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Indication.fromRow).toList();
  }

  Future<List<Direction>> _getDirections(int productId) async {
    final rows = await db.query(
      'directions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Direction.fromRow).toList();
  }

  Future<List<Precaution>> _getPrecautions(int productId) async {
    final rows = await db.query(
      'precautions',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Precaution.fromRow).toList();
  }

  Future<List<Presentation>> _getPresentations(int productId) async {
    final rows = await db.query(
      'presentations',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'display_order',
    );
    return rows.map(Presentation.fromRow).toList();
  }


}

