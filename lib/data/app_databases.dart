import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/maintenance_tables.dart';
import 'package:impulse_app/data/products_tables.dart';
import 'package:impulse_app/data/distributors_tables.dart';
import 'package:impulse_app/data/fts_utils.dart';

part 'app_databases.g.dart';

// ---------------------------------------------------------------------------
// Minimal GeneratedDatabase wrappers
//
// Drift's NativeDatabase uses a SERIAL executor. Calling customStatement /
// customSelect from *inside* beforeOpen re-enters the same executor while it
// is still blocked in ensureOpen → deadlock / infinite splash-screen hang.
//
// Fix: keep beforeOpen a no-op for asset DBs and perform FTS creation + seeding
// AFTER ensureOpen completes, by calling the raw executor directly via
// NativeDatabase.opened (sqlite3 raw handle injected via the setup callback).
// We use NativeDatabase(logStatements:false) with a setup callback that
// captures the raw db handle so we can run DDL outside of beforeOpen.
// ---------------------------------------------------------------------------

/// Base wrapper used by [ProductsDb] and [DistributorsDb].
// ---------------------------------------------------------------------------

/// Thin Drift wrapper around products.db.
@DriftDatabase(tables: [
  Categories,
  TargetGroups,
  ContentTypes,
  ProductTypes,
  Species,
  DosageUnits,
  DosageBases,
  Manufacturers,
  Products,
  ProductTargetGroups,
  Compositions,
  Indications,
  Directions,
  Precautions,
  Presentations,
])
class ProductsDb extends _$ProductsDb {
  ProductsDb(super.executor);

  @override
  int get schemaVersion => 1;
}

/// Thin Drift wrapper around distributors.db.
@DriftDatabase(tables: [
  Divisions,
  Districts,
  Upazilas,
  Regions,
  Areas,
  Bases,
  BaseUpazilas,
  Distributors,
  SalesPersonnel,
  SalesPersonnelRegions,
  SalesPersonnelAreas,
  SalesPersonnelBases,
  SalesPersonnelUpazilas,
  VetDoctors,
  VetDoctorsRegions,
  VetDoctorsAreas,
  VetDoctorsBases,
  VetDoctorsUpazilas,
])
class DistributorsDb extends _$DistributorsDb {
  DistributorsDb(super.executor);

  @override
  int get schemaVersion => 1;
}

/// Proper Drift database for app_maintenance.db
@DriftDatabase(tables: [
  FavoriteProducts,
  FavoriteDistributors,
  FavoriteSalesPersonnel,
  FavoriteVetDoctors,
  AppSettings,
  DbMeta,
])
class AppMaintenanceDb extends _$AppMaintenanceDb {
  AppMaintenanceDb(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Future schema migrations go here
        },
      );
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Future<String> getAppDbPath(String dbName) async {
  final dir = await getApplicationDocumentsDirectory();
  return p.join(dir.path, dbName);
}

void _deleteDbFiles(String dbPath) {
  for (final path in [dbPath, '$dbPath-journal', '$dbPath-wal', '$dbPath-shm']) {
    final f = File(path);
    if (f.existsSync()) {
      try {
        f.deleteSync();
      } catch (e, st) { debugPrint('DB delete error: $e\n$st'); }
    }
  }
}

/// Opens [executor] via [_NoOpUser] (no migration / beforeOpen side-effects)
/// and then executes [sql] statements directly on the raw executor to set up
/// FTS tables. This avoids any re-entrancy into the serial NativeDatabase.
Future<void> _runRaw(QueryExecutor executor, List<String> statements) async {
  await executor.ensureOpen(NoOpUser());
  for (final sql in statements) {
    await executor.runCustom(sql, const []);
  }
}

Future<List<Map<String, dynamic>>> _selectRaw(
  QueryExecutor executor,
  String sql,
) async {
  await executor.ensureOpen(NoOpUser());
  return executor.runSelect(sql, const []);
}

