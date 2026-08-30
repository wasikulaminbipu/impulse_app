import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main(List<String> args) {
  stdout.writeln('====================================================');
  stdout.writeln(' 🗄️ Impulse DEX - SQLite Asset Integrity Validator');
  stdout.writeln('====================================================');

  final productsDbFile = File('assets/db/products.db');
  final distributorsDbFile = File('assets/db/distributors.db');

  var allPassed = true;

  if (!productsDbFile.existsSync()) {
    stderr.writeln('❌ Error: assets/db/products.db does not exist!');
    exit(1);
  }

  if (!distributorsDbFile.existsSync()) {
    stderr.writeln('❌ Error: assets/db/distributors.db does not exist!');
    exit(1);
  }

  stdout.writeln(
    '\n📦 Checking products.db (${productsDbFile.lengthSync()} bytes)...',
  );
  try {
    final db = sqlite3.open(productsDbFile.path);

    // 1. Integrity Check
    final integrityResult = db.select('PRAGMA integrity_check;');
    final integrityStatus = integrityResult.first.values.first.toString();
    if (integrityStatus == 'ok') {
      stdout.writeln('  ✅ PRAGMA integrity_check: OK');
    } else {
      stderr.writeln('  ❌ Integrity Check FAILED: $integrityStatus');
      allPassed = false;
    }

    // 2. Query available tables
    final tables = db.select(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );
    final tableNames = tables.map((r) => r['name'] as String).toList();
    stdout.writeln('  📑 Tables found: ${tableNames.join(', ')}');

    for (final table in ['products', 'manufacturers', 'categories']) {
      if (tableNames.contains(table)) {
        final count =
            db.select('SELECT COUNT(*) AS count FROM $table;').first['count']
                as int;
        stdout.writeln('  📊 $table: $count records');
        if (count == 0) {
          stderr.writeln('  ⚠️ Table $table has 0 records');
        }
      } else {
        stderr.writeln('  ❌ Missing essential table: $table');
        allPassed = false;
      }
    }

    db.close();
  } catch (e) {
    stderr.writeln('  ❌ Error reading products.db: $e');
    allPassed = false;
  }

  stdout.writeln(
    '\n📦 Checking distributors.db (${distributorsDbFile.lengthSync()} bytes)...',
  );
  try {
    final db = sqlite3.open(distributorsDbFile.path);

    // 1. Integrity Check
    final integrityResult = db.select('PRAGMA integrity_check;');
    final integrityStatus = integrityResult.first.values.first.toString();
    if (integrityStatus == 'ok') {
      stdout.writeln('  ✅ PRAGMA integrity_check: OK');
    } else {
      stderr.writeln('  ❌ Integrity Check FAILED: $integrityStatus');
      allPassed = false;
    }

    // 2. Query available tables
    final tables = db.select(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );
    final tableNames = tables.map((r) => r['name'] as String).toList();
    stdout.writeln('  📑 Tables found: ${tableNames.join(', ')}');

    for (final table in [
      'sales_personnel',
      'distributors',
      'divisions',
      'districts',
      'areas',
    ]) {
      if (tableNames.contains(table)) {
        final count =
            db.select('SELECT COUNT(*) AS count FROM $table;').first['count']
                as int;
        stdout.writeln('  📊 $table: $count records');
      }
    }

    db.close();
  } catch (e) {
    stderr.writeln('  ❌ Error reading distributors.db: $e');
    allPassed = false;
  }

  stdout.writeln('\n----------------------------------------------------');
  if (allPassed) {
    stdout.writeln(
      '🎉 All SQLite database assets verified healthy and ready for release!',
    );
    exit(0);
  } else {
    stderr.writeln(
      '💥 Database verification failed! Fix errors before deploying.',
    );
    exit(1);
  }
}
