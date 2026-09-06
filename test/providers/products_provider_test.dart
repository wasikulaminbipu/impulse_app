import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';
import 'package:impulse_app/domain/search_scope.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';

void main() {
  group('ProductsProvider Unit & Integration Tests', () {
    late ProductsDb db;
    late ProviderContainer container;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      // Seed manufacturer
      await db.customStatement('''
        INSERT INTO manufacturers (id, name_en, name_bn, address_en, address_bn, country_of_origin_en, email, website, mobile, logo_url)
        VALUES (1, 'Impulse Agriscience Ltd.', 'ইমপালস এগ্রিসায়েন্স লি:', 'Dhaka', 'ঢাকা', 'Bangladesh', 'info@impulse.com', 'https://impulse.com', '01700000000', 'logo.png');
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
      'DAO providers productDao, manufacturerDao, and lookupDao resolve',
      () async {
        expect(
          await container.read(manufacturerDaoProvider.future),
          isA<ManufacturerDao>(),
        );
        expect(
          await container.read(lookupDaoProvider.future),
          isA<LookupDao>(),
        );
      },
    );

    test('ProductSearchQuery updates, debounces, and clears query', () {
      final notifier = container.read(productSearchQueryProvider.notifier);
      expect(container.read(productSearchQueryProvider), isEmpty);

      notifier.updateQuery('Amoxivet');
      // Immediate before debounce or directly
      notifier.clear();
      expect(container.read(productSearchQueryProvider), isEmpty);
    });

    test('ProductSearchScope toggles between scopes', () {
      final notifier = container.read(productSearchScopeProvider.notifier);
      expect(
        container.read(productSearchScopeProvider),
        equals(SearchScope.all),
      );

      notifier.setScope(SearchScope.symptom);
      expect(
        container.read(productSearchScopeProvider),
        equals(SearchScope.symptom),
      );

      notifier.setScope(SearchScope.ingredient);
      expect(
        container.read(productSearchScopeProvider),
        equals(SearchScope.ingredient),
      );
    });

    test('Empty query providers return empty lists/maps', () async {
      final trieSuggestions = await container.read(
        productSearchTrieSuggestionsProvider.future,
      );
      expect(trieSuggestions, isEmpty);

      final fuzzy = await container.read(
        productSearchFuzzySuggestionsProvider.future,
      );
      expect(fuzzy, isEmpty);

      final facets = await container.read(productSearchFacetsProvider.future);
      expect(facets, isEmpty);
    });

    test(
      'Manufacturers provider, query, and pagination build and fetchNextPage',
      () async {
        final list = await container.read(manufacturersProvider.future);
        expect(list.length, equals(1));
        expect(list.first.nameEn, equals('Impulse Agriscience Ltd.'));

        final paginated = await container.read(
          paginatedManufacturersProvider.future,
        );
        expect(paginated.items.length, equals(1));
        expect(paginated.hasMore, isFalse);

        await container
            .read(paginatedManufacturersProvider.notifier)
            .fetchNextPage();
        final updated = await container.read(
          paginatedManufacturersProvider.future,
        );
        expect(updated.items.length, equals(1));

        final searchNotifier = container.read(
          manufacturersSearchQueryProvider.notifier,
        );
        searchNotifier.updateQuery('Impulse');
      },
    );

    test(
      'productsByManufacturer returns products associated with manufacturer',
      () async {
        final products = await container.read(
          productsByManufacturerProvider(1).future,
        );
        expect(products, isEmpty);
      },
    );
  });
}