/// Copies the bundled asset DB to the documents directory (if needed or if size differs), then
/// opens it with [NativeDatabase] and sets up FTS tables outside of beforeOpen.
Future<T> copyAndOpenAssetDb<T extends GeneratedDatabase>(
  String assetName,
  String dbName,
  T Function(QueryExecutor) wrap,
  Future<void> Function(QueryExecutor executor) ftsSetup,
) async {
  final dbPath = await getAppDbPath(dbName);
  final file = File(dbPath);

  final versionFile = File('$dbPath.version');

  ByteData byteData;
  try {
    byteData = await rootBundle.load('assets/db/$assetName');
  } catch (e) {
    throw Exception('Failed to load database asset "assets/db/$assetName": $e');
  }

  if (byteData.lengthInBytes == 0) {
    throw Exception('Database asset "assets/db/$assetName" has empty data.');
  }

  final assetBytes = byteData.buffer.asUint8List(
    byteData.offsetInBytes,
    byteData.lengthInBytes,
  );
  String assetSig = '${assetBytes.length}_${assetBytes.first}_${assetBytes.last}';
  if (assetBytes.length >= 100) {
    // Include the SQLite file change counter (bytes 24-27) which increments on every transaction
    assetSig += '_${assetBytes[24]}_${assetBytes[25]}_${assetBytes[26]}_${assetBytes[27]}';
  }

  final needsCopy = !await file.exists() ||
      !await versionFile.exists() ||
      (await versionFile.readAsString()).trim() != assetSig;

  if (needsCopy) {
    _deleteDbFiles(dbPath);
    await file.create(recursive: true);
    await file.writeAsBytes(assetBytes, flush: true);
    await versionFile.writeAsString(assetSig, flush: true);
  }

  final executor = NativeDatabase(
    file,
    setup: (rawDb) {
      try {
        rawDb.execute('PRAGMA journal_mode=OFF;');
        rawDb.execute('PRAGMA foreign_keys=ON;');
      } catch (e, st) { debugPrint('DB setup error: $e\n$st'); }
    },
  );

  // Run FTS setup asynchronously in the background after returning the database connection.
  // This allows instant app startup while FTS tables are built concurrently.
  unawaited(
    Future.microtask(() async {
      try {
        await ftsSetup(executor);
        await optimizeAllFtsTables(executor);
      } catch (e) {
        // ignore: avoid_print
        print('FTS setup exception for $dbName (non-fatal): $e');
      }
    }),
  );

  return wrap(executor);
}

// ---------------------------------------------------------------------------
// FTS setup helpers — executed on the raw executor, outside of beforeOpen.
// ---------------------------------------------------------------------------

Future<bool> _isFtsTableReady(QueryExecutor executor, String tableName) async {
  try {
    final rows = await _selectRaw(
      executor,
      "SELECT value FROM db_meta WHERE key = 'fts_ready_$tableName'",
    );
    return rows.isNotEmpty && rows.first['value'] == '1';
  } catch (_) {
    return false;
  }
}

Future<void> _setFtsTableReady(
  QueryExecutor executor,
  String tableName,
  bool ready,
) async {
  try {
    if (ready) {
      await _runRaw(executor, [
        "INSERT OR REPLACE INTO db_meta (key, value) VALUES ('fts_ready_$tableName', '1')",
      ]);
    } else {
      await _runRaw(executor, [
        "DELETE FROM db_meta WHERE key = 'fts_ready_$tableName'",
      ]);
    }
  } catch (e, st) { debugPrint('FTS mark ready error: $e\n$st'); }
}

Future<void> _buildSingleFtsTable({
  required QueryExecutor executor,
  required String tableName,
  required String createSql,
  required String populateSql,
  List<String> extraSql = const [],
}) async {
  if (await _isFtsTableReady(executor, tableName)) {
    try {
      await _runRaw(executor, ["INSERT INTO $tableName($tableName) VALUES('optimize');"]);
    } catch (e, st) {
      debugPrint('FTS periodic optimize error ($tableName): $e\n$st');
    }
    return;
  }

  // Ensure status is marked unready first
  await _setFtsTableReady(executor, tableName, false);

  // Drop any existing table/dirty state from an incomplete prior run
  await _runRaw(executor, ['DROP TABLE IF EXISTS $tableName;']);

  // Create virtual table
  await _runRaw(executor, [createSql]);

  // Wrap population and triggers in a transaction for atomicity
  await _runRaw(executor, [
    'BEGIN TRANSACTION;',
    populateSql,
    ...extraSql,
    'COMMIT;',
  ]);

  // Mark as ready only after full transaction successfully completes
  await _setFtsTableReady(executor, tableName, true);

  // Consolidate & optimize FTS index segments post-creation
  try {
    await _runRaw(executor, ["INSERT INTO $tableName($tableName) VALUES('optimize');"]);
  } catch (e, st) {
    debugPrint('FTS post-build optimize error ($tableName): $e\n$st');
  }
}

