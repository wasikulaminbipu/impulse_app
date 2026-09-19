import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/core/database/database_freshness_checker.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DatabaseFreshnessChecker Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync('db_freshness_test_');

      // Mock path_provider method channel
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async {
              if (methodCall.method == 'getApplicationDocumentsDirectory') {
                return tempDir.path;
              }
              return null;
            },
          );
    });

    tearDown(() {
      try {
        tempDir.deleteSync(recursive: true);
      } catch (_) {}
    });

    test('reports missing status when database files do not exist', () async {
      final report = await DatabaseFreshnessChecker.checkLocalDatabaseHealth();

      final productsReport = report['products.db'] as Map<String, dynamic>;
      final distReport = report['teams.db'] as Map<String, dynamic>;

      expect(productsReport['status'], equals('missing'));
      expect(distReport['status'], equals('missing'));
    });

    test(
      'reports healthy status and metadata for valid SQLite databases',
      () async {
        final productsDbPath = p.join(tempDir.path, 'products.db');
        final db = sqlite3.open(productsDbPath);
        db.execute('CREATE TABLE db_meta (key TEXT PRIMARY KEY, value TEXT);');
        db.execute(
          "INSERT INTO db_meta (key, value) VALUES ('data_version', '4'), ('schema_version', '2');",
        );
        db.close();

        final report =
            await DatabaseFreshnessChecker.checkLocalDatabaseHealth();
        final productsReport = report['products.db'] as Map<String, dynamic>;
        final distReport = report['teams.db'] as Map<String, dynamic>;

        expect(productsReport['status'], equals('healthy'));
        expect(productsReport['dataVersion'], equals(4));
        expect(productsReport['schemaVersion'], equals(2));
        expect(distReport['status'], equals('missing'));
      },
    );

    test('purges legacy database files during health check', () async {
      final legacyDbPath = p.join(tempDir.path, 'team.db');
      final legacyVersionPath = p.join(tempDir.path, 'team.db.version');
      final legacyWalPath = p.join(tempDir.path, 'team.db-wal');
      final legacyDistPath = p.join(tempDir.path, 'distributors.db');

      File(legacyDbPath).writeAsStringSync('legacy db');
      File(legacyVersionPath).writeAsStringSync('1.0');
      File(legacyWalPath).writeAsStringSync('wal');
      File(legacyDistPath).writeAsStringSync('dist');

      expect(File(legacyDbPath).existsSync(), isTrue);
      expect(File(legacyVersionPath).existsSync(), isTrue);
      expect(File(legacyWalPath).existsSync(), isTrue);
      expect(File(legacyDistPath).existsSync(), isTrue);

      await DatabaseFreshnessChecker.checkLocalDatabaseHealth();

      expect(File(legacyDbPath).existsSync(), isFalse);
      expect(File(legacyVersionPath).existsSync(), isFalse);
      expect(File(legacyWalPath).existsSync(), isFalse);
      expect(File(legacyDistPath).existsSync(), isFalse);
    });
  });
}
