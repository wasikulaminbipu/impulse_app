import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/distributor.dart';

void main() {
  group('Lookup Models (Region, Area, Division, District, Upazila, Base)', () {
    test('Region serialization and map conversion', () {
      final map = {'id': 1, 'name_en': 'Dhaka Region', 'name_bn': 'ঢাকা অঞ্চল'};
      final region = Region.fromRow(map);

      expect(region.id, equals(1));
      expect(region.nameEn, equals('Dhaka Region'));
      expect(region.nameBn, equals('ঢাকা অঞ্চল'));
      expect(region.toMap(), equals(map));
    });

    test('Area serialization and map conversion', () {
      final map = {
        'id': 10,
        'region_id': 1,
        'name_en': 'Mirpur Area',
        'name_bn': 'মিরপুর এরিয়া',
      };
      final area = Area.fromRow(map);

      expect(area.id, equals(10));
      expect(area.regionId, equals(1));
      expect(area.nameEn, equals('Mirpur Area'));
      expect(area.toMap(), equals(map));
    });

    test('Division, District, Upazila, Base serialization', () {
      final divMap = {'id': 2, 'name_en': 'Chittagong', 'name_bn': 'চট্টগ্রাম'};
      final division = Division.fromRow(divMap);
      expect(division.toMap(), equals(divMap));

      final distMap = {
        'id': 20,
        'division_id': 2,
        'name_en': 'Coxs Bazar',
        'name_bn': null,
      };
      final district = District.fromRow(distMap);
      expect(district.toMap(), equals(distMap));

      final upaMap = {
        'id': 200,
        'district_id': 20,
        'name_en': 'Teknaf',
        'name_bn': 'টেকনাফ',
      };
      final upazila = Upazila.fromRow(upaMap);
      expect(upazila.toMap(), equals(upaMap));

      final baseMap = {
        'id': 500,
        'area_id': 10,
        'name_en': 'Central Base',
        'name_bn': null,
      };
      final base = Base.fromRow(baseMap);
      expect(base.toMap(), equals(baseMap));
    });
  });

  group('Distributor Model Tests', () {
    test('Distributor.fromRow and toMap convert active state and null fields accurately', () {
      final now = DateTime.now();
      final map = {
        'id': 1,
        'name_en': 'Agro Trade',
        'name_bn': 'এগ্রো ট্রেড',
        'designation': 'Proprietor',
        'address_en': 'Dhaka Road',
        'address_bn': null,
        'upazila_id': 100,
        'base_id': 50,
        'area_id': 10,
        'mobile': '01700000000',
        'is_active': 1,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final dist = Distributor.fromRow(map);
      expect(dist.id, equals(1));
      expect(dist.nameEn, equals('Agro Trade'));
      expect(dist.isActive, isTrue);
      expect(dist.toMap()['is_active'], equals(1));
    });
  });

  group('SalesPersonnel Model Tests', () {
    test('SalesPersonnel serialization and defaults', () {
      final now = DateTime.now();
      final map = {
        'id': 101,
        'name_en': 'Rahim Khan',
        'name_bn': null,
        'designation': 'Territory Manager',
        'photo_url': 'http://example.com/photo.jpg',
        'mobile': '01800000000',
        'email': 'rahim@example.com',
        'employee_id': 'EMP001',
        'is_active': 1,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final person = SalesPersonnel.fromRow(map);
      expect(person.id, equals(101));
      expect(person.employeeId, equals('EMP001'));
      expect(person.isActive, isTrue);
      expect(person.toMap()['employee_id'], equals('EMP001'));
    });
  });

  group('VetDoctor Model Tests', () {
    test('VetDoctor serialization and fields check', () {
      final now = DateTime.now();
      final map = {
        'id': 301,
        'name_en': 'Dr. Karim',
        'name_bn': 'ডঃ করিম',
        'photo_url': null,
        'qualification': 'DVM',
        'specialization': 'Poultry',
        'bvc_registration_no': 'BVC1234',
        'clinic_or_hospital_name_en': 'Vet Care',
        'clinic_or_hospital_name_bn': null,
        'address_en': 'City Center',
        'address_bn': null,
        'mobile': '01900000000',
        'email': 'karim@vet.com',
        'is_active': 1,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final doctor = VetDoctor.fromRow(map);
      expect(doctor.id, equals(301));
      expect(doctor.qualification, equals('DVM'));
      expect(doctor.bvcRegistrationNo, equals('BVC1234'));
      expect(doctor.toMap()['bvc_registration_no'], equals('BVC1234'));
    });
  });

  group('Extended Location Join Models Tests', () {
    test('DistributorWithLocation getters return nested values correctly', () {
      final dist = Distributor(
        id: 1,
        nameEn: 'Distributor A',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final area = const Area(id: 10, regionId: 1, nameEn: 'Gulshan', nameBn: 'গুলশান');
      final region = const Region(id: 1, nameEn: 'Dhaka', nameBn: 'ঢাকা');

      final dwl = DistributorWithLocation(distributor: dist, area: area, region: region);

      expect(dwl.areaNameEn, equals('Gulshan'));
      expect(dwl.areaNameBn, equals('গুলশান'));
      expect(dwl.regionNameEn, equals('Dhaka'));
      expect(dwl.regionNameBn, equals('ঢাকা'));
    });
  });
}