Future<void> setupProductsFts(QueryExecutor executor) async {
  await _buildSingleFtsTable(
    executor: executor,
    tableName: 'products_fts',
    createSql: '''
    CREATE VIRTUAL TABLE IF NOT EXISTS products_fts
    USING fts5(
      title_en,
      title_bn,
      motto_en,
      short_description_en,
      category_en,
      category_bn,
      tokenize='unicode61 remove_diacritics 2'
    )
    ''',
    populateSql: '''
    INSERT INTO products_fts(rowid, title_en, title_bn, motto_en, short_description_en, category_en, category_bn)
    SELECT p.id, p.title_en, p.title_bn, p.motto_en, p.short_description_en, c.name_en, c.name_bn
    FROM products p
    LEFT JOIN categories c ON c.id = p.category_id
    ''',
    extraSql: const [
      '''
      CREATE TRIGGER IF NOT EXISTS products_ai AFTER INSERT ON products BEGIN
        INSERT INTO products_fts(rowid, title_en, title_bn, motto_en, short_description_en, category_en, category_bn)
        SELECT new.id, new.title_en, new.title_bn, new.motto_en, new.short_description_en, c.name_en, c.name_bn
        FROM (SELECT 1) LEFT JOIN categories c ON c.id = new.category_id;
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS products_ad AFTER DELETE ON products BEGIN
        DELETE FROM products_fts WHERE rowid = old.id;
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS products_au AFTER UPDATE ON products BEGIN
        DELETE FROM products_fts WHERE rowid = old.id;
        
        INSERT INTO products_fts(rowid, title_en, title_bn, motto_en, short_description_en, category_en, category_bn)
        SELECT new.id, new.title_en, new.title_bn, new.motto_en, new.short_description_en, c.name_en, c.name_bn
        FROM (SELECT 1) LEFT JOIN categories c ON c.id = new.category_id;
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS categories_au AFTER UPDATE ON categories BEGIN
        DELETE FROM products_fts WHERE rowid IN (SELECT id FROM products WHERE category_id = old.id);

        INSERT INTO products_fts(rowid, title_en, title_bn, motto_en, short_description_en, category_en, category_bn)
        SELECT p.id, p.title_en, p.title_bn, p.motto_en, p.short_description_en, new.name_en, new.name_bn
        FROM products p WHERE p.category_id = new.id;
      END;
      ''',
    ],
  );

  await _buildSingleFtsTable(
    executor: executor,
    tableName: 'products_trigram_fts',
    createSql: '''
    CREATE VIRTUAL TABLE IF NOT EXISTS products_trigram_fts
    USING fts5(
      title_en,
      title_bn,
      slug,
      tokenize='trigram'
    )
    ''',
    populateSql: '''
    INSERT INTO products_trigram_fts(rowid, title_en, title_bn, slug)
    SELECT p.id, p.title_en, p.title_bn, p.slug
    FROM products p
    ''',
  );
}

