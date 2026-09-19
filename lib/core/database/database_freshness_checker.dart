import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/// Service that verifies offline SQLite database file freshness,
/// schema integrity, and triggers clean asset refreshes across app updates.
class DatabaseFreshnessChecker {
  static const List<String> databaseFiles = ['products.db', 'teams.db'];
  static const List<String> legacyDatabaseFiles = [
    'team.db',
    'distributors.db',
  ];

  /// Safely purges legacy database files from older application releases.
  static Future<void> purgeLegacyDatabases() async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      for (final legacyName in legacyDatabaseFiles) {
        final legacyPath = p.join(docDir.path, legacyName);
        for (final ext in ['', '-journal', '-wal', '-shm', '.version']) {
          final f = File('$legacyPath$ext');
          if (f.existsSync()) {
            try {
              f.deleteSync();
            } catch (e) {
              debugPrint('Error deleting legacy DB file ${f.path}: $e');
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error purging legacy databases: $e');
    }
  }

  /// Checks the integrity and metadata version of all local SQLite databases.
  static Future<Map<String, dynamic>> checkLocalDatabaseHealth() async {
    await purgeLegacyDatabases();
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
