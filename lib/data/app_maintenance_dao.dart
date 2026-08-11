import 'package:drift/drift.dart';
import 'package:impulse_dex/models/app_maintenance.dart' as models;
import 'package:impulse_dex/data/app_databases.dart';

class AppMaintenanceDao {
  AppMaintenanceDao(this._db);

  final AppMaintenanceDb _db;

  // ---------------- Favorites (generic, all four tables) ----------------
  Future<void> addFavorite(models.FavoriteType type, int id) async {
    switch (type) {
      case models.FavoriteType.product:
        await _db.into(_db.favoriteProducts).insert(
              FavoriteProductsCompanion.insert(productId: Value(id)),
              mode: InsertMode.insertOrIgnore,
            );
        break;
      case models.FavoriteType.distributor:
        await _db.into(_db.favoriteDistributors).insert(
              FavoriteDistributorsCompanion.insert(distributorId: Value(id)),
              mode: InsertMode.insertOrIgnore,
            );
        break;
      case models.FavoriteType.salesPersonnel:
        await _db.into(_db.favoriteSalesPersonnel).insert(
              FavoriteSalesPersonnelCompanion.insert(salesPersonnelId: Value(id)),
              mode: InsertMode.insertOrIgnore,
            );
        break;
      case models.FavoriteType.vetDoctor:
        await _db.into(_db.favoriteVetDoctors).insert(
              FavoriteVetDoctorsCompanion.insert(vetDoctorId: Value(id)),
              mode: InsertMode.insertOrIgnore,
            );
        break;
    }
  }

  Future<void> removeFavorite(models.FavoriteType type, int id) async {
    switch (type) {
      case models.FavoriteType.product:
        await (_db.delete(_db.favoriteProducts)..where((t) => t.productId.equals(id))).go();
        break;
      case models.FavoriteType.distributor:
        await (_db.delete(_db.favoriteDistributors)..where((t) => t.distributorId.equals(id))).go();
        break;
      case models.FavoriteType.salesPersonnel:
        await (_db.delete(_db.favoriteSalesPersonnel)..where((t) => t.salesPersonnelId.equals(id))).go();
        break;
      case models.FavoriteType.vetDoctor:
        await (_db.delete(_db.favoriteVetDoctors)..where((t) => t.vetDoctorId.equals(id))).go();
        break;
    }
  }

  Future<bool> isFavorite(models.FavoriteType type, int id) async {
    switch (type) {
      case models.FavoriteType.product:
        final q = _db.select(_db.favoriteProducts)..where((t) => t.productId.equals(id))..limit(1);
        return (await q.get()).isNotEmpty;
      case models.FavoriteType.distributor:
        final q = _db.select(_db.favoriteDistributors)..where((t) => t.distributorId.equals(id))..limit(1);
        return (await q.get()).isNotEmpty;
      case models.FavoriteType.salesPersonnel:
        final q = _db.select(_db.favoriteSalesPersonnel)..where((t) => t.salesPersonnelId.equals(id))..limit(1);
        return (await q.get()).isNotEmpty;
      case models.FavoriteType.vetDoctor:
        final q = _db.select(_db.favoriteVetDoctors)..where((t) => t.vetDoctorId.equals(id))..limit(1);
        return (await q.get()).isNotEmpty;
    }
  }

  Future<void> toggleFavorite(models.FavoriteType type, int id) async {
    if (await isFavorite(type, id)) {
      await removeFavorite(type, id);
    } else {
      await addFavorite(type, id);
    }
  }

  Future<List<models.FavoriteEntry>> getFavorites(models.FavoriteType type) async {
    switch (type) {
      case models.FavoriteType.product:
        final rows = await (_db.select(_db.favoriteProducts)
              ..orderBy([(t) => OrderingTerm.desc(t.addedAt)]))
            .get();
        return rows.map((r) => models.FavoriteEntry(id: r.productId, addedAt: DateTime.parse(r.addedAt))).toList();
      case models.FavoriteType.distributor:
        final rows = await (_db.select(_db.favoriteDistributors)
              ..orderBy([(t) => OrderingTerm.desc(t.addedAt)]))
            .get();
        return rows.map((r) => models.FavoriteEntry(id: r.distributorId, addedAt: DateTime.parse(r.addedAt))).toList();
      case models.FavoriteType.salesPersonnel:
        final rows = await (_db.select(_db.favoriteSalesPersonnel)
              ..orderBy([(t) => OrderingTerm.desc(t.addedAt)]))
            .get();
        return rows.map((r) => models.FavoriteEntry(id: r.salesPersonnelId, addedAt: DateTime.parse(r.addedAt))).toList();
      case models.FavoriteType.vetDoctor:
        final rows = await (_db.select(_db.favoriteVetDoctors)
              ..orderBy([(t) => OrderingTerm.desc(t.addedAt)]))
            .get();
        return rows.map((r) => models.FavoriteEntry(id: r.vetDoctorId, addedAt: DateTime.parse(r.addedAt))).toList();
    }
  }

