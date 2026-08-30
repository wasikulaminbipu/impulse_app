import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/product_dao.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/fts_utils.dart';
import 'package:impulse_app/utils/search_analytics.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Search Engine Expert Enhancement Tests', () {
    late ProductsDb db;
    late ProductDao productDao;
    late LookupDao lookupDao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      lookupDao = LookupDao(db);
      productDao = ProductDao(db, lookupDao);

      // Create FTS virtual table & mark ready for testing
      await db.executor.runCustom('''
        CREATE VIRTUAL TABLE IF NOT EXISTS products_fts
        USING fts5(
          title_en,
          title_bn,
          motto_en,
          short_description_en,
          category_en,
          category_bn,
          tokenize='unicode61 remove_diacritics 2'
        );
      ''');

      await db.executor.runCustom('''
        CREATE VIRTUAL TABLE IF NOT EXISTS products_trigram_fts
        USING fts5(
          title_en,
          title_bn,
          slug,
          tokenize='trigram'
        );
      ''');

      await db.executor.runCustom('''
        CREATE TABLE IF NOT EXISTS db_meta (
          key TEXT PRIMARY KEY,
          value TEXT NOT NULL
        );
      ''');

      await db.executor.runCustom(
        "INSERT OR REPLACE INTO db_meta (key, value) VALUES ('fts_ready_products_fts', '1');",
      );
      await db.executor.runCustom(
        "INSERT OR REPLACE INTO db_meta (key, value) VALUES ('fts_ready_products_trigram_fts', '1');",
      );

      // Insert dummy category
      await db.into(db.categories).insert(
        CategoriesCompanion.insert(
          id: const Value(1),
          nameEn: 'Veterinary Antibiotics',
          nameBn: 'ভেটেরিনারি অ্যান্টিবায়োটিক',
        ),
      );

      // Product 1: Title "Amoxivet 500", Category 1
      await db.into(db.products).insert(
        ProductsCompanion.insert(
          id: const Value(100),
          titleEn: 'Amoxivet 500',
          titleBn: const Value('অ্যামোক্সিভেট ৫০০'),
          slug: 'amoxivet-500',
          categoryId: 1,
          isActive: const Value(1),
        ),
      );

      // Product 2: Title "Ciprovet Injection", Category 1
      await db.into(db.products).insert(
        ProductsCompanion.insert(
          id: const Value(101),
          titleEn: 'Ciprovet Injection',
          titleBn: const Value('সিপ্রোভেট ইনজেকশন'),
          slug: 'ciprovet-injection',
          categoryId: 1,
          isActive: const Value(1),
        ),
      );

      // Populate FTS tables
      await db.executor.runCustom('''
        INSERT INTO products_fts(rowid, title_en, title_bn, motto_en, short_description_en, category_en, category_bn)
        VALUES 
          (100, 'Amoxivet 500', 'অ্যামোক্সিভেট ৫০০', '', '', 'Veterinary Antibiotics', 'ভেটেরিনারি অ্যান্টিবায়োটিক'),
          (101, 'Ciprovet Injection', 'সিপ্রোভেট ইনজেকশন', '', '', 'Veterinary Antibiotics', 'ভেটেরিনারি অ্যান্টিবায়োটিক');
      ''');

      await db.executor.runCustom('''
        INSERT INTO products_trigram_fts(rowid, title_en, title_bn, slug)
        VALUES 
          (100, 'Amoxivet 500', 'অ্যামোক্সিভেট ৫০০', 'amoxivet-500'),
          (101, 'Ciprovet Injection', 'সিপ্রোভেট ইনজেকশন', 'ciprovet-injection');
      ''');
    });

    tearDown(() async {
      SearchAnalyticsTracker.clearListeners();
      await db.close();
    });

    test('1. FTS5 BM25 native relevance query succeeds without errors', () async {
      final results = await productDao.getFilteredLabels(
        query: 'Amoxivet',
        limit: 10,
        offset: 0,
      );
      expect(results, isNotEmpty);
      expect(results.first.titleEn, equals('Amoxivet 500'));
    });

    test('2. Top-level computeFuzzyFallbackScores calculates distances correctly', () {
      final candidates = [
        {
          'id': 100,
          'title_en': 'Amoxivet 500',
          'title_bn': 'অ্যামোক্সিভেট ৫০০',
          'cat_en': 'Veterinary Antibiotics',
          'cat_bn': 'ভেটেরিনারি অ্যান্টিবায়োটিক',
        },
        {
          'id': 101,
          'title_en': 'Ciprovet Injection',
          'title_bn': 'সিপ্রোভেট ইনজেকশন',
          'cat_en': 'Veterinary Antibiotics',
          'cat_bn': 'ভেটেরিনারি অ্যান্টিবায়োটিক',
        },
      ];

      final input = FuzzyCandidateInput(query: 'Amoxvet', candidates: candidates);
      final scored = computeFuzzyFallbackScores(input);

      expect(scored, isNotEmpty);
      expect(scored.first['title_en'], equals('Amoxivet 500'));
    });

    test('3. SearchAnalyticsTracker notifies registered telemetry listeners', () {
      SearchAnalyticsEvent? executedEvent;
      SearchAnalyticsEvent? zeroResultEvent;

      SearchAnalyticsTracker.registerListeners(
        onSearchExecuted: (event) => executedEvent = event,
        onZeroResultQuery: (event) => zeroResultEvent = event,
      );

      // Non-zero result search
      SearchAnalyticsTracker.logSearch(
        query: 'Amoxivet',
        resultCount: 5,
        executionTimeMs: 12,
        categoryOrScope: 'all',
      );

      expect(executedEvent, isNotNull);
      expect(executedEvent!.query, equals('amoxivet'));
      expect(executedEvent!.resultCount, equals(5));
      expect(zeroResultEvent, isNull);

      // Zero-result search
      SearchAnalyticsTracker.logSearch(
        query: 'NonExistentProduct123',
        resultCount: 0,
        executionTimeMs: 8,
        categoryOrScope: 'all',
      );

      expect(zeroResultEvent, isNotNull);
      expect(zeroResultEvent!.query, equals('nonexistentproduct123'));
      expect(zeroResultEvent!.resultCount, equals(0));
    });

    test('4. optimizeFtsTable runs without throwing error', () async {
      await expectLater(
        optimizeFtsTable(db.executor, 'products_fts'),
        completes,
      );
    });

    test('5. Expanded synonym dictionary resolves pharmaceutical terms correctly', () {
      final dewormerSynonyms = getSynonymExpansions('dewormer');
      expect(dewormerSynonyms, contains('albendazole'));

      final feverSynonyms = getSynonymExpansions('fever');
      expect(feverSynonyms, contains('paracetamol'));
    });

    test('6. calculateFacets dynamically aggregates result counts by category', () async {
      final labels = await productDao.getAllLabels();
      final facets = calculateFacets<ProductLabel>(
        items: labels,
        facetExtractors: {
          'category': (item) => item.category.nameEn,
        },
      );

      final categoryFacet = facets['category'];
      expect(categoryFacet, isNotNull);
      expect(categoryFacet, isNotEmpty);
      expect(categoryFacet!.first.value, equals('Veterinary Antibiotics'));
      expect(categoryFacet.first.count, equals(2));
    });

    test('7. products_trigram_fts performs mid-word and slug substring matching', () async {
      final results = await productDao.getFilteredLabels(
        query: 'vet-500',
        limit: 10,
        offset: 0,
      );
      expect(results, isNotEmpty);
      expect(results.first.titleEn, equals('Amoxivet 500'));
    });
  });
}
