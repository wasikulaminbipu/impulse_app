import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/product_dao.dart';
import 'package:impulse_app/data/lookup_dao.dart';

void main() {
  group('Product Search Ranking Tests', () {
    late ProductsDb db;
    late ProductDao productDao;
    late LookupDao lookupDao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      lookupDao = LookupDao(db);
      productDao = ProductDao(db, lookupDao);

      // Insert dummy category "Antibiotic"
      await db.into(db.categories).insert(
        CategoriesCompanion.insert(
          id: const Value(1),
          nameEn: 'Antibiotic',
          nameBn: 'অ্যান্টিবায়োটিক',
        ),
      );

      // Insert dummy category "General"
      await db.into(db.categories).insert(
        CategoriesCompanion.insert(
          id: const Value(2),
          nameEn: 'General',
          nameBn: 'সাধারণ',
        ),
      );

      // Product 1: Name contains "Vit" (e.g. VitaStar), Category is "General"
      await db.into(db.products).insert(
        ProductsCompanion.insert(
          id: const Value(10),
          titleEn: 'VitaStar Injection',
          titleBn: const Value('ভিটাস্টার ইনজেকশন'),
          slug: 'vitastar-injection',
          categoryId: 2,
          isActive: const Value(1),
        ),
      );

      // Product 2: Name is "Antibiotic Bolus", Category is "Antibiotic"
      await db.into(db.products).insert(
        ProductsCompanion.insert(
          id: const Value(20),
          titleEn: 'Antibiotic Bolus',
          titleBn: const Value('অ্যান্টিবায়োটিক বোলস'),
          slug: 'antibiotic-bolus',
          categoryId: 1,
          isActive: const Value(1),
        ),
      );

      // Product 3: Name is "Renapen Powder", Category is "Antibiotic"
      await db.into(db.products).insert(
        ProductsCompanion.insert(
          id: const Value(30),
          titleEn: 'Renapen Powder',
          titleBn: const Value('রেনাপেন পাউডার'),
          slug: 'renapen-powder',
          categoryId: 1,
          isActive: const Value(1),
        ),
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('Searching "Antibiotic" returns ALL matches (title & category) with title match on top', () async {
      final results = await productDao.getFilteredLabels(
        query: 'Antibiotic',
        limit: 10,
        offset: 0,
      );
      // Both "Antibiotic Bolus" (title match) and "Renapen Powder" (category match) must be returned
      expect(results.length, equals(2));
      expect(results[0].titleEn, equals('Antibiotic Bolus'));
      expect(results[1].titleEn, equals('Renapen Powder'));
    });
  });
}
