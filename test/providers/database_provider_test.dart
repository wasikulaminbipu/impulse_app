import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/providers/database_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Database Provider Tests', () {
    late Directory tempDir;
    late ProviderContainer container;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('db_provider_test_');

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

      container = ProviderContainer();
    });

    tearDown(() async {
      container.dispose();
      try {
        tempDir.deleteSync(recursive: true);
      } catch (_) {}
    });

    test(
      'getAppDbPath resolves path inside application documents directory',
      () async {
        final path = await getAppDbPath('test_app.db');
        expect(path, contains(tempDir.path));
        expect(path.endsWith('test_app.db'), isTrue);
      },
    );

    test('appMaintenanceDatabase provider initializes AppMaintenanceDb with WAL journal', () async {
      final db = await container.read(appMaintenanceDatabaseProvider.future);
      expect(db, isA<AppMaintenanceDb>());

      await db.createMigrator().createAll();
      final path = await getAppDbPath('app_maintenance.db');
      expect(File(path).existsSync(), isTrue);

      final tables = db.allTables;
      expect(tables, isNotEmpty);
    });
  });
}
