---
name: drift-database
description: Use when modifying local database schemas, creating queries, DAOs, handling SQLite, performing migrations, web worker setup, background isolate queries, or testing Drift in this Flutter project.
---

# Drift Database & SQLite Best Practices

This Flutter project uses **Drift** (formerly Moor) and `sqlite3_flutter_libs` / `drift_flutter` for local relational storage. Drift provides compile-time type safety, reactive streams, isolate support, web compilation, and robust schema migration tooling.

---

## 1. Setup & Architecture Patterns

### Recommended Packages
- **Runtime**: `drift`, `drift_flutter`, `sqlite3_flutter_libs`, `path_provider`, `path`
- **Dev Dependencies**: `drift_dev`, `build_runner`

### Architecture & Isolation
- **Database Class**: Central entry point annotated with `@DriftDatabase`. Contains table declarations, DAOs, schema version, and migration strategy.
- **DAOs (Data Access Objects)**: Extend `DatabaseAccessor<AppDatabase>` and use `@DriftAccessor` to group domain-specific queries (e.g., `ProductsDao`, `DistributorsDao`). Keep query logic out of UI controllers/providers.
- **Background Isolates**: Always use Drift's built-in isolate support (`NativeDatabase.createInBackground` or `drift_flutter`) to run SQLite operations off the main UI thread.

---

## 2. Table Definition & Data Types

Define tables by extending `Table`:

```dart
import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get genericName => text()();
  TextColumn get sku => text().unique()();
  TextColumn get category => text()();
  TextColumn get manufacturer => text()();
  RealColumn get price => real()();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {name, categoryId},
      ];
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
}
```

### Key Guidelines for Schema Design
1. **Type Safety**: Use explicit types (`IntColumn`, `TextColumn`, `RealColumn`, `BoolColumn`, `DateTimeColumn`, `BlobColumn`).
2. **Constraints**: Define primary keys, auto-incrementing IDs, default values, length bounds, foreign keys (`references`), and composite `uniqueKeys`.
3. **Type Converters**: For complex non-SQLite native data (JSON models, enums, lists), implement `TypeConverter<T, S>` or `EnumIndexConverter` / `EnumNameConverter`:
   ```dart
   class StringListConverter extends TypeConverter<List<String>, String> {
     const StringListConverter();
     @override
     List<String> fromSql(String fromDb) => (jsonDecode(fromDb) as List).cast<String>();
     @override
     String toSql(List<String> value) => jsonEncode(value);
   }
   ```

---

## 3. Query Execution & Reactive Streams

Prefer Drift's fluent type-safe query builder over raw SQL.

### Select / Filter / Join Queries
```dart
@DriftAccessor(tables: [Products, Categories])
class ProductsDao extends DatabaseAccessor<AppDatabase> with _$ProductsDaoMixin {
  ProductsDao(super.db);

  // Single item / List queries
  Future<List<Product>> getAvailableProducts() {
    return (select(products)..where((tbl) => tbl.isAvailable.equals(true))).get();
  }

  // Joined Query with Type Safety
  Future<List<ProductWithCategory>> getProductsWithCategory() {
    final query = select(products).join([
      leftOuterJoin(categories, categories.id.equalsExp(products.categoryId)),
    ]);
    return query.map((row) {
      return ProductWithCategory(
        product: row.readTable(products),
        category: row.readTableOrNull(categories),
      );
    }).get();
  }

  // Reactive Stream
  Stream<List<Product>> watchAvailableProducts() {
    return (select(products)
          ..where((tbl) => tbl.isAvailable.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }
}
```

### Writing Data (Insert, Update, Delete) & Batch Transactions
- Use companion classes (e.g., `ProductsCompanion`) for inserts/updates to handle unset vs null fields safely.
- Wrap multi-statement operations in `transaction(() async { ... })` or `batch()` to maximize write performance and ensure atomic commits.

```dart
Future<void> batchInsertProducts(List<ProductsCompanion> entries) async {
  await batch((batch) {
    batch.insertAll(products, entries, mode: InsertMode.insertOrReplace);
  });
}
```

---

## 4. Schema Versioning & Migrations

Never modify a column or table without incrementing `schemaVersion` and handling the migration.

### Migration Strategy Pattern
```dart
@DriftDatabase(tables: [Products, Categories], daos: [ProductsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.addColumn(products, products.categoryId);
          await m.createTable(categories);
        }
      },
      beforeOpen: (details) async {
        // Enforce SQLite Foreign Keys & Performance Pragmas
        await customStatement('PRAGMA foreign_keys = ON;');
        await customStatement('PRAGMA journal_mode = WAL;');
        await customStatement('PRAGMA synchronous = NORMAL;');
      },
    );
  }
}
```

### Verification & Testing Migrations
- Export database schema JSON via `dart run drift_dev schema dump lib/data/database/schema_v1.json`.
- Generate migration test code via `dart run drift_dev schema generate drift_schemas/ test/generated_migrations/`.
- Test schema transitions programmatically in `flutter test` using `SchemaVerifier`.

---

## 5. In-Memory Database for Unit & Widget Tests

When writing tests, use in-memory SQLite instances to run fast, isolated tests:
```dart
AppDatabase createTestDatabase() {
  return AppDatabase(NativeDatabase.memory());
}
```

---

## 6. Build & Code Generation Commands

After updating table definitions, DAOs, converters, or schema versions, run:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Continuous watch during development
dart run build_runner watch --delete-conflicting-outputs
```

### Code Quality Verification Gate
Always execute analysis after updating database code:
```bash
flutter analyze
```
