import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/distributor_dao.dart';
import 'package:impulse_app/models/distributor.dart';

void main() {
  group('DistributorDao & Stakeholder DAOs Comprehensive Tests', () {
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

      // Seed regions, areas, bases, divisions, districts, upazilas
      await db.executor.customExecute(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (1, 'Dhaka Region', 'ঢাকা অঞ্চল');",
      );
      await db.executor.customExecute(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (2, 'Chittagong Region', 'চট্টগ্রাম অঞ্চল');",
      );
      await db.executor.customExecute(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (10, 1, 'Gazipur Area', 'গাজীপুর এলাকা');",
      );
      await db.executor.customExecute(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (20, 2, 'Comilla Area', 'কুমিল্লা এলাকা');",
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
        "INSERT INTO base_upazilas (base_id, upazila_id) VALUES (100, 1001);",
      );

      // Seed distributors
      await db.executor.customExecute('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (1, 'Al-Madina Traders', 'আল-মদিনা ট্রেডার্স', 'Proprietor', 'Mawna Chowrasta', 'মাওনা চৌরাস্তা', '01711000000', 10, 1, '2026-01-01', '2026-01-01');
      ''');
      await db.executor.customExecute('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (2, 'Bismillah Enterprise', 'বিসমিল্লাহ এন্টারপ্রাইজ', 'Dealer', 'Comilla Sadar', 'কুমিল্লা সদর', '01811000000', 20, 1, '2026-01-01', '2026-01-01');
      ''');
      await db.executor.customExecute('''
        INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile, area_id, is_active, created_at, updated_at)
        VALUES (3, 'Inactive Distributor', 'নিষ্ক্রিয় ডিলার', 'Dealer', 'Old Dhaka', 'পুরাতন ঢাকা', '01911000000', 10, 0, '2026-01-01', '2026-01-01');
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

      // Seed vet doctors
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

    group('DistributorDao', () {
      test('getAllDistributors returns only active distributors', () async {
        final list = await distributorDao.getAllDistributors();
        expect(list.length, equals(2));
        expect(list.any((d) => d.distributor.id == 3), isFalse);
      });

      test('getDistributorById finds by ID with area & region', () async {
        final found = await distributorDao.getDistributorById(1);
        expect(found, isNotNull);
        expect(found!.distributor.nameEn, equals('Al-Madina Traders'));
        expect(found.area.nameEn, equals('Gazipur Area'));
        expect(found.region.nameEn, equals('Dhaka Region'));

        final missing = await distributorDao.getDistributorById(999);
        expect(missing, isNull);
      });

      test('getDistributorsByArea and getDistributorsByRegion', () async {
        final byArea = await distributorDao.getDistributorsByArea(10);
        expect(byArea.length, equals(1));
        expect(byArea.first.distributor.id, equals(1));

        final byRegion = await distributorDao.getDistributorsByRegion(1);
        expect(byRegion.length, equals(1));
        expect(byRegion.first.distributor.id, equals(1));

        final emptyArea = await distributorDao.getDistributorsByArea(999);
        expect(emptyArea, isEmpty);
      });

      test('searchDistributors fallback and empty string handling', () async {
        expect(await distributorDao.searchDistributors(''), isEmpty);
        expect(await distributorDao.searchDistributors('   '), isEmpty);

        final searchEn = await distributorDao.searchDistributors('Al-Madina');
        expect(searchEn.length, equals(1));
        expect(searchEn.first.distributor.nameEn, equals('Al-Madina Traders'));

        final searchBn = await distributorDao.searchDistributors('বিসমিল্লাহ');
        expect(searchBn.length, equals(1));
        expect(searchBn.first.distributor.id, equals(2));

        final searchPhone = await distributorDao.searchDistributors('01711');
        expect(searchPhone.length, equals(1));
      });

      test(
        'getFilteredDistributors with pagination, query, and favorite ordering',
        () async {
          final all = await distributorDao.getFilteredDistributors();
          expect(all.length, equals(2));

          final paged = await distributorDao.getFilteredDistributors(
            limit: 1,
            offset: 0,
          );
          expect(paged.length, equals(1));

          final favFirst = await distributorDao.getFilteredDistributors(
            favoriteIds: {2},
          );
          expect(favFirst.first.distributor.id, equals(2));

          final filteredQuery = await distributorDao.getFilteredDistributors(
            query: 'Madina',
          );
          expect(filteredQuery.length, equals(1));
        },
      );

      test('upsert and deactivate distributor', () async {
        final newDist = Distributor(
          id: 4,
          areaId: 10,
          nameEn: 'New Pharma Store',
          nameBn: 'নতুন ফার্মা',
          designation: 'Retailer',
          addressEn: 'Joydebpur',
          addressBn: 'জয়দেবপুর',
          mobile: '01511000000',
          createdAt: DateTime.parse('2026-01-01'),
          updatedAt: DateTime.parse('2026-01-01'),
        );

        await distributorDao.upsert(newDist);
        final found = await distributorDao.getDistributorById(4);
        expect(found, isNotNull);
        expect(found!.distributor.nameEn, equals('New Pharma Store'));

        await distributorDao.deactivate(4);
        final deactivated = await distributorDao.getDistributorById(4);
        expect(deactivated!.distributor.isActive, isFalse);
      });
    });

    group('SalesPersonnelDao', () {
      test('getAllSalesPersonnel and getSalesPersonnelById', () async {
        final all = await salesPersonnelDao.getAllSalesPersonnel();
        expect(all.length, equals(1));
        expect(all.first.personnel.nameEn, equals('Md. Rafiqul Islam'));
        expect(all.first.areas.first.nameEn, equals('Gazipur Area'));
        expect(all.first.regions.first.nameEn, equals('Dhaka Region'));

        final byId = await salesPersonnelDao.getSalesPersonnelById(1);
        expect(byId, isNotNull);
        expect(byId!.personnel.employeeId, equals('EMP001'));

        final notFound = await salesPersonnelDao.getSalesPersonnelById(999);
        expect(notFound, isNull);
      });

      test('getAreasForSalesPersonnel and getSalesPersonnelByArea', () async {
        final areas = await salesPersonnelDao.getAreasForSalesPersonnel(1);
        expect(areas.length, equals(1));
        expect(areas.first.id, equals(10));

        final personnelInArea = await salesPersonnelDao.getSalesPersonnelByArea(
          10,
        );
        expect(personnelInArea.length, equals(1));
        expect(personnelInArea.first.personnel.id, equals(1));
      });

      test(
        'searchSalesPersonnel by name, designation, phone, or employeeId',
        () async {
          expect(await salesPersonnelDao.searchSalesPersonnel(''), isEmpty);

          final byName = await salesPersonnelDao.searchSalesPersonnel(
            'Rafiqul',
          );
          expect(byName.length, equals(1));

          final byEmpId = await salesPersonnelDao.searchSalesPersonnel(
            'EMP001',
          );
          expect(byEmpId.length, equals(1));

          final byMobile = await salesPersonnelDao.searchSalesPersonnel(
            '01712',
          );
          expect(byMobile.length, equals(1));
        },
      );

      test(
        'getFilteredSalesPersonnel with query, pagination, and favorites',
        () async {
          final results = await salesPersonnelDao.getFilteredSalesPersonnel(
            query: 'Rafiqul',
            limit: 10,
            offset: 0,
            favoriteIds: {1},
          );
          expect(results.length, equals(1));
        },
      );

      test(
        'upsert, assignArea, removeAreaAssignment, and deactivate',
        () async {
          final newPerson = SalesPersonnel(
            id: 2,
            nameEn: 'Kamal Hossain',
            nameBn: 'কামাল হোসেন',
            designation: 'Medical Representative',
            mobile: '01611000000',
            email: 'kamal@impulse.com',
            employeeId: 'EMP002',
            createdAt: DateTime.parse('2026-01-01'),
            updatedAt: DateTime.parse('2026-01-01'),
          );
          await salesPersonnelDao.upsert(newPerson);
          await salesPersonnelDao.assignArea(2, 20);

          final personAreas = await salesPersonnelDao.getAreasForSalesPersonnel(
            2,
          );
          expect(personAreas.length, equals(1));
          expect(personAreas.first.id, equals(20));

          await salesPersonnelDao.removeAreaAssignment(2, 20);
          expect(await salesPersonnelDao.getAreasForSalesPersonnel(2), isEmpty);

          await salesPersonnelDao.deactivate(2);
          final found = await salesPersonnelDao.getSalesPersonnelById(2);
          expect(found!.personnel.isActive, isFalse);
        },
      );
    });

    group('VetDoctorDao', () {
      test('getAllVetDoctors and getVetDoctorById', () async {
        final all = await vetDoctorDao.getAllVetDoctors();
        expect(all.length, equals(1));
        expect(all.first.doctor.nameEn, equals('Dr. Shamsul Alam'));

        final byId = await vetDoctorDao.getVetDoctorById(1);
        expect(byId, isNotNull);
        expect(byId!.doctor.qualification, equals('DVM, MS'));

        final notFound = await vetDoctorDao.getVetDoctorById(999);
        expect(notFound, isNull);
      });

      test('searchVetDoctors and getFilteredVetDoctors', () async {
        expect(await vetDoctorDao.searchVetDoctors(''), isEmpty);

        final byName = await vetDoctorDao.searchVetDoctors('Shamsul');
        expect(byName.length, equals(1));

        final filtered = await vetDoctorDao.getFilteredVetDoctors(
          query: 'Consultant',
          limit: 10,
          favoriteIds: {1},
        );
        expect(filtered.length, equals(1));
      });

      test(
        'upsert, assignArea, removeAreaAssignment, and deactivate',
        () async {
          final newDoctor = VetDoctor(
            id: 2,
            nameEn: 'Dr. Nasir Uddin',
            nameBn: 'ডা: নাসির উদ্দিন',
            qualification: 'BVSc, AH',
            specialization: 'Poultry Specialist',
            mobile: '01714000000',
            email: 'nasir@impulse.com',
            addressEn: 'Comilla Town',
            createdAt: DateTime.parse('2026-01-01'),
            updatedAt: DateTime.parse('2026-01-01'),
          );
          await vetDoctorDao.upsert(newDoctor);
          await vetDoctorDao.assignArea(2, 20);

          final found = await vetDoctorDao.getVetDoctorById(2);
          expect(found, isNotNull);
          expect(found!.areas.length, equals(1));

          await vetDoctorDao.removeAreaAssignment(2, 20);
          await vetDoctorDao.deactivate(2);

          final updated = await vetDoctorDao.getVetDoctorById(2);
          expect(updated!.doctor.isActive, isFalse);
        },
      );
    });

    group('LocationDao', () {
      test('getAllRegions and caching', () async {
        final regions = await locationDao.getAllRegions();
        expect(regions.length, equals(2));
        expect(
          regions.first.nameEn,
          equals('Chittagong Region'),
        ); // alphabetical

        // Cached lookup
        final cached = await locationDao.getAllRegions();
        expect(identical(regions, cached), isTrue);

        final r1 = await locationDao.getRegionById(1);
        expect(r1, isNotNull);
        expect(r1!.nameEn, equals('Dhaka Region'));

        locationDao.clearCache();
      });

      test('getAllAreas and filtering by regionId', () async {
        final areas = await locationDao.getAllAreas();
        expect(areas.length, equals(2));

        final r1Areas = await locationDao.getAllAreas(regionId: 1);
        expect(r1Areas.length, equals(1));
        expect(r1Areas.first.nameEn, equals('Gazipur Area'));

        final a10 = await locationDao.getAreaById(10);
        expect(a10, isNotNull);
        expect(a10!.nameEn, equals('Gazipur Area'));

        locationDao.clearCache();
      });

      test('getAllBases, getBaseById, and getAllBasesWithUpazilas', () async {
        final bases = await locationDao.getAllBases();
        expect(bases.length, equals(1));
        expect(bases.first.nameEn, equals('Sreepur Base'));

        final b100 = await locationDao.getBaseById(100);
        expect(b100, isNotNull);
        expect(b100!.areaId, equals(10));

        final basesWithUpazilas = await locationDao.getAllBasesWithUpazilas();
        expect(basesWithUpazilas.length, equals(1));
        expect(basesWithUpazilas.first.upazilas.length, equals(1));
        expect(
          basesWithUpazilas.first.upazilas.first.nameEn,
          equals('Sreepur Upazila'),
        );
      });

      test('getAllDivisions, getAllDistricts, and getAllUpazilas', () async {
        final divisions = await locationDao.getAllDivisions();
        expect(divisions.length, equals(1));

        final districts = await locationDao.getAllDistricts(divisionId: 1);
        expect(districts.length, equals(1));

        final upazilas = await locationDao.getAllUpazilas(districtId: 1);
        expect(upazilas.length, equals(1));
      });
    });
  });
}
