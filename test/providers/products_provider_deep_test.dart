import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';

void main() {
  group('ProductsProvider Deep Coverage Tests', () {
    late ProductsDb db;
    late ProviderContainer container;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      await db.executor.customExecute('''
        INSERT INTO categories (id, name_en, name_bn, icon_name, slug)
        VALUES (1, 'Vaccines', 'টিকা', 'vaccine.png', 'vaccines'),
               (2, 'Antibiotics', 'অ্যান্টিবায়োটিক', 'antibiotic.png', 'antibiotics');
      ''');

      await db.executor.customExecute('''
        INSERT INTO target_groups (id, name_en, name_bn, icon_name)
        VALUES (1, 'Poultry', 'পোল্ট্রি', 'poultry.png'),
               (2, 'Cattle', 'গবাদি পশু', 'cattle.png');
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
        INSERT INTO manufacturers (id, name_en, name_bn, address_en, address_bn, country_of_origin_en, email, website, mobile, logo_url)
        VALUES (1, 'Impulse Agriscience Ltd.', 'ইমপালস এগ্রিসায়েন্স লি:', 'Dhaka', 'ঢাকা', 'Bangladesh', 'info@impulse.com', 'https://impulse.com', '01700000000', 'logo.png');
      ''');

      await db.executor.customExecute('''
        INSERT INTO products (id, title_en, title_bn, slug, category_id, manufacturer_id, is_active, created_at, updated_at)
        VALUES (1, 'Renavet Injection', 'রেনাভেট ইনজেকশন', 'renavet-injection', 1, 1, 1, '2026-01-01', '2026-01-01'),
               (2, 'Amoxivet Powder', 'অ্যামোক্সিভেট পাউডার', 'amoxivet-powder', 2, 1, 1, '2026-01-01', '2026-01-01');
      ''');

      await db.executor.customExecute('''
        INSERT INTO product_target_groups (product_id, target_group_id)
        VALUES (1, 1),
               (2, 2);
      ''');

      await db.executor.customExecute('''
        INSERT INTO presentations (id, product_id, product_type_id, content_type_id, size, mrp, image_url, display_order, bulk_item)
        VALUES (1, 1, 1, 1, '100 ml', 150.0, 'assets/renavet.png', 1, 0),
               (2, 2, 1, 1, '500 g', 350.0, 'assets/amoxivet.png', 1, 1);
      ''');

      container = ProviderContainer(
        overrides: [productsDatabaseProvider.overrideWith((ref) async => db)],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test(
      'categories, targetGroups, species providers return seeded data',
      () async {
        final cats = await container.read(categoriesProvider.future);
        expect(cats.length, equals(2));
        expect(
          cats.map((c) => c.nameEn),
          containsAll(['Vaccines', 'Antibiotics']),
        );

        final groups = await container.read(targetGroupsProvider.future);
        expect(groups.length, equals(2));
        expect(groups.map((g) => g.nameEn), containsAll(['Poultry', 'Cattle']));

        final sp = await container.read(speciesProvider.future);
        expect(sp.length, equals(1));
        expect(sp.first.nameEn, equals('Broiler'));
      },
    );

    test(
      'availableCategories filters to categories that contain items',
      () async {
        final available = await container.read(
          availableCategoriesProvider.future,
        );
        expect(available, contains(AppConstants.categoryAll));
        expect(available, contains(AppConstants.categoryPoultry));
        expect(available, contains(AppConstants.categoryCattle));
      },
    );

    test('productsProvider loads all active ProductLabels', () async {
      final labels = await container.read(productsProvider.future);
      expect(labels.length, equals(2));
      expect(
        labels.map((l) => l.titleEn),
        containsAll(['Renavet Injection', 'Amoxivet Powder']),
      );
    });

    test(
      'productDetailProvider fetches full product and throws on missing',
      () async {
        final detail = await container.read(productDetailProvider(1).future);
        expect(detail.titleEn, equals('Renavet Injection'));
        expect(detail.manufacturer.nameEn, equals('Impulse Agriscience Ltd.'));
        expect(detail.presentations.length, equals(1));

        expect(
          () => container.read(productDetailProvider(999).future),
          throwsA(isA<Object>()),
        );
      },
    );

    test(
      'autocompleteTrie & suggestions provider return suggestions',
      () async {
        final trie = await container.read(autocompleteTrieProvider.future);
        expect(trie, isNotNull);

        container.read(productSearchQueryProvider.notifier).updateQuery('Rena');
        final suggestions = await container.read(
          productSearchTrieSuggestionsProvider.future,
        );
        expect(suggestions, isA<List<String>>());
      },
    );

    test('productSearchFacets returns facets when query is provided', () async {
      container.read(productSearchQueryProvider.notifier).updateQuery('vet');
      final facets = await container.read(productSearchFacetsProvider.future);
      expect(facets, isA<Map<String, dynamic>>());
    });

    test(
      'PaginatedCategoryProducts loads initial page and fetchNextPage',
      () async {
        final state = await container.read(
          paginatedCategoryProductsProvider(AppConstants.categoryAll).future,
        );
        expect(state.items.length, equals(2));
        expect(state.hasMore, isFalse);

        final notifier = container.read(
          paginatedCategoryProductsProvider(AppConstants.categoryAll).notifier,
        );
        await notifier.fetchNextPage();
        expect(notifier.state.value?.items.length, equals(2));
      },
    );

    test(
      'productsByManufacturer and alikeProducts providers resolve correctly',
      () async {
        final byMfg = await container.read(
          productsByManufacturerProvider(1).future,
        );
        expect(byMfg.length, equals(2));

        final alike = await container.read(alikeProductsProvider(1).future);
        expect(alike, isA<List<Product>>());
      },
    );

    test(
      'PaginatedManufacturers fetchNextPage behaves safely when no more items',
      () async {
        final state = await container.read(
          paginatedManufacturersProvider.future,
        );
        expect(state.items.length, equals(1));
        expect(state.hasMore, isFalse);

        final notifier = container.read(
          paginatedManufacturersProvider.notifier,
        );
        await notifier.fetchNextPage();
        expect(notifier.state.value?.items.length, equals(1));
      },
    );

    test('ManufacturersSearchQuery updates and clears query', () {
      final notifier = container.read(
        manufacturersSearchQueryProvider.notifier,
      );
      expect(container.read(manufacturersSearchQueryProvider), isEmpty);
      notifier.updateQuery('Impulse');
    });
  });
}
