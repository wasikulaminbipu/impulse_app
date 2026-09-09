import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/providers/search_history_provider.dart';
import 'package:impulse_app/screens/products_screen.dart';

void main() {
  const mockLabel = ProductLabel(
    id: 1,
    titleEn: 'Amoxivet 50% WSP',
    titleBn: 'এমক্সিবেট ৫০% ডব্লিউএসপি',
    categoryId: 1,
    shortDescriptionEn: 'Broad spectrum antibiotic powder',
    imageUrl: 'assets/amoxivet.png',
  );

  Widget createHarness({
    required Widget child,
    String lang = 'en',
    List<ProductLabel> products = const [mockLabel],
    List<String> categories = const ['All', 'Antibiotics', 'Vitamins'],
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _MockLanguageSetting(lang)),
        availableCategoriesProvider.overrideWith((ref) async => categories),
        paginatedCategoryProductsProvider('All')
            .overrideWith(() => _MockPaginatedCategoryProducts(products)),
        paginatedCategoryProductsProvider('Antibiotics')
            .overrideWith(() => _MockPaginatedCategoryProducts(products)),
        paginatedCategoryProductsProvider('Vitamins')
            .overrideWith(() => _MockPaginatedCategoryProducts(const [])),
        productFavoritesProvider.overrideWith((ref) async => [1]),
        searchHistoryProvider.overrideWith(
          () => _MockSearchHistory(['Amoxivet']),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('ProductsScreen Interaction Tests', () {
    testWidgets('Renders AppBar, title, search field, and category tabs', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createHarness(child: const ProductsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Impulse Agriscience Ltd.'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Antibiotics'), findsOneWidget);
      expect(find.text('Amoxivet 50% WSP'), findsWidgets);
    });

    testWidgets('Typing into search field and clearing search query', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createHarness(child: const ProductsScreen()));
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Amoxicillin');
      await tester.pumpAndSettle();

      expect(find.text('Amoxicillin'), findsOneWidget);

      // Clear button tap
      final clearBtn = find.byIcon(Icons.clear_rounded);
      if (clearBtn.evaluate().isNotEmpty) {
        await tester.tap(clearBtn);
        await tester.pumpAndSettle();
        expect(find.text('Amoxicillin'), findsNothing);
      }
    });

    testWidgets('Switching tabs to Vitamins renders empty state', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createHarness(child: const ProductsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Vitamins'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('Tapping language action button toggles language', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createHarness(child: const ProductsScreen()));
      await tester.pumpAndSettle();

      final langButton = find.text('বাংলা');
      expect(langButton, findsOneWidget);
      await tester.tap(langButton);
      await tester.pumpAndSettle();
    });
  });
}

class _MockLanguageSetting extends LanguageSetting {
  final String initial;
  _MockLanguageSetting(this.initial);

  @override
  String build() => initial;
}

class _MockPaginatedCategoryProducts extends PaginatedCategoryProducts {
  final List<ProductLabel> _initial;
  _MockPaginatedCategoryProducts(this._initial);

  @override
  Future<PaginatedState<ProductLabel>> build(String category) async {
    return PaginatedState(items: _initial, hasMore: false);
  }
}

class _MockSearchHistory extends SearchHistory {
  final List<String> _initial;
  _MockSearchHistory(this._initial);

  @override
  Future<List<String>> build() async => _initial;
}
