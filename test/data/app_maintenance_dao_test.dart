import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:impulse_app/models/app_maintenance.dart' as models;

void main() {
  group('AppMaintenanceDao Comprehensive Tests', () {
    late AppMaintenanceDb db;
    late AppMaintenanceDao dao;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      dao = AppMaintenanceDao(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Favorites CRUD for all four types', () async {
      for (final type in models.FavoriteType.values) {
        // Initial state
        expect(await dao.isFavorite(type, 101), isFalse);
        expect(await dao.getFavorites(type), isEmpty);
        expect(await dao.getFavoriteIds(type), isEmpty);

        // Add favorite
        await dao.addFavorite(type, 101);
        expect(await dao.isFavorite(type, 101), isTrue);
        expect(await dao.getFavoriteIds(type), equals([101]));
        final favs = await dao.getFavorites(type);
        expect(favs.length, equals(1));
        expect(favs.first.id, equals(101));

        // Adding again does not duplicate
        await dao.addFavorite(type, 101);
        expect(await dao.getFavoriteIds(type), equals([101]));

        // Add second favorite
        await dao.addFavorite(type, 202);
        expect(await dao.getFavoriteIds(type), containsAll([101, 202]));

        // Remove favorite
        await dao.removeFavorite(type, 101);
        expect(await dao.isFavorite(type, 101), isFalse);
        expect(await dao.isFavorite(type, 202), isTrue);

        // Toggle favorite
        await dao.toggleFavorite(type, 202); // removes
        expect(await dao.isFavorite(type, 202), isFalse);
        await dao.toggleFavorite(type, 303); // adds
        expect(await dao.isFavorite(type, 303), isTrue);
      }
    });

    test('AppSettings settings, dark mode, and language handling', () async {
      expect(await dao.getSetting('unknown_key'), isNull);
      expect(await dao.getAllSettings(), isEmpty);

      await dao.setSetting('test_key', 'test_val');
      expect(await dao.getSetting('test_key'), equals('test_val'));

      final all = await dao.getAllSettings();
      expect(all.length, equals(1));
      expect(all.first.key, equals('test_key'));
      expect(all.first.value, equals('test_val'));

      // Dark mode
      expect(await dao.getDarkMode(), isFalse);
      await dao.setDarkMode(true);
      expect(await dao.getDarkMode(), isTrue);
      await dao.setDarkMode(false);
      expect(await dao.getDarkMode(), isFalse);

      // Language
      expect(await dao.getLanguage(), equals('en'));
      await dao.setLanguage('bn');
      expect(await dao.getLanguage(), equals('bn'));
      await dao.setLanguage('en');
      expect(await dao.getLanguage(), equals('en'));
    });

    test('DbMeta schema version, data version, and generated at', () async {
      expect(await dao.getSchemaVersion(), isNull);
      expect(await dao.getDataVersion(), isNull);
      expect(await dao.getGeneratedAt(), isNull);

      final nowIso = DateTime.now().toIso8601String();
      await db
          .into(db.dbMeta)
          .insert(
            const DbMetaCompanion(
              key: Value('schema_version'),
              value: Value('2'),
            ),
          );
      await db
          .into(db.dbMeta)
          .insert(
            const DbMetaCompanion(
              key: Value('data_version'),
              value: Value('1'),
            ),
          );
      await db
          .into(db.dbMeta)
          .insert(
            DbMetaCompanion(
              key: const Value('generated_at'),
              value: Value(nowIso),
            ),
          );

      expect(await dao.getSchemaVersion(), equals('2'));
      expect(await dao.getDataVersion(), equals(1));
      expect(await dao.getGeneratedAt(), isNotNull);
    });

    test('Search history operations and cap limits', () async {
      expect(await dao.getSearchHistory(), isEmpty);

      // Add empty/whitespace
      await dao.addSearchHistory('   ');
      expect(await dao.getSearchHistory(), isEmpty);

      // Add queries
      await dao.addSearchHistory('amoxicillin');
      await dao.addSearchHistory('paracetamol');
      expect(
        await dao.getSearchHistory(),
        equals(['paracetamol', 'amoxicillin']),
      );

      // Deduplication (moves to front)
      await dao.addSearchHistory('amoxicillin');
      expect(
        await dao.getSearchHistory(),
        equals(['amoxicillin', 'paracetamol']),
      );

      // Remove query
      await dao.removeSearchHistory('paracetamol');
      expect(await dao.getSearchHistory(), equals(['amoxicillin']));

      // Overflow > 15 items
      for (int i = 0; i < 20; i++) {
        await dao.addSearchHistory('medicine_$i');
      }
      final history = await dao.getSearchHistory();
      expect(history.length, equals(15));
      expect(history.first, equals('medicine_19'));

      // Clear search history
      await dao.clearSearchHistory();
      expect(await dao.getSearchHistory(), isEmpty);
    });

    test('Search telemetry logSearchEvent and zero-result logging', () async {
      expect(await dao.getZeroResultQueries(), isEmpty);

      // Non-zero result query does not log as zero-result
      await dao.logSearchEvent('amoxicillin', 5, executionTimeMs: 12);
      expect(await dao.getZeroResultQueries(), isEmpty);

      // Zero result queries
      await dao.logSearchEvent('unknown_drug_1', 0, executionTimeMs: 15);
      await dao.logSearchEvent('unknown_drug_2', 0, executionTimeMs: 20);
      final zeroResults = await dao.getZeroResultQueries();
      expect(zeroResults, containsAll(['unknown_drug_1', 'unknown_drug_2']));

      // Empty query is ignored
      await dao.logSearchEvent('   ', 0);
      expect((await dao.getZeroResultQueries()).length, equals(2));

      // Max entries cap (>50)
      for (int i = 0; i < 55; i++) {
        await dao.logSearchEvent('zero_$i', 0);
      }
      final cappedZeroResults = await dao.getZeroResultQueries();
      expect(cappedZeroResults.length, lessThanOrEqualTo(50));
    });
  });
}

Value<T?> driftValue<T>(T? val) => Value(val);
