import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/screens/manufacturers_screen.dart';

class _FakePaginatedManufacturers extends PaginatedManufacturers {
  final PaginatedState<Manufacturer> initialState;

  _FakePaginatedManufacturers(this.initialState);

  @override
  Future<PaginatedState<Manufacturer>> build() async {
    return initialState;
  }
}

Widget createManufacturersScreenHarness({
  required ProviderContainer container,
}) {
  return UncontrolledProviderScope(
    container: container,
    child: const MaterialApp(home: ManufacturersScreen()),
  );
}

void main() {
  testWidgets(
    'ManufacturersScreen displays title and empty state when list is empty',
    (tester) async {
      final container = ProviderContainer(
        overrides: [
          paginatedManufacturersProvider.overrideWith(
            () => _FakePaginatedManufacturers(
              const PaginatedState<Manufacturer>(items: [], hasMore: false),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        createManufacturersScreenHarness(container: container),
      );
      await tester.pumpAndSettle();

      expect(find.text('Manufacturers List'), findsOneWidget);
      expect(find.text('No manufacturers found'), findsOneWidget);
    },
  );

  testWidgets(
    'ManufacturersScreen displays manufacturer cards when data is available',
    (tester) async {
      const sampleManufacturer = Manufacturer(
        id: 1,
        nameEn: 'Acme Agro Ltd',
        addressEn: 'Dhaka, Bangladesh',
        countryOfOriginEn: 'Bangladesh',
      );

      final container = ProviderContainer(
        overrides: [
          paginatedManufacturersProvider.overrideWith(
            () => _FakePaginatedManufacturers(
              const PaginatedState<Manufacturer>(
                items: [sampleManufacturer],
                hasMore: false,
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        createManufacturersScreenHarness(container: container),
      );
      await tester.pumpAndSettle();

      expect(find.text('Acme Agro Ltd'), findsOneWidget);
      expect(find.text('Dhaka, Bangladesh'), findsOneWidget);
    },
  );
}
