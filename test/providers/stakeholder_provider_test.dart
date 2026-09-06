import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/distributor_dao.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/providers/stakeholder_provider.dart';

void main() {
  group('Stakeholder Riverpod Providers Comprehensive Tests', () {
    late DistributorsDb db;
    late ProviderContainer container;

    setUp(() async {
      db = DistributorsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      // Seed mock location hierarchy and stakeholders
      await db.customStatement(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (1, 'Dhaka Region', 'ঢাকা');",
      );
      await db.customStatement(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (10, 1, 'Gazipur Area', 'গাজীপুর');",
      );
      await db.customStatement(
        "INSERT INTO bases (id, area_id, name_en, name_bn) VALUES (100, 10, 'Sreepur Base', 'শ্রীপুর');",
      );
      await db.customStatement(
        "INSERT INTO divisions (id, name_en, name_bn) VALUES (1, 'Dhaka Division', 'ঢাকা');",
      );
      await db.customStatement(
        "INSERT INTO districts (id, division_id, name_en, name_bn) VALUES (1, 1, 'Gazipur District', 'গাজীপুর');",
      );
      await db.customStatement(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (1001, 1, 'Sreepur Upazila', 'শ্রীপুর');",
      );
      await db.customStatement(
        "INSERT INTO base_upazilas (base_id, upazila_id) VALUES (100, 1001);",
      );

      await db.customStatement('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (1, 'Impulse Agro Feed', 'ইমপালস এগ্রো ফিড', 'Dealer', 'Mawna', 'মাওনা', '01711111111', 10, 1, '2026-01-01', '2026-01-01');
      ''');

      await db.customStatement('''
        INSERT INTO sales_personnel (id, name_en, name_bn, designation, mobile, email, employee_id, is_active, created_at, updated_at)
        VALUES (1, 'Mohammad Ali', 'মোহাম্মদ আলী', 'Territory Manager', '01712222222', 'ali@impulse.com', 'EMP101', 1, '2026-01-01', '2026-01-01');
      ''');
      await db.customStatement(
        'INSERT INTO sales_personnel_areas VALUES (1, 10);',
      );
      await db.customStatement(
        'INSERT INTO sales_personnel_regions VALUES (1, 1);',
      );
      await db.customStatement(
        'INSERT INTO sales_personnel_bases VALUES (1, 100);',
      );
      await db.customStatement(
        'INSERT INTO sales_personnel_upazilas VALUES (1, 1001);',
      );

      await db.customStatement('''
        INSERT INTO vet_doctors (id, name_en, name_bn, qualification, specialization, mobile, email, address_en, is_active, created_at, updated_at)
        VALUES (1, 'Dr. Tariqul Islam', 'ডা: তারিকুল ইসলাম', 'DVM', 'Vet Specialist', '01713333333', 'tariq@impulse.com', 'Gazipur', 1, '2026-01-01', '2026-01-01');
      ''');
      await db.customStatement('INSERT INTO vet_doctors_areas VALUES (1, 10);');
      await db.customStatement(
        'INSERT INTO vet_doctors_regions VALUES (1, 1);',
      );
      await db.customStatement(
        'INSERT INTO vet_doctors_bases VALUES (1, 100);',
      );
      await db.customStatement(
        'INSERT INTO vet_doctors_upazilas VALUES (1, 1001);',
      );

      container = ProviderContainer(
        overrides: [
          distributorsDatabaseProvider.overrideWith((ref) async => db),
          distributorFavoritesProvider.overrideWith((ref) async => [1]),
          salesPersonnelFavoritesProvider.overrideWith((ref) async => [1]),
          vetDoctorFavoritesProvider.overrideWith((ref) async => [1]),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('DAO providers resolve with correct types', () async {
      expect(
        await container.read(distributorDaoProvider.future),
        isA<DistributorDao>(),
      );
      expect(
        await container.read(salesPersonnelDaoProvider.future),
        isA<SalesPersonnelDao>(),
      );
      expect(
        await container.read(vetDoctorDaoProvider.future),
        isA<VetDoctorDao>(),
      );
      expect(
        await container.read(locationDaoProvider.future),
        isA<LocationDao>(),
      );
    });

    test('basesWithUpazilas and upazilasList providers load data', () async {
      final bases = await container.read(basesWithUpazilasProvider.future);
      expect(bases.length, equals(1));
      expect(bases.first.base.nameEn, equals('Sreepur Base'));
      expect(bases.first.upazilas.length, equals(1));

      final upazilas = await container.read(
        upazilasListProvider(districtId: 1).future,
      );
      expect(upazilas.length, equals(1));
      expect(upazilas.first.nameEn, equals('Sreepur Upazila'));
    });

    test(
      'Search query and region/area filter state notifiers update correctly',
      () {
        final distQueryNotifier = container.read(
          distributorSearchQueryProvider.notifier,
        );
        distQueryNotifier.updateQuery('Agro Feed');

        final regionNotifier = container.read(
          selectedContactRegionFilterProvider.notifier,
        );
        regionNotifier.selectRegion('Dhaka Region');
        expect(
          container.read(selectedContactRegionFilterProvider),
          equals('Dhaka Region'),
        );

        final areaNotifier = container.read(
          selectedContactAreaFilterProvider.notifier,
        );
        areaNotifier.selectArea('Gazipur Area');
        expect(
          container.read(selectedContactAreaFilterProvider),
          equals('Gazipur Area'),
        );
      },
    );

    test(
      'paginatedDistributorsProvider builds, loads items, and handles fetchNextPage',
      () async {
        final state = await container.read(
          paginatedDistributorsProvider.future,
        );
        expect(state.items.length, equals(1));
        expect(
          state.items.first.distributor.nameEn,
          equals('Impulse Agro Feed'),
        );

        // Call fetchNextPage
        await container
            .read(paginatedDistributorsProvider.notifier)
            .fetchNextPage();
        final updated = await container.read(
          paginatedDistributorsProvider.future,
        );
        expect(updated.items.length, equals(1));
      },
    );

    test(
      'paginatedSalesPersonnelProvider builds, loads items, and handles fetchNextPage',
      () async {
        final state = await container.read(
          paginatedSalesPersonnelProvider.future,
        );
        expect(state.items.length, equals(1));
        expect(state.items.first.personnel.nameEn, equals('Mohammad Ali'));

        await container
            .read(paginatedSalesPersonnelProvider.notifier)
            .fetchNextPage();
        final updated = await container.read(
          paginatedSalesPersonnelProvider.future,
        );
        expect(updated.items.length, equals(1));
      },
    );

    test(
      'paginatedVetDoctorsProvider builds, loads items, and handles fetchNextPage',
      () async {
        final state = await container.read(paginatedVetDoctorsProvider.future);
        expect(state.items.length, equals(1));
        expect(state.items.first.doctor.nameEn, equals('Dr. Tariqul Islam'));

        await container
            .read(paginatedVetDoctorsProvider.notifier)
            .fetchNextPage();
        final updated = await container.read(
          paginatedVetDoctorsProvider.future,
        );
        expect(updated.items.length, equals(1));
      },
    );
  });
}
