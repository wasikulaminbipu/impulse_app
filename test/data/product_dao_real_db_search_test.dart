import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';
import 'package:impulse_app/data/product_dao.dart';
import 'package:impulse_app/domain/search_scope.dart';

void main() {
  group('ProductDao Real Asset DB Search Regression Tests', () {
    late ProductsDb db;
    late LookupDao lookupDao;
    late ManufacturerDao manufacturerDao;
    late ProductDao productDao;

    late Directory tempDir;
    late File tempFile;

    setUp(() async {
      final sourceFile = File('assets/db/products.db');
      expect(
        sourceFile.existsSync(),
        isTrue,
        reason: 'assets/db/products.db must exist',
      );
      tempDir = Directory.systemTemp.createTempSync('products_db_test_');
      tempFile = File('${tempDir.path}/test_products.db');
      sourceFile.copySync(tempFile.path);

      db = ProductsDb(NativeDatabase(tempFile));
      lookupDao = LookupDao(db);
      manufacturerDao = ManufacturerDao(db);
      productDao = ProductDao(db, lookupDao, manufacturerDao: manufacturerDao);
    });

    tearDown(() async {
      await db.close();
      try {
        tempDir.deleteSync(recursive: true);
      } catch (_) {}
    });

    test('Searching on real products.db returns matching products and categories without SQLite column errors', () async {
      final results = await productDao.getFilteredLabels(
        query: 'Aqua',
        limit: 10,
        offset: 0,
      );

      expect(results, isNotEmpty);
      expect(
        results.any((p) => p.titleEn.toLowerCase().contains('aqua')),
        isTrue,
      );
      expect(results.first.category.nameEn, isNotEmpty);
    });

    test('Searching with explicit SearchScope.all and SearchScope.name works on real products.db', () async {
      final allResults = await productDao.getFilteredLabels(
        query: 'Joy',
        limit: 10,
        offset: 0,
      );
      expect(allResults, isNotEmpty);
      expect(allResults.first.titleEn, equals('Aqua Joy'));

      final nameResults = await productDao.getFilteredLabels(
        query: 'Joy',
        scope: SearchScope.name,
        limit: 10,
        offset: 0,
      );
      expect(nameResults, isNotEmpty);
      expect(nameResults.first.titleEn, equals('Aqua Joy'));
    });

    test('Searching with setupProductsFts enabled produces relevance-ranked results', () async {
      await setupProductsFts(db.executor);

      final results = await productDao.getFilteredLabels(
        query: 'Aqua',
        limit: 10,
        offset: 0,
      );

      expect(results, isNotEmpty);
      expect(results.first.titleEn, startsWith('Aqua'));
    });
  });
}
