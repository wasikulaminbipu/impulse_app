import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';

part 'search_history_provider.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  @override
  Future<List<String>> build() async {
    final dao = await ref.watch(appMaintenanceDaoProvider.future);
    return dao.getSearchHistory();
  }

  Future<void> addQuery(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await dao.addSearchHistory(trimmed);
    ref.invalidateSelf();
  }

  Future<void> removeQuery(String query) async {
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await dao.removeSearchHistory(query);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await dao.clearSearchHistory();
    ref.invalidateSelf();
  }
}
