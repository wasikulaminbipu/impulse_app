import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/// Service that verifies offline SQLite database file freshness,
/// schema integrity, and triggers clean asset refreshes across app updates.
class DatabaseFreshnessChecker {
  static const List<String> databaseFiles = ['products.db', 'distributors.db'];

  /// Checks the integrity and metadata version of all local SQLite databases.
  static Future<Map<String, dynamic>> checkLocalDatabaseHealth() async {
    final report = <String, dynamic>{};
    final docDir = await getApplicationDocumentsDirectory();

    for (final dbName in databaseFiles) {
      final dbPath = p.join(docDir.path, dbName);
      final file = File(dbPath);

      if (!file.existsSync()) {
        report[dbName] = {'status': 'missing', 'path': dbPath, 'sizeBytes': 0};
        continue;
      }

      final size = file.lengthSync();
      try {
        final db = sqlite3.open(dbPath);

        // Run SQLite PRAGMA integrity check
        final integrityResult = db.select('PRAGMA integrity_check;');
        final isHealthy =
            integrityResult.isNotEmpty &&
            integrityResult.first.values.first == 'ok';

        // Read db_meta if table exists
        int? dataVersion;
        int? schemaVersion;
        try {
          final metaRows = db.select('SELECT key, value FROM db_meta;');
          for (final row in metaRows) {
            final key = row['key'] as String?;
            final val = row['value'] as String?;
            if (key == 'data_version') {
              dataVersion = int.tryParse(val ?? '');
            }
            if (key == 'schema_version') {
              schemaVersion = int.tryParse(val ?? '');
            }
          }
        } catch (_) {}

        db.close();

        report[dbName] = {
          'status': isHealthy ? 'healthy' : 'corrupted',
          'path': dbPath,
          'sizeBytes': size,
          'dataVersion': dataVersion,
          'schemaVersion': schemaVersion,
        };
      } catch (e) {
        report[dbName] = {
          'status': 'error',
          'error': e.toString(),
          'path': dbPath,
          'sizeBytes': size,
        };
      }
    }

    debugPrint('📊 Database Freshness & Health Report: $report');
    return report;
  }
}