Future<void> setupDistributorsFts(QueryExecutor executor) async {
  // --- distributors_fts ---
  await _buildSingleFtsTable(
    executor: executor,
    tableName: 'distributors_fts',
    createSql: '''
    CREATE VIRTUAL TABLE IF NOT EXISTS distributors_fts
    USING fts5(
      name_en,
      name_bn,
      designation,
      address_en,
      address_bn,
      mobile,
      content=distributors,
      content_rowid=id,
      tokenize='unicode61 remove_diacritics 2'
    )
    ''',
    populateSql: '''
    INSERT INTO distributors_fts(rowid, name_en, name_bn, designation, address_en, address_bn, mobile)
    SELECT id, name_en, name_bn, designation, address_en, address_bn, mobile FROM distributors
    ''',
    extraSql: const [
      '''
      CREATE TRIGGER IF NOT EXISTS distributors_ai AFTER INSERT ON distributors BEGIN
        INSERT INTO distributors_fts(rowid, name_en, name_bn, designation, address_en, address_bn, mobile)
        VALUES (new.id, new.name_en, new.name_bn, new.designation, new.address_en, new.address_bn, new.mobile);
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS distributors_ad AFTER DELETE ON distributors BEGIN
        INSERT INTO distributors_fts(distributors_fts, rowid, name_en, name_bn, designation, address_en, address_bn, mobile)
        VALUES('delete', old.id, old.name_en, old.name_bn, old.designation, old.address_en, old.address_bn, old.mobile);
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS distributors_au AFTER UPDATE ON distributors BEGIN
        INSERT INTO distributors_fts(distributors_fts, rowid, name_en, name_bn, designation, address_en, address_bn, mobile)
        VALUES('delete', old.id, old.name_en, old.name_bn, old.designation, old.address_en, old.address_bn, old.mobile);
        INSERT INTO distributors_fts(rowid, name_en, name_bn, designation, address_en, address_bn, mobile)
        VALUES (new.id, new.name_en, new.name_bn, new.designation, new.address_en, new.address_bn, new.mobile);
      END;
      ''',
    ],
  );

  // --- sales_personnel_fts ---
  await _buildSingleFtsTable(
    executor: executor,
    tableName: 'sales_personnel_fts',
    createSql: '''
    CREATE VIRTUAL TABLE IF NOT EXISTS sales_personnel_fts
    USING fts5(
      name_en,
      name_bn,
      designation,
      mobile,
      email,
      employee_id,
      content=sales_personnel,
      content_rowid=id,
      tokenize='unicode61 remove_diacritics 2'
    )
    ''',
    populateSql: '''
    INSERT INTO sales_personnel_fts(rowid, name_en, name_bn, designation, mobile, email, employee_id)
    SELECT id, name_en, name_bn, designation, mobile, email, employee_id FROM sales_personnel
    ''',
    extraSql: const [
      '''
      CREATE TRIGGER IF NOT EXISTS sales_personnel_ai AFTER INSERT ON sales_personnel BEGIN
        INSERT INTO sales_personnel_fts(rowid, name_en, name_bn, designation, mobile, email, employee_id)
        VALUES (new.id, new.name_en, new.name_bn, new.designation, new.mobile, new.email, new.employee_id);
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS sales_personnel_ad AFTER DELETE ON sales_personnel BEGIN
        INSERT INTO sales_personnel_fts(sales_personnel_fts, rowid, name_en, name_bn, designation, mobile, email, employee_id)
        VALUES('delete', old.id, old.name_en, old.name_bn, old.designation, old.mobile, old.email, old.employee_id);
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS sales_personnel_au AFTER UPDATE ON sales_personnel BEGIN
        INSERT INTO sales_personnel_fts(sales_personnel_fts, rowid, name_en, name_bn, designation, mobile, email, employee_id)
        VALUES('delete', old.id, old.name_en, old.name_bn, old.designation, old.mobile, old.email, old.employee_id);
        INSERT INTO sales_personnel_fts(rowid, name_en, name_bn, designation, mobile, email, employee_id)
        VALUES (new.id, new.name_en, new.name_bn, new.designation, new.mobile, new.email, new.employee_id);
      END;
      ''',
    ],
  );

  // --- vet_doctors_fts ---
  await _buildSingleFtsTable(
    executor: executor,
    tableName: 'vet_doctors_fts',
    createSql: '''
    CREATE VIRTUAL TABLE IF NOT EXISTS vet_doctors_fts
    USING fts5(
      name_en,
      name_bn,
      qualification,
      specialization,
      bvc_registration_no,
      clinic_or_hospital_name_en,
      clinic_or_hospital_name_bn,
      address_en,
      address_bn,
      mobile,
      email,
      content=vet_doctors,
      content_rowid=id,
      tokenize='unicode61 remove_diacritics 2'
    )
    ''',
    populateSql: '''
    INSERT INTO vet_doctors_fts(
      rowid, name_en, name_bn, qualification, specialization,
      bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
      address_en, address_bn, mobile, email
    )
    SELECT
      id, name_en, name_bn, qualification, specialization,
      bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
      address_en, address_bn, mobile, email
    FROM vet_doctors
    ''',
    extraSql: const [
      '''
      CREATE TRIGGER IF NOT EXISTS vet_doctors_ai AFTER INSERT ON vet_doctors BEGIN
        INSERT INTO vet_doctors_fts(
          rowid, name_en, name_bn, qualification, specialization,
          bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
          address_en, address_bn, mobile, email
        )
        VALUES (
          new.id, new.name_en, new.name_bn, new.qualification, new.specialization,
          new.bvc_registration_no, new.clinic_or_hospital_name_en, new.clinic_or_hospital_name_bn,
          new.address_en, new.address_bn, new.mobile, new.email
        );
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS vet_doctors_ad AFTER DELETE ON vet_doctors BEGIN
        INSERT INTO vet_doctors_fts(
          vet_doctors_fts, rowid, name_en, name_bn, qualification, specialization,
          bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
          address_en, address_bn, mobile, email
        )
        VALUES(
          'delete', old.id, old.name_en, old.name_bn, old.qualification, old.specialization,
          old.bvc_registration_no, old.clinic_or_hospital_name_en, old.clinic_or_hospital_name_bn,
          old.address_en, old.address_bn, old.mobile, old.email
        );
      END;
      ''',
      '''
      CREATE TRIGGER IF NOT EXISTS vet_doctors_au AFTER UPDATE ON vet_doctors BEGIN
        INSERT INTO vet_doctors_fts(
          vet_doctors_fts, rowid, name_en, name_bn, qualification, specialization,
          bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
          address_en, address_bn, mobile, email
        )
        VALUES(
          'delete', old.id, old.name_en, old.name_bn, old.qualification, old.specialization,
          old.bvc_registration_no, old.clinic_or_hospital_name_en, old.clinic_or_hospital_name_bn,
          old.address_en, old.address_bn, old.mobile, old.email
        );
        INSERT INTO vet_doctors_fts(
          rowid, name_en, name_bn, qualification, specialization,
          bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn,
          address_en, address_bn, mobile, email
        )
        VALUES (
          new.id, new.name_en, new.name_bn, new.qualification, new.specialization,
          new.bvc_registration_no, new.clinic_or_hospital_name_en, new.clinic_or_hospital_name_bn,
          new.address_en, new.address_bn, new.mobile, new.email
        );
      END;
      ''',
    ],
  );
}
