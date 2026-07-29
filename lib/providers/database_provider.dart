import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:drift/native.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:impulse_dex/data/app_databases.dart';

part 'database_provider.g.dart';

// ---------------------------------------------------------------------------
// Riverpod providers — now return typed Drift database wrappers.
// The DAO layer accepts QueryExecutor, so existing DAOs need no changes.
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
Future<ProductsDb> productsDatabase(Ref ref) async {
  final db = await copyAndOpenAssetDb(
    'products.db',
    'products.db',
    (executor) => ProductsDb(executor),
    setupProductsFts,
  );
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
Future<DistributorsDb> distributorsDatabase(Ref ref) async {
  final db = await copyAndOpenAssetDb(
    'distributors.db',
    'distributors.db',
    (executor) => DistributorsDb(executor),
    setupDistributorsFts,
  );
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
Future<AppMaintenanceDb> appMaintenanceDatabase(Ref ref) async {
  final dbPath = await getAppDbPath('app_maintenance.db');
  final file = File(dbPath);
  final executor = NativeDatabase(
    file,
    setup: (rawDb) {
      try {
        rawDb.execute('PRAGMA journal_mode=WAL;');
        rawDb.execute('PRAGMA foreign_keys=ON;');
      } catch (e, st) { debugPrint('AppMaintenance DB journal setup error: $e\n$st'); }
    },
  );

  final db = AppMaintenanceDb(executor);
  ref.onDispose(db.close);
  return db;
}
