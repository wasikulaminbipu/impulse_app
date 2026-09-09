import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/distributor_dao.dart';

void main() {
  group('DistributorDao & Stakeholder DAOs Extended Coverage Tests', () {
    late DistributorsDb db;
    late DistributorDao distributorDao;
    late SalesPersonnelDao salesPersonnelDao;
    late VetDoctorDao vetDoctorDao;
    late LocationDao locationDao;

    setUp(() async {
      db = DistributorsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();

      distributorDao = DistributorDao(db);
      salesPersonnelDao = SalesPersonnelDao(db);
      vetDoctorDao = VetDoctorDao(db);
      locationDao = LocationDao(db);

      // Seed locations
      await db.executor.customExecute(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (1, 'Dhaka Region', 'ঢাকা অঞ্চল');",
      );
      await db.executor.customExecute(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (10, 1, 'Gazipur Area', 'গাজীপুর এলাকা');",
      );
      await db.executor.customExecute(
        "INSERT INTO bases (id, area_id, name_en, name_bn) VALUES (100, 10, 'Sreepur Base', 'শ্রীপুর বেস');",
      );
      await db.executor.customExecute(
        "INSERT INTO divisions (id, name_en, name_bn) VALUES (1, 'Dhaka Division', 'ঢাকা বিভাগ');",
      );
      await db.executor.customExecute(
        "INSERT INTO districts (id, division_id, name_en, name_bn) VALUES (1, 1, 'Gazipur District', 'গাজীপুর জেলা');",
      );
      await db.executor.customExecute(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (1001, 1, 'Sreepur Upazila', 'শ্রীপুর উপজেলা');",
      );
      await db.executor.customExecute(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (1002, 1, 'Kapasia Upazila', 'কাপাসিয়া উপজেলা');",
      );
      await db.executor.customExecute(
        "INSERT INTO base_upazilas (base_id, upazila_id) VALUES (100, 1001);",
      );

      // Seed distributors
      await db.executor.customExecute('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (1, 'Al-Madina Traders', 'আল-মদিনা ট্রেডার্স', 'Proprietor', 'Mawna Chowrasta', 'মাওনা চৌরাস্তা', '01711000000', 10, 1, '2026-01-01', '2026-01-01');
      ''');

      // Seed sales personnel
      await db.executor.customExecute('''
        INSERT INTO sales_personnel (id, name_en, name_bn, designation, mobile, email, employee_id, is_active, created_at, updated_at)
        VALUES (1, 'Md. Rafiqul Islam', 'মো: রফিকুল ইসলাম', 'Territory Officer', '01712000000', 'rafiq@impulse.com', 'EMP001', 1, '2026-01-01', '2026-01-01');
      ''');
      await db.executor.customExecute(
        'INSERT INTO sales_personnel_areas (sales_personnel_id, area_id) VALUES (1, 10);',
      );
      await db.executor.customExecute(
        'INSERT INTO sales_personnel_regions (sales_personnel_id, region_id) VALUES (1, 1);',
      );
      await db.executor.customExecute(
        'INSERT INTO sales_personnel_bases (sales_personnel_id, base_id) VALUES (1, 100);',
      );
      await db.executor.customExecute(
        'INSERT INTO sales_personnel_upazilas (sales_personnel_id, upazila_id) VALUES (1, 1001);',
      );

      // Seed vet doctor
      await db.executor.customExecute('''
        INSERT INTO vet_doctors (id, name_en, name_bn, qualification, specialization, mobile, email, address_en, is_active, created_at, updated_at)
        VALUES (1, 'Dr. Shamsul Alam', 'ডা: শামসুল আলম', 'DVM, MS', 'Veterinary Consultant', '01713000000', 'shamsul@impulse.com', 'Gazipur Sadar', 1, '2026-01-01', '2026-01-01');
      ''');
      await db.executor.customExecute(
        'INSERT INTO vet_doctors_areas (vet_doctor_id, area_id) VALUES (1, 10);',
      );
      await db.executor.customExecute(
        'INSERT INTO vet_doctors_regions (vet_doctor_id, region_id) VALUES (1, 1);',
      );
      await db.executor.customExecute(
        'INSERT INTO vet_doctors_bases (vet_doctor_id, base_id) VALUES (1, 100);',
      );
      await db.executor.customExecute(
        'INSERT INTO vet_doctors_upazilas (vet_doctor_id, upazila_id) VALUES (1, 1001);',
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('DistributorDao returns active distributors correctly', () async {
      final all = await distributorDao.getAllDistributors();
      expect(all.length, equals(1));
      expect(all.first.distributor.nameEn, equals('Al-Madina Traders'));
    });

    test('SalesPersonnelDao fuzzy search fallback activates when query has no exact match', () async {
      // "Rafiq" or "Rafiql" triggers similarity >= 0.55 on "Rafiqul"
      final fuzzyResults = await salesPersonnelDao.getFilteredSalesPersonnel(
        query: 'Rafiql',
      );
      expect(fuzzyResults, isNotEmpty);
      expect(fuzzyResults.first.personnel.nameEn, equals('Md. Rafiqul Islam'));
    });

    test('VetDoctorDao fuzzy search fallback activates when query has no exact match', () async {
      // "Shamsl" triggers similarity >= 0.55 on "Shamsul"
      final fuzzyResults = await vetDoctorDao.getFilteredVetDoctors(
        query: 'Shamsl',
      );
      expect(fuzzyResults, isNotEmpty);
      expect(fuzzyResults.first.doctor.nameEn, equals('Dr. Shamsul Alam'));
    });

    test(
      'VetDoctorDao area & junction methods return related entities',
      () async {
        final areas = await vetDoctorDao.getAreasForVetDoctor(1);
        expect(areas.length, equals(1));
        expect(areas.first.nameEn, equals('Gazipur Area'));

        final doctorsInArea = await vetDoctorDao.getVetDoctorsByArea(10);
        expect(doctorsInArea.length, equals(1));
        expect(doctorsInArea.first.doctor.id, equals(1));

        final doctorsInMissingArea = await vetDoctorDao.getVetDoctorsByArea(
          999,
        );
        expect(doctorsInMissingArea, isEmpty);
      },
    );

    test('LocationDao single entity lookups and base management', () async {
      final area = await locationDao.getAreaById(10);
      expect(area, isNotNull);
      expect(area!.nameEn, equals('Gazipur Area'));

      final missingArea = await locationDao.getAreaById(999);
      expect(missingArea, isNull);

      final region = await locationDao.getRegionById(1);
      expect(region, isNotNull);
      expect(region!.nameEn, equals('Dhaka Region'));

      final missingRegion = await locationDao.getRegionById(999);
      expect(missingRegion, isNull);

      final basesByArea = await locationDao.getAllBases(areaId: 10);
      expect(basesByArea.length, equals(1));

      final base = await locationDao.getBaseById(100);
      expect(base, isNotNull);
      expect(base!.nameEn, equals('Sreepur Base'));

      final missingBase = await locationDao.getBaseById(999);
      expect(missingBase, isNull);

      final upazilas = await locationDao.getUpazilasForBase(100);
      expect(upazilas.length, equals(1));
      expect(upazilas.first.nameEn, equals('Sreepur Upazila'));

      // Upazila assignment and removal
      await locationDao.assignUpazilaToBase(100, 1002);
      final updatedUpazilas = await locationDao.getUpazilasForBase(100);
      expect(updatedUpazilas.length, equals(2));

      await locationDao.removeUpazilaFromBase(100, 1002);
      final revertedUpazilas = await locationDao.getUpazilasForBase(100);
      expect(revertedUpazilas.length, equals(1));

      // Delete base
      await locationDao.deleteBase(100);
      expect(await locationDao.getBaseById(100), isNull);
    });
  });
}
