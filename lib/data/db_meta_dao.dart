import 'package:drift/drift.dart';
import 'package:impulse_dex/data/db_extensions.dart';

class DbMetaDao {
  final QueryExecutor db;
  DbMetaDao(this.db);

  Future<String?> getValue(String key) async {
    final rows = await db.query(
      'db_meta',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first['value'] as String?;
  }

  Future<Map<String, String>> getAll() async {
    final rows = await db.query('db_meta');
    return {for (final r in rows) r['key'] as String: r['value'] as String};
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
