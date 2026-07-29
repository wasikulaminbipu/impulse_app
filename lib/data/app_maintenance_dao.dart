import 'package:impulse_dex/data/db_extensions.dart';
import 'package:drift/drift.dart';
import 'package:impulse_dex/models/app_maintenance.dart';

class AppMaintenanceDao {
  AppMaintenanceDao(this._db);

  final QueryExecutor _db;

  // ---------------- Favorites (generic, all four tables) ----------------
  Future<void> addFavorite(FavoriteType type, int id) async {
    await _db.customExecute(
      'INSERT OR IGNORE INTO ${type.table} (${type.idColumn}) VALUES (?)',
      [id],
    );
  }

  Future<void> removeFavorite(FavoriteType type, int id) async {
    await _db.customExecute(
      'DELETE FROM ${type.table} WHERE ${type.idColumn} = ?',
      [id],
    );
  }

  Future<bool> isFavorite(FavoriteType type, int id) async {
    final rows = await _db.customQuery(
      'SELECT 1 FROM ${type.table} WHERE ${type.idColumn} = ? LIMIT 1',
      [id],
    );
    return rows.isNotEmpty;
  }

  Future<void> toggleFavorite(FavoriteType type, int id) async {
    if (await isFavorite(type, id)) {
      await removeFavorite(type, id);
    } else {
      await addFavorite(type, id);
    }
  }

  Future<List<FavoriteEntry>> getFavorites(FavoriteType type) async {
    final rows = await _db.customQuery(
      'SELECT * FROM ${type.table} ORDER BY added_at DESC',
    );
    return rows.map((m) => FavoriteEntry.fromMap(m, type.idColumn)).toList();
  }

  Future<List<int>> getFavoriteIds(FavoriteType type) async {
    final rows = await _db.customQuery(
      'SELECT ${type.idColumn} FROM ${type.table}',
    );
    return rows.map((m) => m[type.idColumn] as int).toList();
  }

  // ---------------- app_settings ----------------

  Future<String?> getSetting(String key) async {
    final rows = await _db.customQuery(
      'SELECT value FROM app_settings WHERE key = ? LIMIT 1',
      [key],
    );
    if (rows.isEmpty) return null;
    return rows.first['value'] as String?;
  }

  Future<void> setSetting(String key, String? value) async {
    await _db.customExecute(
      'INSERT OR REPLACE INTO app_settings (key, value) VALUES (?, ?)',
      [key, value],
    );
  }

  Future<List<AppSetting>> getAllSettings() async {
    final rows = await _db.customQuery('SELECT * FROM app_settings');
    return rows.map(AppSetting.fromMap).toList();
  }

  Future<bool> getDarkMode() async => (await getSetting('dark_mode')) == 'true';
  Future<void> setDarkMode(bool enabled) =>
      setSetting('dark_mode', enabled.toString());

  Future<String> getLanguage() async => (await getSetting('language')) ?? 'en';
  Future<void> setLanguage(String code) => setSetting('language', code);

  // ---------------- db_meta ----------------

  Future<String?> getSchemaVersion() async {
    final rows = await _db.customQuery(
      'SELECT value FROM db_meta WHERE key = ? LIMIT 1',
      ['schema_version'],
    );
    return rows.isEmpty ? null : rows.first['value'] as String?;
  }

  Future<DateTime?> getGeneratedAt() async {
    final rows = await _db.customQuery(
      'SELECT value FROM db_meta WHERE key = ? LIMIT 1',
      ['generated_at'],
    );
    if (rows.isEmpty) return null;
    return DateTime.parse(rows.first['value'] as String);
  }
}
