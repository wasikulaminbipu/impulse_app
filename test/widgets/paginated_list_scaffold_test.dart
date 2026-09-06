import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/widgets/paginated_list_scaffold.dart';

final testPaginatedProvider = Provider<AsyncValue<PaginatedState<String>>>(
  (ref) => const AsyncValue.data(
    PaginatedState(items: ['Item 1', 'Item 2'], hasMore: false),
  ),
);

void main() {
  group('PaginatedListScaffold Widget Tests', () {
    testWidgets('renders title, items, and search field with interactions', (
      tester,
    ) async {
      String searched = '';
      var cleared = false;
      var nextPageCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: PaginatedListScaffold<String>(
              title: 'Test Scaffold',
              searchHint: 'Search test items...',
              provider: testPaginatedProvider,
              fetchNextPage: () => nextPageCalled = true,
              onSearchChanged: (val) => searched = val,
              onSearchCleared: () => cleared = true,
              itemBuilder: (context, item, index) =>
                  ListTile(title: Text(item)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Scaffold'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);

      // Search input
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pumpAndSettle();
      expect(searched, equals('Hello'));

      // Clear button
      final clearBtn = find.byIcon(Icons.clear);
      expect(clearBtn, findsOneWidget);
      await tester.tap(clearBtn);
      await tester.pumpAndSettle();
      expect(cleared, isTrue);
      expect(nextPageCalled, isFalse);
    });

    testWidgets('renders empty widget when state has no items', (tester) async {
      final emptyProvider = Provider<AsyncValue<PaginatedState<String>>>(
        (ref) =>
            const AsyncValue.data(PaginatedState(items: [], hasMore: false)),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: PaginatedListScaffold<String>(
              title: 'Empty List',
              searchHint: 'Search...',
              provider: emptyProvider,
              fetchNextPage: () {},
              emptyWidget: const Text('Custom Empty View'),
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom Empty View'), findsOneWidget);
    });

    testWidgets(
      'renders skeleton loader when loading and error text when error',
      (tester) async {
        final loadingProvider = Provider<AsyncValue<PaginatedState<String>>>(
          (ref) => const AsyncValue.loading(),
        );

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: PaginatedListScaffold<String>(
                title: 'Loading List',
                searchHint: 'Search...',
                provider: loadingProvider,
                fetchNextPage: () {},
                skeletonBuilder: (context, index) =>
                    const Text('Skeleton Item'),
                itemBuilder: (context, item, index) => Text(item),
              ),
            ),
          ),
        );

        expect(find.text('Skeleton Item'), findsWidgets);

        final errorProvider = Provider<AsyncValue<PaginatedState<String>>>(
          (ref) => const AsyncValue.error('Network Error', StackTrace.empty),
        );

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: PaginatedListScaffold<String>(
                title: 'Error List',
                searchHint: 'Search...',
                provider: errorProvider,
                fetchNextPage: () {},
                itemBuilder: (context, item, index) => Text(item),
              ),
            ),
          ),
        );

        expect(find.text('Network Error'), findsOneWidget);
      },
    );
  });
}
