import 'package:drift/drift.dart';
import 'package:impulse_app/data/app_databases.dart';

class DbMetaDao {
  final GeneratedDatabase db;
  DbMetaDao(this.db);

  $DbMetaTable get _metaTable => $DbMetaTable(db);

  Future<String?> getValue(String key) async {
    final row =
        await (db.select(_metaTable)
              ..where((t) => t.key.equals(key))
              ..limit(1))
            .getSingleOrNull();
    return row?.value;
  }

  Future<Map<String, String>> getAll() async {
    final rows = await db.select(_metaTable).get();
    return {for (final r in rows) r.key: r.value ?? ''};
  }

  Future<int?> getSchemaVersion() async {
    final v = await getValue('schema_version');
    return v == null ? null : int.tryParse(v);
  }

  Future<int?> getDataVersion() async {
    final v = await getValue('data_version');
    return v == null ? null : int.tryParse(v);
  }

  Future<DateTime?> getGeneratedAt() async {
    final v = await getValue('generated_at');
    return v == null ? null : DateTime.tryParse(v);
  }
}
