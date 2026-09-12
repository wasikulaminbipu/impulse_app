import 'package:drift/drift.dart';

class NoOpUser extends QueryExecutorUser {
  NoOpUser();
  @override
  int get schemaVersion => 1;
  @override
  Future<void> beforeOpen(
    QueryExecutor executor,
    OpeningDetails details,
  ) async {}
}

/// Helper extensions on Drift's [QueryExecutor].
///
/// NOTE: Direct raw SQL querying is deprecated in favor of Drift's type-safe
/// query builder (`db.select`, `db.selectOnly`, companion inserts/updates).
extension QueryExecutorX on QueryExecutor {
  @Deprecated('Use Drift select queries instead of raw SQL strings')
  Future<List<Map<String, dynamic>>> customQuery(
    String sql, [
    List<Object?> args = const [],
  ]) async {
    await ensureOpen(NoOpUser());
    return runSelect(sql, args);
  }

  @Deprecated(
    'Use Drift companion inserts/updates or schema migrations instead',
  )
  Future<void> customExecute(
    String sql, [
    List<Object?> args = const [],
  ]) async {
    await ensureOpen(NoOpUser());
    await runCustom(sql, args);
  }

  @Deprecated('Use Drift type-safe select queries instead of query()')
  Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final String cols = columns != null ? columns.join(', ') : '*';
    String sql = 'SELECT $cols FROM $table';
    if (where != null) sql += ' WHERE $where';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    if (limit != null) sql += ' LIMIT $limit';
    if (offset != null) sql += ' OFFSET $offset';
    // ignore: deprecated_member_use_from_same_package
    return customQuery(sql, whereArgs ?? []);
  }

  @Deprecated(
    'Use Drift isIn() expression on column instead of chunkedInQuery()',
  )
  Future<List<Map<String, dynamic>>> chunkedInQuery({
    required String prefix,
    required List<int> ids,
    String suffix = '',
    int chunkSize = 500,
  }) async {
    if (ids.isEmpty) return [];

    final results = <Map<String, dynamic>>[];
    for (var i = 0; i < ids.length; i += chunkSize) {
      final end = (i + chunkSize > ids.length) ? ids.length : i + chunkSize;
      final chunk = ids.sublist(i, end);
      final placeholders = List.filled(chunk.length, '?').join(',');
      final sql = '$prefix($placeholders)$suffix';
      // ignore: deprecated_member_use_from_same_package
      results.addAll(await customQuery(sql, chunk));
    }
    return results;
  }
}
