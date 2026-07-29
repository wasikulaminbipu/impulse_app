import 'package:drift/drift.dart';

/// Sanitizes search tokens (preserving alphanumeric and Bengali characters)
/// to make them safe for SQLite FTS5 matching.
String sanitizeFtsQuery(String query) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return '';
  return trimmed
      .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
      .trim()
      .split(RegExp(r'\s+'))
      .where((t) => t.isNotEmpty)
      .map((t) => '$t*')
      .join(' ');
}

/// Checks if an FTS table is fully populated and marked ready in db_meta.
Future<bool> isFtsReady(QueryExecutor db, String tableName) async {
  try {
    final rows = await db.runSelect(
      "SELECT value FROM db_meta WHERE key = ? LIMIT 1",
      ['fts_ready_$tableName'],
    );
    return rows.isNotEmpty && rows.first['value'] == '1';
  } catch (_) {
    return false;
  }
}
