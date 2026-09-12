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
      final distReport = report['team.db'] as Map<String, dynamic>;

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
        final distReport = report['team.db'] as Map<String, dynamic>;

        expect(productsReport['status'], equals('healthy'));
        expect(productsReport['dataVersion'], equals(4));
        expect(productsReport['schemaVersion'], equals(2));
        expect(distReport['status'], equals('missing'));
      },
    );
  });
}