  Future<List<int>> getFavoriteIds(models.FavoriteType type) async {
    switch (type) {
      case models.FavoriteType.product:
        final rows = await _db.select(_db.favoriteProducts).get();
        return rows.map((r) => r.productId).toList();
      case models.FavoriteType.distributor:
        final rows = await _db.select(_db.favoriteDistributors).get();
        return rows.map((r) => r.distributorId).toList();
      case models.FavoriteType.salesPersonnel:
        final rows = await _db.select(_db.favoriteSalesPersonnel).get();
        return rows.map((r) => r.salesPersonnelId).toList();
      case models.FavoriteType.vetDoctor:
        final rows = await _db.select(_db.favoriteVetDoctors).get();
        return rows.map((r) => r.vetDoctorId).toList();
    }
  }

  // ---------------- app_settings ----------------

  Future<String?> getSetting(String key) async {
    final q = _db.select(_db.appSettings)..where((t) => t.key.equals(key))..limit(1);
    final rows = await q.get();
    if (rows.isEmpty) return null;
    return rows.first.value;
  }

  Future<void> setSetting(String key, String? value) async {
    await _db.into(_db.appSettings).insert(
          AppSettingsCompanion.insert(key: key, value: Value(value)),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<List<models.AppSetting>> getAllSettings() async {
    final rows = await _db.select(_db.appSettings).get();
    return rows.map((r) => models.AppSetting(key: r.key, value: r.value)).toList();
  }

  Future<bool> getDarkMode() async => (await getSetting('dark_mode')) == 'true';
  Future<void> setDarkMode(bool enabled) =>
      setSetting('dark_mode', enabled.toString());

  Future<String> getLanguage() async => (await getSetting('language')) ?? 'en';
  Future<void> setLanguage(String code) => setSetting('language', code);

  // ---------------- db_meta ----------------

  Future<String?> getSchemaVersion() async {
    final q = _db.select(_db.dbMeta)..where((t) => t.key.equals('schema_version'))..limit(1);
    final rows = await q.get();
    return rows.isEmpty ? null : rows.first.value;
  }

  Future<DateTime?> getGeneratedAt() async {
    final q = _db.select(_db.dbMeta)..where((t) => t.key.equals('schema_version'))..limit(1);
    final rows = await q.get();
    if (rows.isEmpty || rows.first.value == null) return null;
    return DateTime.parse(rows.first.value!);
  }

  // ---------------- search_history ----------------

  Future<List<String>> getSearchHistory() async {
    final raw = await getSetting('search_history');
    if (raw == null || raw.isEmpty) return [];
    try {
      final List<dynamic> list = Uri.decodeComponent(raw).split('|||');
      return list.map((e) => e.toString()).where((e) => e.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> addSearchHistory(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final history = await getSearchHistory();
    history.removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    history.insert(0, trimmed);
    if (history.length > 15) {
      history.removeRange(15, history.length);
    }
    await setSetting('search_history', Uri.encodeComponent(history.join('|||')));
  }

  Future<void> removeSearchHistory(String query) async {
    final history = await getSearchHistory();
    history.removeWhere((item) => item.toLowerCase() == query.trim().toLowerCase());
    await setSetting('search_history', Uri.encodeComponent(history.join('|||')));
  }

  Future<void> clearSearchHistory() async {
    await setSetting('search_history', '');
  }

  // ---------------- search_telemetry ----------------

  /// Logs search execution metrics including query text, result counts, and zero-result flags.
  Future<void> logSearchEvent(String query, int resultCount, {int executionTimeMs = 0}) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return;

    final raw = await getSetting('zero_result_log');
    final logEntries = <String>[];
    if (raw != null && raw.isNotEmpty) {
      try {
        logEntries.addAll(Uri.decodeComponent(raw).split('|||'));
      } catch (_) {}
    }

    if (resultCount == 0) {
      final entry = '$trimmed::$resultCount::${DateTime.now().toIso8601String()}';
      logEntries.removeWhere((e) => e.startsWith('$trimmed::'));
      logEntries.insert(0, entry);
      if (logEntries.length > 50) {
        logEntries.removeRange(50, logEntries.length);
      }
      await setSetting('zero_result_log', Uri.encodeComponent(logEntries.join('|||')));
    }
  }

  /// Retrieves logged zero-result queries for search telemetry analytics.
  Future<List<String>> getZeroResultQueries() async {
    final raw = await getSetting('zero_result_log');
    if (raw == null || raw.isEmpty) return [];
    try {
      final entries = Uri.decodeComponent(raw).split('|||');
      return entries.map((e) => e.split('::').first).where((e) => e.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }
}
