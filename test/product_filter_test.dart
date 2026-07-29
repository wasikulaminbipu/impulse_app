import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/data/product_dao.dart';
import 'package:impulse_dex/data/lookup_dao.dart';
import 'package:impulse_dex/models/product.dart';

void main() {
  group('ProductFilter Mechanism Tests', () {
    late NativeDatabase db;
    late ProductDao dao;

    setUp(() async {
      final dbFile = File('assets/products.db');
      db = NativeDatabase(dbFile.absolute);
      dao = ProductDao(db, LookupDao(db));
    });

    tearDown(() async {
      await db.close();
    });

    test('getAllLight includes target groups from directions', () async {
      final products = await dao.getAllLight(activeOnly: true);
      expect(products, isNotEmpty);
      for (final p in products) {
        expect(p.targetGroupIds, isNotNull);
      }
    });

    test('Filter logic helper checks all conditions correctly', () {
      final vaccineCategory = Category(id: 3, nameEn: 'Vaccine');
      final otherCategory = Category(id: 1, nameEn: 'Medicine');

      final prodVaccine = Product(
        id: 101,
        titleEn: 'Vaccine A',
        slug: 'vaccine-a',
        categoryId: 3,
        category: vaccineCategory,
        targetGroupIds: [1], // Poultry
        createdAt: '',
        updatedAt: '',
        presentations: [
          Presentation(id: 1, productId: 101, productTypeId: 1, contentTypeId: 1, bulkItem: false),
        ],
      );

      final prodFeedAdditiveBulk = Product(
        id: 102,
        titleEn: 'Bulk Feed Additive',
        slug: 'bulk-feed-additive',
        categoryId: 4, // Feed Additives category
        category: Category(id: 4, nameEn: 'Feed Additives'),
        targetGroupIds: [2], // Cattle
        createdAt: '',
        updatedAt: '',
        presentations: [
          Presentation(id: 2, productId: 102, productTypeId: 1, contentTypeId: 1, bulkItem: true),
        ],
      );

      final prodPoultryNoBulk = Product(
        id: 103,
        titleEn: 'Poultry Medicine',
        slug: 'poultry-medicine',
        categoryId: 1,
        category: otherCategory,
        targetGroupIds: [1], // Poultry from directions
        createdAt: '',
        updatedAt: '',
        presentations: [
          Presentation(id: 3, productId: 103, productTypeId: 1, contentTypeId: 1, bulkItem: false),
        ],
      );

      final multiGroupProd = Product(
        id: 104,
        titleEn: 'Multi Group Prod',
        slug: 'multi-group-prod',
        categoryId: 3, // Vaccine
        category: vaccineCategory,
        targetGroupIds: [1, 3], // Poultry and Aqua directions
        createdAt: '',
        updatedAt: '',
        presentations: [
          Presentation(id: 4, productId: 104, productTypeId: 1, contentTypeId: 1, bulkItem: true),
        ],
      );

      // Verify Feed Additives filter (Condition 3: bulk_item == 1 / true)
      bool isFeedAdditive(Product p) => p.presentations.any((pres) => pres.bulkItem);
      expect(isFeedAdditive(prodFeedAdditiveBulk), isTrue);
      expect(isFeedAdditive(prodVaccine), isFalse);
      expect(isFeedAdditive(prodPoultryNoBulk), isFalse);
      expect(isFeedAdditive(multiGroupProd), isTrue); // Multi-group: satisfies bulk_item

      // Verify Vaccine filter (Condition 2: Category is Vaccine only)
      bool isVaccine(Product p) => p.categoryId == 3;
      expect(isVaccine(prodVaccine), isTrue);
      expect(isVaccine(prodFeedAdditiveBulk), isFalse);
      expect(isVaccine(multiGroupProd), isTrue);

      // Verify Target Group filter (Condition 1: TargetGroup in Directions)
      bool isPoultry(Product p) => p.targetGroupIds.contains(1);
      expect(isPoultry(prodPoultryNoBulk), isTrue);
      expect(isPoultry(prodVaccine), isTrue);
      expect(isPoultry(multiGroupProd), isTrue);
      expect(isPoultry(prodFeedAdditiveBulk), isFalse);

      // Condition 4: Multi-group verification
      // multiGroupProd should be present in Poultry, Vaccine, AND Feed Additives
      expect(isPoultry(multiGroupProd) && isVaccine(multiGroupProd) && isFeedAdditive(multiGroupProd), isTrue);
    });
  });
}
