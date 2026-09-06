import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/database_provider.dart';

void main() {
  group('AppMaintenance Providers Tests', () {
    late AppMaintenanceDb db;
    late ProviderContainer container;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('appMaintenanceDaoProvider resolves successfully', () async {
      final dao = await container.read(appMaintenanceDaoProvider.future);
      expect(dao, isA<AppMaintenanceDao>());
    });

    test('Favorites providers load and reflect added favorites', () async {
      final dao = await container.read(appMaintenanceDaoProvider.future);
      await dao.addFavorite(FavoriteType.product, 1);
      await dao.addFavorite(FavoriteType.distributor, 2);
      await dao.addFavorite(FavoriteType.salesPersonnel, 3);
      await dao.addFavorite(FavoriteType.vetDoctor, 4);

      container.invalidate(productFavoritesProvider);
      container.invalidate(distributorFavoritesProvider);
      container.invalidate(salesPersonnelFavoritesProvider);
      container.invalidate(vetDoctorFavoritesProvider);

      final productFavs = await container.read(productFavoritesProvider.future);
      expect(productFavs, contains(1));

      final distFavs = await container.read(
        distributorFavoritesProvider.future,
      );
      expect(distFavs, contains(2));

      final spFavs = await container.read(
        salesPersonnelFavoritesProvider.future,
      );
      expect(spFavs, contains(3));

      final vdFavs = await container.read(vetDoctorFavoritesProvider.future);
      expect(vdFavs, contains(4));
    });

    test(
      'LanguageSetting initializes and toggles language with persistence',
      () async {
        // Trigger build and allow _init to complete
        expect(container.read(languageSettingProvider), equals('en'));
        await Future<void>.delayed(const Duration(milliseconds: 100));
        expect(container.read(languageSettingProvider), equals('en'));

        await container.read(languageSettingProvider.notifier).toggle();
        expect(container.read(languageSettingProvider), equals('bn'));

        final dao = await container.read(appMaintenanceDaoProvider.future);
        expect(await dao.getLanguage(), equals('bn'));

        await container.read(languageSettingProvider.notifier).toggle();
        expect(container.read(languageSettingProvider), equals('en'));
        expect(await dao.getLanguage(), equals('en'));
      },
    );
  });
}
