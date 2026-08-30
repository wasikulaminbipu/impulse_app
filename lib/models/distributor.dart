import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'distributor.freezed.dart';

// ============================================================================
// LOOKUP MODELS (shared across all three entities)
// ============================================================================

@freezed
abstract class Region with _$Region {
  const factory Region({
    required int id,
    required String nameEn,
    String? nameBn,
  }) = _Region;

  const Region._();

  factory Region.fromRow(Map<String, dynamic> row) => Region(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

@freezed
abstract class Area with _$Area {
  const factory Area({
    required int id,
    required int regionId,
    required String nameEn,
    String? nameBn,
  }) = _Area;

  const Area._();

  factory Area.fromRow(Map<String, dynamic> row) => Area(
    id: row['id'] as int,
    regionId: row['region_id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'region_id': regionId,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

@freezed
abstract class Division with _$Division {
  const factory Division({
    required int id,
    required String nameEn,
    String? nameBn,
  }) = _Division;

  const Division._();

  factory Division.fromRow(Map<String, dynamic> row) => Division(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

@freezed
abstract class District with _$District {
  const factory District({
    required int id,
    required int divisionId,
    required String nameEn,
    String? nameBn,
  }) = _District;

  const District._();

  factory District.fromRow(Map<String, dynamic> row) => District(
    id: row['id'] as int,
    divisionId: row['division_id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'division_id': divisionId,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

@freezed
abstract class Upazila with _$Upazila {
  const factory Upazila({
    required int id,
    required int districtId,
    required String nameEn,
    String? nameBn,
  }) = _Upazila;

  const Upazila._();

  factory Upazila.fromRow(Map<String, dynamic> row) => Upazila(
    id: row['id'] as int,
    districtId: row['district_id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'district_id': districtId,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

@freezed
abstract class Base with _$Base {
  const factory Base({
    required int id,
    required int areaId,
    required String nameEn,
    String? nameBn,
    @Default([]) List<int> upazilaIds,
  }) = _Base;

  const Base._();

  factory Base.fromRow(Map<String, dynamic> row) => Base(
    id: row['id'] as int,
    areaId: row['area_id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'area_id': areaId,
    'name_en': nameEn,
    'name_bn': nameBn,
  };
}

// ============================================================================
// DISTRIBUTOR MODEL (updated)
// ============================================================================

@freezed
abstract class Distributor with _$Distributor {
  const factory Distributor({
    required int id,
    required String nameEn,
    String? nameBn,
    String? designation,
    String? addressEn,
    String? addressBn,
    int? upazilaId, // Complete address hierarchy link
    int? baseId, // Operational base link
    int? areaId, // Fallback area link
    String? mobile,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Distributor;

  const Distributor._();

  factory Distributor.fromRow(Map<String, dynamic> row) => Distributor(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    designation: row['designation'] as String?,
    addressEn: row['address_en'] as String?,
    addressBn: row['address_bn'] as String?,
    upazilaId: row['upazila_id'] as int?,
    baseId: row['base_id'] as int?,
    areaId: row['area_id'] as int?,
    mobile: row['mobile'] as String?,
    isActive: (row['is_active'] as int?) == 1,
    createdAt:
        DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt:
        DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
    'designation': designation,
    'address_en': addressEn,
    'address_bn': addressBn,
    'upazila_id': upazilaId,
    'base_id': baseId,
    'area_id': areaId,
    'mobile': mobile,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

// ============================================================================
// SALES PERSONNEL MODEL (updated)
// ============================================================================

@freezed
abstract class SalesPersonnel with _$SalesPersonnel {
  const factory SalesPersonnel({
    required int id,
    required String nameEn,
    String? nameBn,
    String? designation,
    String? photoUrl,
    String? mobile,
    String? email,
    String? employeeId,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<int> regionIds, // sales_personnel_regions
    @Default([]) List<int> areaIds, // sales_personnel_areas
    @Default([]) List<int> baseIds, // sales_personnel_bases
    @Default([]) List<int> upazilaIds, // sales_personnel_upazilas
  }) = _SalesPersonnel;

  const SalesPersonnel._();

  factory SalesPersonnel.fromRow(Map<String, dynamic> row) => SalesPersonnel(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    designation: row['designation'] as String?,
    photoUrl: row['photo_url'] as String?,
    mobile: row['mobile'] as String?,
    email: row['email'] as String?,
    employeeId: row['employee_id'] as String?,
    isActive: (row['is_active'] as int?) == 1,
    createdAt:
        DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt:
        DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
    'designation': designation,
    'photo_url': photoUrl,
    'mobile': mobile,
    'email': email,
    'employee_id': employeeId,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

// ============================================================================
// VET DOCTOR MODEL (new)
// ============================================================================

@freezed
abstract class VetDoctor with _$VetDoctor {
  const factory VetDoctor({
    required int id,
    required String nameEn,
    String? nameBn,
    String? photoUrl,
    String? qualification,
    String? specialization,
    String? bvcRegistrationNo,
    String? clinicOrHospitalNameEn,
    String? clinicOrHospitalNameBn,
    String? addressEn,
    String? addressBn,
    String? mobile,
    String? email,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<int> regionIds, // vet_doctors_regions
    @Default([]) List<int> areaIds, // vet_doctors_areas
    @Default([]) List<int> baseIds, // vet_doctors_bases
    @Default([]) List<int> upazilaIds, // vet_doctors_upazilas
  }) = _VetDoctor;

  const VetDoctor._();

  factory VetDoctor.fromRow(Map<String, dynamic> row) => VetDoctor(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    photoUrl: row['photo_url'] as String?,
    qualification: row['qualification'] as String?,
    specialization: row['specialization'] as String?,
    bvcRegistrationNo: row['bvc_registration_no'] as String?,
    clinicOrHospitalNameEn: row['clinic_or_hospital_name_en'] as String?,
    clinicOrHospitalNameBn: row['clinic_or_hospital_name_bn'] as String?,
    addressEn: row['address_en'] as String?,
    addressBn: row['address_bn'] as String?,
    mobile: row['mobile'] as String?,
    email: row['email'] as String?,
    isActive: (row['is_active'] as int?) == 1,
    createdAt:
        DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt:
        DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
    'photo_url': photoUrl,
    'qualification': qualification,
    'specialization': specialization,
    'bvc_registration_no': bvcRegistrationNo,
    'clinic_or_hospital_name_en': clinicOrHospitalNameEn,
    'clinic_or_hospital_name_bn': clinicOrHospitalNameBn,
    'address_en': addressEn,
    'address_bn': addressBn,
    'mobile': mobile,
    'email': email,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

// ============================================================================
// EXTENDED MODELS (for read operations with joins)
// ============================================================================

/// Distributor with area and region details (for display)
@freezed
abstract class DistributorWithLocation with _$DistributorWithLocation {
  const factory DistributorWithLocation({
    required Distributor distributor,
    required Area area,
    required Region region,
  }) = _DistributorWithLocation;

  const DistributorWithLocation._();

  /// Convenience getters for display
  String get areaNameEn => area.nameEn;
  String? get areaNameBn => area.nameBn;
  String get regionNameEn => region.nameEn;
  String? get regionNameBn => region.nameBn;
}

/// SalesPersonnel with full scope details (regions, areas, bases, upazilas)
@freezed
abstract class SalesPersonnelWithAreas with _$SalesPersonnelWithAreas {
  const factory SalesPersonnelWithAreas({
    required SalesPersonnel personnel,
    required List<Area> areas,
    @Default([]) List<Region> regions,
    @Default([]) List<Base> bases,
    @Default([]) List<Upazila> upazilas,
  }) = _SalesPersonnelWithAreas;
}

/// VetDoctor with full scope details (regions, areas, bases, upazilas)
@freezed
abstract class VetDoctorWithAreas with _$VetDoctorWithAreas {
  const factory VetDoctorWithAreas({
    required VetDoctor doctor,
    required List<Area> areas,
    @Default([]) List<Region> regions,
    @Default([]) List<Base> bases,
    @Default([]) List<Upazila> upazilas,
  }) = _VetDoctorWithAreas;
}

/// Base with area, region, and covered upazilas details
@freezed
abstract class BaseWithUpazilas with _$BaseWithUpazilas {
  const factory BaseWithUpazilas({
    required Base base,
    required Area area,
    required Region region,
    required List<Upazila> upazilas,
  }) = _BaseWithUpazilas;
}
