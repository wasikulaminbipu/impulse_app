import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/providers/search_history_provider.dart';
import 'package:impulse_app/screens/products_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProductsScreen Title Responsive Tests', () {
    testWidgets('renders Impulse Agriscience Ltd. on normal width', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            availableCategoriesProvider.overrideWith((ref) => Future.value(['All'])),
            searchHistoryProvider.overrideWith(() => SearchHistoryMock()),
            productSearchTrieSuggestionsProvider.overrideWith((ref) => Future.value([])),
            languageSettingProvider.overrideWith(() => LanguageSettingMock()),
          ],
          child: const MaterialApp(
            home: ProductsScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Impulse Agriscience Ltd.'), findsOneWidget);
    });

    testWidgets('falls back to Impulse Agriscience on narrow title constraint', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(300, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            availableCategoriesProvider.overrideWith((ref) => Future.value(['All'])),
            searchHistoryProvider.overrideWith(() => SearchHistoryMock()),
            productSearchTrieSuggestionsProvider.overrideWith((ref) => Future.value([])),
            languageSettingProvider.overrideWith(() => LanguageSettingMock()),
          ],
          child: const MaterialApp(
            home: ProductsScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Impulse Agriscience'), findsOneWidget);
    });
  });
}

class SearchHistoryMock extends SearchHistory {
  @override
  Future<List<String>> build() async => [];
}

class LanguageSettingMock extends LanguageSetting {
  @override
  String build() => 'en';
}
