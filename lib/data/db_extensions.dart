import 'package:drift/drift.dart';

class NoOpUser extends QueryExecutorUser {
  NoOpUser();
  @override
  int get schemaVersion => 1;
  @override
  Future<void> beforeOpen(QueryExecutor executor, OpeningDetails details) async {}
}

extension QueryExecutorX on QueryExecutor {
  Future<List<Map<String, dynamic>>> customQuery(String sql, [List<Object?> args = const []]) async {
    await ensureOpen(NoOpUser());
    return runSelect(sql, args);
  }

  Future<void> customExecute(String sql, [List<Object?> args = const []]) async {
    await ensureOpen(NoOpUser());
    await runCustom(sql, args);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    String cols = columns != null ? columns.join(', ') : '*';
    String sql = 'SELECT $cols FROM $table';
    if (where != null) sql += ' WHERE $where';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    if (limit != null) sql += ' LIMIT $limit';
    if (offset != null) sql += ' OFFSET $offset';
    return customQuery(sql, whereArgs ?? []);
  }
}
