---
name: offline-database-pipeline
description: Use when managing the pre-populated SQLite asset database, initial copy pipelines, data seeding, offline data synchronization, database corruption recovery, or SQLite foreign key pragmas in this Flutter project.
---

# Offline Database Asset Pipeline & Synchronization

`impulse_dex` is designed as an **offline-first** catalog application. It packages a pre-populated SQLite database in its assets bundle (`assets/db/impulse.db`) and exposes it through Drift with background isolates, FTS5 search, and full relational capabilities.

---

## 1. Database Asset Seeding & Lifecycle

### Initialization Workflow
1. **First Run Check**: On first launch, check if the local writable SQLite file exists in the device's application support/documents directory.
2. **Asset Copying**: If the database file does not exist, copy the binary asset from `assets/db/impulse.db` to the local target path before opening Drift.
3. **Version Check & Delta Updates**: On app updates, compare stored schema/data version against the bundled asset version. If an updated bundled asset is shipped, execute an in-place migration or targeted replacement.

### Pre-Bundled Database Setup Pattern
```dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<File> getOrCopyBundledDatabase({
  required String assetPath,
  required String dbFileName,
  bool forceOverwrite = false,
}) async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final dbFile = File(p.join(dbFolder.path, dbFileName));

  if (forceOverwrite || !await dbFile.exists()) {
    // Ensure parent directory exists
    await dbFile.parent.create(recursive: true);

    // Copy from Flutter asset bundle to documents directory
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await dbFile.writeAsBytes(bytes, flush: true);
  }

  return dbFile;
}
```

---

## 2. Drift Native Database Connection with Isolate

Ensure Drift queries execute off the UI thread and enable SQLite foreign key constraints:

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

LazyDatabase openAppDatabaseConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'impulse_dex.sqlite'));

    // Copy bundled DB if not present
    if (!await file.exists()) {
      await getOrCopyBundledDatabase(
        assetPath: 'assets/db/impulse.db',
        dbFileName: 'impulse_dex.sqlite',
      );
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) {
        // Enforce SQLite Foreign Keys
        rawDb.execute('PRAGMA foreign_keys = ON;');
        // Optimize write performance and concurrency
        rawDb.execute('PRAGMA journal_mode = WAL;');
        rawDb.execute('PRAGMA synchronous = NORMAL;');
      },
    );
  });
}
```

---

## 3. FTS5 Indexing & Data Integrity Verification

When shipping pre-populated tables, ensure Full-Text Search (FTS5) virtual tables remain in sync:

### FTS5 Shadow Table Sync Verification
```dart
Future<void> verifyFtsConsistency(AppDatabase db) async {
  // Re-populate FTS5 index if out of sync
  await db.customStatement('''
    INSERT OR REPLACE INTO products_fts(rowid, name, generic_name, category, manufacturer)
    SELECT id, name, generic_name, category, manufacturer FROM products;
  ''');
}
```

### Database Integrity Check
Run `PRAGMA integrity_check;` before critical migrations or when catching unexpected SQLite exceptions:
```dart
Future<bool> checkDatabaseHealth(AppDatabase db) async {
  try {
    final result = await db.customSelect('PRAGMA integrity_check;').getSingle();
    final status = result.data.values.first.toString();
    return status.toLowerCase() == 'ok';
  } catch (_) {
    return false;
  }
}
```

---

## 4. Disaster Recovery & Asset Reset

If the local SQLite database becomes corrupted or a user requests a database reset:
1. Close the active Drift connection.
2. Delete the local `.sqlite`, `.sqlite-wal`, and `.sqlite-shm` files.
3. Re-copy fresh database from `assets/db/impulse.db`.
4. Re-initialize the Drift database provider.
