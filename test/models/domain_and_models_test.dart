import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/domain/category_filter.dart';
import 'package:impulse_app/domain/search_scope.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/utils/app_constants.dart';

void main() {
  group('Domain & Models Coverage Tests', () {
    test(
      'SearchScope enum and extensions cover all properties and languages',
      () {
        for (final scope in SearchScope.values) {
          expect(scope.labelEn.isNotEmpty, isTrue);
          expect(scope.labelBn.isNotEmpty, isTrue);
          expect(scope.label('en'), equals(scope.labelEn));
          expect(scope.label('bn'), equals(scope.labelBn));

          expect(scope.hintEn.isNotEmpty, isTrue);
          expect(scope.hintBn.isNotEmpty, isTrue);
          expect(scope.hint('en'), equals(scope.hintEn));
          expect(scope.hint('bn'), equals(scope.hintBn));

          expect(scope.icon, isA<IconData>());
        }
      },
    );

    test(
      'resolveCategoryFilter handles All, Feed Additives, Vaccines, TargetGroups, and fallback',
      () {
        final categories = [
          const Category(id: 1, nameEn: 'Vaccine', nameBn: 'টিকা'),
          const Category(
            id: 2,
            nameEn: 'Antibiotics',
            nameBn: 'অ্যান্টিবায়োটিক',
          ),
        ];
        final targetGroups = [
          const TargetGroup(id: 10, nameEn: 'Poultry', nameBn: 'পোল্ট্রি'),
          const TargetGroup(id: 20, nameEn: 'Cattle', nameBn: 'গবাদি পশু'),
        ];

        // All category
        final allCriteria = resolveCategoryFilter(
          AppConstants.categoryAll,
          categories,
          targetGroups,
        );
        expect(allCriteria.categoryId, isNull);
        expect(allCriteria.targetGroupId, isNull);
        expect(allCriteria.isFeedAdditive, isFalse);

        // Feed Additive
        final feedCriteria = resolveCategoryFilter(
          AppConstants.categoryFeedAdditives,
          categories,
          targetGroups,
        );
        expect(feedCriteria.isFeedAdditive, isTrue);

        final feedSingularCriteria = resolveCategoryFilter(
          AppConstants.categoryFeedAdditive,
          categories,
          targetGroups,
        );
        expect(feedSingularCriteria.isFeedAdditive, isTrue);

        // Vaccine
        final vaccineCriteria = resolveCategoryFilter(
          AppConstants.categoryVaccines,
          categories,
          targetGroups,
        );
        expect(vaccineCriteria.categoryId, equals(1));

        // Target group match (singular & plural)
        final tgCriteria = resolveCategoryFilter(
          'Poultry',
          categories,
          targetGroups,
        );
        expect(tgCriteria.targetGroupId, equals(10));

        final tgPluralCriteria = resolveCategoryFilter(
          'Cattles',
          categories,
          targetGroups,
        );
        expect(tgPluralCriteria.targetGroupId, equals(20));

        // Category match
        final catCriteria = resolveCategoryFilter(
          'Antibiotics',
          categories,
          targetGroups,
        );
        expect(catCriteria.categoryId, equals(2));

        // Unknown category
        final unknownCriteria = resolveCategoryFilter(
          'UnknownCategory',
          categories,
          targetGroups,
        );
        expect(unknownCriteria.categoryId, equals(-1));
      },
    );

    test('PaginatedState properties and copyWith', () {
      const state = PaginatedState<String>(
        items: ['item1', 'item2'],
        hasMore: true,
      );

      expect(state.items.length, equals(2));
      expect(state.hasMore, isTrue);
      expect(state.isLoadingMore, isFalse);

      final updated = state.copyWith(
        items: ['item1', 'item2', 'item3'],
        hasMore: false,
        isLoadingMore: true,
      );

      expect(updated.items.length, equals(3));
      expect(updated.hasMore, isFalse);
      expect(updated.isLoadingMore, isTrue);

      final unmodified = state.copyWith();
      expect(unmodified.items, equals(state.items));
      expect(unmodified.hasMore, equals(state.hasMore));
      expect(unmodified.isLoadingMore, equals(state.isLoadingMore));
    });

    test('Product child models fromRow deserialization', () {
      final contentType = ContentType.fromRow({
        'id': 1,
        'name_en': 'Liquid',
        'name_bn': 'তরল',
      });
      expect(contentType.id, equals(1));
      expect(contentType.nameEn, equals('Liquid'));
      expect(contentType.nameBn, equals('তরল'));

      final dosageBasis = DosageBasis.fromRow({
        'id': 2,
        'name_en': 'Weight',
        'name_bn': 'ওজন',
      });
      expect(dosageBasis.id, equals(2));
      expect(dosageBasis.nameEn, equals('Weight'));

      final dosageUnit = DosageUnit.fromRow({
        'id': 3,
        'name_en': 'ml',
        'name_bn': 'মিলি',
      });
      expect(dosageUnit.id, equals(3));
      expect(dosageUnit.nameEn, equals('ml'));

      final productType = ProductType.fromRow({
        'id': 4,
        'name_en': 'Medicine',
        'name_bn': 'ওষুধ',
      });
      expect(productType.id, equals(4));
      expect(productType.nameEn, equals('Medicine'));

      final species = Species.fromRow({
        'id': 5,
        'target_group_id': 1,
        'name_en': 'Broiler',
        'name_bn': 'ব্রয়লার',
      });
      expect(species.id, equals(5));
      expect(species.nameEn, equals('Broiler'));

      final targetGroup = TargetGroup.fromRow({
        'id': 6,
        'name_en': 'Aqua',
        'name_bn': 'মৎস্য',
      });
      expect(targetGroup.id, equals(6));
      expect(targetGroup.nameEn, equals('Aqua'));

      final category = Category.fromRow({
        'id': 7,
        'name_en': 'Tonics',
        'name_bn': 'টনিক',
        'icon_name': 'tonic_icon',
      });
      expect(category.id, equals(7));
      expect(category.iconName, equals('tonic_icon'));

      const emptyCat = Category.empty();
      expect(emptyCat.id, equals(0));
      expect(emptyCat.nameEn, isEmpty);

      final manufacturer = Manufacturer.fromRow({
        'id': 8,
        'name_en': 'Impulse Pharma',
        'name_bn': 'ইমপালস ফার্মা',
        'address_en': 'Dhaka',
        'address_bn': 'ঢাকা',
        'country_of_origin_en': 'Bangladesh',
        'country_of_origin_bn': 'বাংলাদেশ',
        'email': 'info@impulse.com',
        'website': 'https://impulse.com',
        'mobile': '01700000000',
        'logo_url': 'assets/logo.png',
      });
      expect(manufacturer.id, equals(8));
      expect(manufacturer.website, equals('https://impulse.com'));

      const emptyMfg = Manufacturer.empty();
      expect(emptyMfg.id, equals(0));
      expect(emptyMfg.nameEn, isEmpty);
    });

    test('ProductLabel fromRow and fullImageUrl logic', () {
      final label = ProductLabel.fromRow({
        'id': 1,
        'title_en': 'Amoxivet',
        'title_bn': 'এমক্সিবেট',
        'short_description_en': 'Antibiotic',
        'short_description_bn': 'অ্যান্টিবায়োটিক',
        'motto_en': 'Fast recovery',
        'motto_bn': 'দ্রুত আরোগ্য',
        'category_id': 10,
        'image_url': 'amoxivet.png',
      });

      expect(label.id, equals(1));
      expect(label.titleEn, equals('Amoxivet'));
      expect(label.fullImageUrl, equals('assets/product_image/amoxivet.png'));

      final labelAssets = label.copyWith(imageUrl: 'assets/custom.png');
      expect(labelAssets.fullImageUrl, equals('assets/custom.png'));

      final labelProductImg = label.copyWith(
        imageUrl: 'product_image/item.png',
      );
      expect(
        labelProductImg.fullImageUrl,
        equals('assets/product_image/item.png'),
      );

      final emptyImg = label.copyWith(imageUrl: null);
      expect(emptyImg.fullImageUrl, isNull);

      final blankImg = label.copyWith(imageUrl: '   ');
      expect(blankImg.fullImageUrl, isNull);
    });

    test('Presentation fromRow and toRow serialization', () {
      final presentation = Presentation.fromRow({
        'id': 1,
        'product_id': 10,
        'product_type_id': 2,
        'content_type_id': 3,
        'size': '100g',
        'mrp': 250.0,
        'image_url': 'pack.png',
        'display_order': 1,
        'bulk_item': 1,
      });

      expect(presentation.id, equals(1));
      expect(presentation.size, equals('100g'));
      expect(presentation.bulkItem, isTrue);

      final row = presentation.toRow();
      expect(row['id'], equals(1));
      expect(row['product_id'], equals(10));
      expect(row['size'], equals('100g'));
      expect(row['mrp'], equals(250.0));
      expect(row['bulk_item'], equals(1));
    });
  });
}
