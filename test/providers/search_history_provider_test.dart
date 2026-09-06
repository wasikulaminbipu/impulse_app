import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/providers/search_history_provider.dart';

void main() {
  group('SearchHistory Provider Tests', () {
    late AppMaintenanceDb db;
    late ProviderContainer container;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test(
      'build loads search history, addQuery, removeQuery, and clearAll work',
      () async {
        // Initially empty
        final initial = await container.read(searchHistoryProvider.future);
        expect(initial, isEmpty);

        // Add query
        await container
            .read(searchHistoryProvider.notifier)
            .addQuery('Amoxivet');
        final afterAdd = await container.read(searchHistoryProvider.future);
        expect(afterAdd, contains('Amoxivet'));

        // Empty query should be ignored
        await container.read(searchHistoryProvider.notifier).addQuery('   ');
        final afterEmpty = await container.read(searchHistoryProvider.future);
        expect(afterEmpty.length, equals(1));

        // Add another query
        await container
            .read(searchHistoryProvider.notifier)
            .addQuery('Ciprofloxacin');
        final afterSecond = await container.read(searchHistoryProvider.future);
        expect(afterSecond.length, equals(2));

        // Remove query
        await container
            .read(searchHistoryProvider.notifier)
            .removeQuery('Amoxivet');
        final afterRemove = await container.read(searchHistoryProvider.future);
        expect(afterRemove, isNot(contains('Amoxivet')));
        expect(afterRemove, contains('Ciprofloxacin'));

        // Clear all
        await container.read(searchHistoryProvider.notifier).clearAll();
        final afterClear = await container.read(searchHistoryProvider.future);
        expect(afterClear, isEmpty);
      },
    );
  });
}
