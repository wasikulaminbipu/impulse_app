import 'package:impulse_dex/data/app_maintenance_dao.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/database_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_maintenance_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AppMaintenanceDao> appMaintenanceDao(Ref ref) async {
  final dbWrapper = await ref.watch(appMaintenanceDatabaseProvider.future);
  return AppMaintenanceDao(dbWrapper);
}

@Riverpod(keepAlive: true)
Future<List<int>> distributorFavorites(Ref ref) async {
  final dao = await ref.watch(appMaintenanceDaoProvider.future);
  return dao.getFavoriteIds(FavoriteType.distributor);
}

@riverpod
Future<List<int>> vetDoctorFavorites(Ref ref) async {
  final dao = await ref.watch(appMaintenanceDaoProvider.future);
  return dao.getFavoriteIds(FavoriteType.vetDoctor);
}

@riverpod
Future<List<int>> salesPersonnelFavorites(Ref ref) async {
  final dao = await ref.watch(appMaintenanceDaoProvider.future);
  return dao.getFavoriteIds(FavoriteType.salesPersonnel);
}

@Riverpod(keepAlive: true)
Future<List<int>> productFavorites(Ref ref) async {
  final dao = await ref.watch(appMaintenanceDaoProvider.future);
  return dao.getFavoriteIds(FavoriteType.product);
}

@Riverpod(keepAlive: true)
class LanguageSetting extends _$LanguageSetting {
  @override
  String build() {
    _init();
    return 'en';
  }

  Future<void> _init() async {
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    state = await dao.getLanguage();
  }

  Future<void> toggle() async {
    final nextLang = state == 'en' ? 'bn' : 'en';
    state = nextLang;
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await dao.setLanguage(nextLang);
  }
}
