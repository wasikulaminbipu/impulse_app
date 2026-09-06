import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';
import 'package:impulse_app/data/product_dao.dart';

void main() {
  group('ProductDao Comprehensive Unit Tests', () {
    late ProductsDb db;
    late LookupDao lookupDao;
    late ManufacturerDao manufacturerDao;
    late ProductDao productDao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      lookupDao = LookupDao(db);
      manufacturerDao = ManufacturerDao(db);
      productDao = ProductDao(db, lookupDao, manufacturerDao: manufacturerDao);

      // Seed categories, target groups, manufacturers
      await db.executor.customExecute('''
        INSERT INTO categories (id, name_en, name_bn)
        VALUES (1, 'Antibiotics', 'অ্যান্টিবায়োটিক'),
               (2, 'Vitamins', 'ভিটামিন');
      ''');

      await db.executor.customExecute('''
        INSERT INTO target_groups (id, name_en, name_bn)
        VALUES (1, 'Poultry', 'পোল্ট্রি'),
               (2, 'Cattle', 'গবাদি পশু');
      ''');

      await db.executor.customExecute('''
        INSERT INTO content_types (id, name_en, name_bn) VALUES (1, 'Liquid', 'তরল');
      ''');

      await db.executor.customExecute('''
        INSERT INTO product_types (id, name_en, name_bn) VALUES (1, 'Medicine', 'ওষুধ');
      ''');

      await db.executor.customExecute('''
        INSERT INTO species (id, target_group_id, name_en, name_bn) VALUES (1, 1, 'Broiler', 'ব্রয়লার');
      ''');

      await db.executor.customExecute('''
        INSERT INTO dosage_units (id, name_en, name_bn) VALUES (1, 'ml', 'মিলি');
      ''');

      await db.executor.customExecute('''
        INSERT INTO dosage_bases (id, name_en, name_bn) VALUES (1, 'Water', 'পানি');
      ''');

      await db.executor.customExecute('''
        INSERT INTO manufacturers (id, name_en, name_bn, website, logo_url, address_en, country_of_origin_en)
        VALUES (1, 'Impulse Agriscience Ltd.', 'ইমপালস এগ্রিসায়েন্স লি:', 'https://impulse.com', 'assets/logo.png', 'Dhaka', 'Bangladesh');
      ''');

      // Seed products (matching schema: title_en, title_bn, etc.)
      await db.executor.customExecute('''
        INSERT INTO products (id, title_en, title_bn, slug, category_id, manufacturer_id, short_description_en, short_description_bn, image_url, is_active, created_at, updated_at)
        VALUES (1, 'Amoxivet 50% WSP', 'এমক্সিবেট ৫০% ডব্লিউএসপি', 'amoxivet-50-wsp', 1, 1, 'Broad spectrum antibiotic powder', 'অ্যান্টিবায়োটিক পাউডার', 'assets/amoxivet.png', 1, '2026-01-01', '2026-01-01'),
               (2, 'Ciprovet Oral', 'সিপ্রোভেট ওরাল', 'ciprovet-oral', 1, 1, 'Oral solution', 'ওরাল সলিউশন', 'assets/ciprovet.png', 1, '2026-01-01', '2026-01-01'),
               (3, 'VitaPlex Super', 'ভিটাপ্লেক্স সুপার', 'vitaplex-super', 2, 1, 'Vitamin booster', 'ভিটামিন বুস্টার', 'assets/vitaplex.png', 1, '2026-01-01', '2026-01-01');
      ''');

      // Seed product relations
      await db.executor.customExecute('''
        INSERT INTO product_target_groups (product_id, target_group_id) VALUES (1, 1), (1, 2), (2, 1), (3, 2);
      ''');

      await db.executor.customExecute('''
        INSERT INTO compositions (id, product_id, ingredient_en, ingredient_bn, concentration, display_order)
        VALUES (1, 1, 'Amoxicillin Trihydrate', 'অ্যামোক্সিসিলিন ট্রাইহাইড্রেট', '500 mg/g', 1);
      ''');

      await db.executor.customExecute('''
        INSERT INTO indications (id, product_id, text_en, text_bn, display_order)
        VALUES (1, 1, 'For treatment of respiratory infections', 'শ্বাসতন্ত্রের সংক্রমণের চিকিৎসার জন্য', 1);
      ''');

      await db.executor.customExecute('''
        INSERT INTO directions (id, product_id, content_type_id, species_id, dose_value_min, dose_unit_id, dose_basis_id, administration_en, administration_bn, dosage_en, dosage_bn, display_order)
        VALUES (1, 1, 1, 1, 1.0, 1, 1, 'Mix with drinking water', 'খাবার পানির সাথে মেশান', '1g per 2L water', '১ গ্রাম প্রতি ২ লিটার পানিতে', 1);
      ''');

      await db.executor.customExecute('''
        INSERT INTO precautions (id, product_id, text_en, text_bn, display_order)
        VALUES (1, 1, 'Do not use in layers producing eggs for human consumption', 'ডিমপাড়া মুরগিকে দেবেন না', 1);
      ''');

      await db.executor.customExecute('''
        INSERT INTO presentations (id, product_id, product_type_id, content_type_id, size, mrp, image_url, display_order, bulk_item)
        VALUES (1, 1, 1, 1, '100g sachet', 350.0, 'assets/amoxivet_100.png', 1, 0),
               (2, 1, 1, 1, '500g container', 1600.0, 'assets/amoxivet_500.png', 2, 0);
      ''');
    });

    tearDown(() async {
      await db.close();
    });

    test('getById returns fully hydrated Product with all relations', () async {
      final product = await productDao.getById(1);
      expect(product, isNotNull);
      expect(product!.titleEn, equals('Amoxivet 50% WSP'));
      expect(product.manufacturer.nameEn, equals('Impulse Agriscience Ltd.'));
      expect(product.category.nameEn, equals('Antibiotics'));
      expect(product.compositions.length, equals(1));
      expect(product.indications.length, equals(1));
      expect(product.directions.length, equals(1));
      expect(product.precautions.length, equals(1));
      expect(product.presentations.length, equals(2));
      expect(product.targetGroups.length, equals(2));

      final missing = await productDao.getById(999);
      expect(missing, isNull);
    });

    test(
      'getAllLight batch loads lightweight representations with target groups',
      () async {
        final products = await productDao.getAllLight();
        expect(products.length, equals(3));
        final p1 = products.firstWhere((p) => p.id == 1);
        expect(p1.targetGroupIds, containsAll([1, 2]));
        expect(p1.presentations.length, equals(2));

        // With category filter
        final antibiotics = await productDao.getAllLight(categoryId: 1);
        expect(antibiotics.length, equals(2));

        // With target group filter
        final poultryProducts = await productDao.getAllLight(targetGroupId: 1);
        expect(poultryProducts.length, equals(2));
      },
    );

    test('getAllLabels converts light products to ProductLabels', () async {
      final labels = await productDao.getAllLabels();
      expect(labels.length, equals(3));
      expect(labels.first.titleEn, isNotEmpty);
    });

    test(
      'getFilteredLabels with category, search query, and pagination',
      () async {
        final labels = await productDao.getFilteredLabels(
          categoryId: 1,
          limit: 10,
          offset: 0,
        );
        expect(labels.length, equals(2));

        final searched = await productDao.getFilteredLabels(
          query: 'Amoxivet',
          limit: 10,
          offset: 0,
        );
        expect(searched.length, equals(1));
        expect(searched.first.titleEn, contains('Amoxivet'));
      },
    );

    test('getAlikeProducts finds similar products', () async {
      final alike = await productDao.getAlikeProducts(1, limit: 5);
      expect(alike.any((p) => p.id == 1), isFalse);
    });

    test(
      'search, findFuzzyProductSuggestions, and getAllSearchTerms',
      () async {
        final searchResults = await productDao.search('Amoxivet');
        expect(searchResults.length, equals(1));

        final emptySearch = await productDao.search('   ');
        expect(emptySearch, isEmpty);

        final fuzzy = await productDao.findFuzzyProductSuggestions('Amoxi');
        expect(fuzzy, isA<List<String>>());

        final terms = await productDao.getAllSearchTerms();
        expect(terms, isNotEmpty);
        expect(terms, contains('Amoxivet 50% WSP'));
      },
    );
  });
}
