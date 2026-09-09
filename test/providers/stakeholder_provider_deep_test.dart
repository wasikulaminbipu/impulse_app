import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/providers/stakeholder_provider.dart';

void main() {
  group('StakeholderProvider Deep Coverage Tests', () {
    late DistributorsDb distDb;
    late AppMaintenanceDb maintDb;
    late ProviderContainer container;

    setUp(() async {
      distDb = DistributorsDb(NativeDatabase.memory());
      maintDb = AppMaintenanceDb(NativeDatabase.memory());
      await distDb.createMigrator().createAll();
      await maintDb.createMigrator().createAll();

      // Seed locations
      await distDb.executor.customExecute(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (1, 'Dhaka Region', 'ঢাকা অঞ্চল');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (10, 1, 'Gazipur Area', 'গাজীপুর এলাকা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO bases (id, area_id, name_en, name_bn) VALUES (100, 10, 'Sreepur Base', 'শ্রীপুর বেস');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO divisions (id, name_en, name_bn) VALUES (1, 'Dhaka Division', 'ঢাকা বিভাগ');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO districts (id, division_id, name_en, name_bn) VALUES (1, 1, 'Gazipur District', 'গাজীপুর জেলা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (1001, 1, 'Sreepur Upazila', 'শ্রীপুর উপজেলা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO base_upazilas (base_id, upazila_id) VALUES (100, 1001);",
      );

      // Seed distributor
      await distDb.executor.customExecute('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (1, 'Al-Madina Traders', 'আল-মদিনা ট্রেডার্স', 'Proprietor', 'Mawna Chowrasta', 'মাওনা চৌরাস্তা', '01711000000', 10, 1, '2026-01-01', '2026-01-01');
      ''');

      // Seed sales personnel
      await distDb.executor.customExecute('''
        INSERT INTO sales_personnel (id, name_en, name_bn, designation, mobile, email, employee_id, is_active, created_at, updated_at)
        VALUES (1, 'Md. Rafiqul Islam', 'মো: রফিকুল ইসলাম', 'Territory Officer', '01712000000', 'rafiq@impulse.com', 'EMP001', 1, '2026-01-01', '2026-01-01');
      ''');
      await distDb.executor.customExecute(
        'INSERT INTO sales_personnel_areas (sales_personnel_id, area_id) VALUES (1, 10);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO sales_personnel_regions (sales_personnel_id, region_id) VALUES (1, 1);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO sales_personnel_bases (sales_personnel_id, base_id) VALUES (1, 100);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO sales_personnel_upazilas (sales_personnel_id, upazila_id) VALUES (1, 1001);',
      );

      // Seed vet doctor
      await distDb.executor.customExecute('''
        INSERT INTO vet_doctors (id, name_en, name_bn, qualification, specialization, mobile, email, address_en, is_active, created_at, updated_at)
        VALUES (1, 'Dr. Shamsul Alam', 'ডা: শামসুল আলম', 'DVM, MS', 'Veterinary Consultant', '01713000000', 'shamsul@impulse.com', 'Gazipur Sadar', 1, '2026-01-01', '2026-01-01');
      ''');
      await distDb.executor.customExecute(
        'INSERT INTO vet_doctors_areas (vet_doctor_id, area_id) VALUES (1, 10);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO vet_doctors_regions (vet_doctor_id, region_id) VALUES (1, 1);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO vet_doctors_bases (vet_doctor_id, base_id) VALUES (1, 100);',
      );
      await distDb.executor.customExecute(
        'INSERT INTO vet_doctors_upazilas (vet_doctor_id, upazila_id) VALUES (1, 1001);',
      );

      container = ProviderContainer(
        overrides: [
          distributorsDatabaseProvider.overrideWith((ref) async => distDb),
          appMaintenanceDatabaseProvider.overrideWith((ref) async => maintDb),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await distDb.close();
      await maintDb.close();
    });

    test('SelectedContactRegionFilter and AreaFilter update correctly', () {
      final regionNotifier = container.read(
        selectedContactRegionFilterProvider.notifier,
      );
      expect(container.read(selectedContactRegionFilterProvider), isNull);
      regionNotifier.selectRegion('Dhaka Region');
      expect(
        container.read(selectedContactRegionFilterProvider),
        equals('Dhaka Region'),
      );

      final areaNotifier = container.read(
        selectedContactAreaFilterProvider.notifier,
      );
      expect(container.read(selectedContactAreaFilterProvider), isNull);
      areaNotifier.selectArea('Gazipur Area');
      expect(
        container.read(selectedContactAreaFilterProvider),
        equals('Gazipur Area'),
      );
    });

    test('PaginatedDistributors loads and handles fetchNextPage', () async {
      final state = await container.read(paginatedDistributorsProvider.future);
      expect(state.items.length, equals(1));
      expect(state.items.first.distributor.nameEn, equals('Al-Madina Traders'));

      final notifier = container.read(paginatedDistributorsProvider.notifier);
      await notifier.fetchNextPage();
      expect(notifier.state.value?.items.length, equals(1));
    });

    test(
      'PaginatedSalesPersonnel loads, filters, and handles fetchNextPage',
      () async {
        final state = await container.read(
          paginatedSalesPersonnelProvider.future,
        );
        expect(state.items.length, equals(1));
        expect(state.items.first.personnel.nameEn, equals('Md. Rafiqul Islam'));

        final notifier = container.read(
          paginatedSalesPersonnelProvider.notifier,
        );
        await notifier.fetchNextPage();
        expect(notifier.state.value?.items.length, equals(1));
      },
    );

    test(
      'PaginatedVetDoctors loads, filters, and handles fetchNextPage',
      () async {
        final state = await container.read(paginatedVetDoctorsProvider.future);
        expect(state.items.length, equals(1));
        expect(state.items.first.doctor.nameEn, equals('Dr. Shamsul Alam'));

        final notifier = container.read(paginatedVetDoctorsProvider.notifier);
        await notifier.fetchNextPage();
        expect(notifier.state.value?.items.length, equals(1));
      },
    );

    test(
      'basesWithUpazilas and upazilasList providers resolve successfully',
      () async {
        final bases = await container.read(basesWithUpazilasProvider.future);
        expect(bases.length, equals(1));
        expect(bases.first.base.nameEn, equals('Sreepur Base'));

        final upazilas = await container.read(upazilasListProvider().future);
        expect(upazilas.length, equals(1));
        expect(upazilas.first.nameEn, equals('Sreepur Upazila'));
      },
    );

    test(
      'stakeholder search trie providers return suggestions on query',
      () async {
        container
            .read(salesPersonnelSearchQueryProvider.notifier)
            .updateQuery('Rafiq');
        final salesSuggestions = await container.read(
          salesPersonnelSearchTrieSuggestionsProvider.future,
        );
        expect(salesSuggestions, isA<List<String>>());

        container
            .read(vetDoctorsSearchQueryProvider.notifier)
            .updateQuery('Shamsul');
        final vetSuggestions = await container.read(
          vetDoctorSearchTrieSuggestionsProvider.future,
        );
        expect(vetSuggestions, isA<List<String>>());
      },
    );
  });
}
