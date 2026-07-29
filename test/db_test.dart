import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/data/app_maintenance_dao.dart';
import 'package:impulse_dex/data/distributor_dao.dart';
import 'package:impulse_dex/data/product_dao.dart';
import 'package:impulse_dex/data/lookup_dao.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/database_provider.dart';

void main() {
  group('Database Tests', () {
    test('Test product loading and hydration', () async {
      final dbFile = File('assets/products.db');
      expect(dbFile.existsSync(), isTrue);

      final db = ProductsDb(NativeDatabase(dbFile.absolute));
      final dao = ProductDao(db.executor, LookupDao(db.executor));

      try {
        await db.customSelect('SELECT 1').getSingle();
        final products = await dao.getAllLight(activeOnly: true);
        final tgs = await LookupDao(db.executor).getTargetGroups();
        for (final tg in tgs) {
          // ignore: avoid_print
          print('TargetGroup id=${tg.id}, nameEn=${tg.nameEn}, iconName=${tg.iconName}');
        }

        final product = await dao.getById(products.first.id);
        expect(product, isNotNull);
        expect(product!.directions, isA<List>());

        for (final d in product.directions) {
          expect(d.id, isNotNull);
          expect(d.productId, equals(product.id));
        }
      } finally {
        await db.close();
      }
    });

    test('Test Products FTS search and token sanitization', () async {
      final tempDbFile = File('build/test_products.db');
      if (tempDbFile.existsSync()) tempDbFile.deleteSync();
      File('assets/products.db').copySync(tempDbFile.path);

      final db = ProductsDb(NativeDatabase(tempDbFile));
      final dao = ProductDao(db.executor, LookupDao(db.executor));

      try {
        await db.customSelect('SELECT 1').getSingle();

        // 1. Before FTS setup (FTS table not ready), search uses LIKE fallback
        final searchBeforeFts = await dao.search('aqua');
        expect(searchBeforeFts, isA<List>());

        // 2. Perform FTS setup
        await setupProductsFts(db.executor);

        // Verify db_meta flag
        final metaRows = await db.customSelect(
          "SELECT value FROM db_meta WHERE key = 'fts_ready_products_fts'",
        ).get();
        expect(metaRows.first.read<String>('value'), equals('1'));

        // Search with special characters (should not crash FTS5)
        final searchSpecial = await dao.search('test: (123)* &%');
        expect(searchSpecial, isA<List>());

        // Search for existing keyword via FTS
        final searchKeyword = await dao.search('aqua');
        expect(searchKeyword, isA<List>());
      } finally {
        await db.close();
        if (tempDbFile.existsSync()) tempDbFile.deleteSync();
      }
    });

    test('Test Distributors FTS search', () async {
      final tempDbFile = File('build/test_distributors.db');
      if (tempDbFile.existsSync()) tempDbFile.deleteSync();
      File('assets/distributors.db').copySync(tempDbFile.path);

      final db = DistributorsDb(NativeDatabase(tempDbFile));
      final distDao = DistributorDao(db.executor);
      final salesDao = SalesPersonnelDao(db.executor);
      final vetDao = VetDoctorDao(db.executor);

      try {
        await db.customSelect('SELECT 1').getSingle();

        // 1. Search before FTS setup (fallback to LIKE)
        final distResultsBefore = await distDao.searchDistributors('dhaka');
        expect(distResultsBefore, isA<List>());

        // 2. Perform Distributors FTS setup
        await setupDistributorsFts(db.executor);

        // Verify db_meta flags
        final metaRows = await db.customSelect(
          "SELECT value FROM db_meta WHERE key = 'fts_ready_distributors_fts'",
        ).get();
        expect(metaRows.first.read<String>('value'), equals('1'));

        final distResults = await distDao.searchDistributors('dhaka: (test)');
        expect(distResults, isA<List>());

        final salesResults = await salesDao.searchSalesPersonnel('rahim*');
        expect(salesResults, isA<List>());

        final vetResults = await vetDao.searchVetDoctors('doctor &%');
        expect(vetResults, isA<List>());
      } finally {
        await db.close();
        if (tempDbFile.existsSync()) tempDbFile.deleteSync();
      }
    });

    test('Test App Maintenance favorites operations', () async {
      final tempDbFile = File('build/test_app_maintenance.db');
      if (tempDbFile.existsSync()) {
        tempDbFile.deleteSync();
      }

      final db = AppMaintenanceDb(NativeDatabase(tempDbFile));
      await setupAppMaintenanceTables(db.executor);
      final dao = AppMaintenanceDao(db.executor);

      try {
        await db.customSelect('SELECT 1').getSingle();

        expect(await dao.isFavorite(FavoriteType.product, 10), isFalse);
        await dao.addFavorite(FavoriteType.product, 10);
        expect(await dao.isFavorite(FavoriteType.product, 10), isTrue);

        final favs = await dao.getFavoriteIds(FavoriteType.product);
        expect(favs, contains(10));

        await dao.toggleFavorite(FavoriteType.product, 10);
        expect(await dao.isFavorite(FavoriteType.product, 10), isFalse);
      } finally {
        await db.close();
        if (tempDbFile.existsSync()) {
          tempDbFile.deleteSync();
        }
      }
    });
  });
}
