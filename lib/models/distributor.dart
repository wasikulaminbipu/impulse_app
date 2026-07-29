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
    required int areaId, // FK to areas.id (replaces area_en/area_bn/region_en/region_bn)
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
    areaId: row['area_id'] as int,
    mobile: row['mobile'] as String?,
    isActive: (row['is_active'] as int?) == 1,
    createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_en': nameEn,
    'name_bn': nameBn,
    'designation': designation,
    'address_en': addressEn,
    'address_bn': addressBn,
    'area_id': areaId,
    'mobile': mobile,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

// ============================================================================
// SALES PERSONNEL MODEL (new)
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
    @Default([]) List<int> areaIds, // populated via sales_personnel_areas junction table
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
    createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
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
    @Default([]) List<int> areaIds, // populated via vet_doctors_areas junction table
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
    createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? '') ?? DateTime.now(),
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

/// SalesPersonnel with area/region details
@freezed
abstract class SalesPersonnelWithAreas with _$SalesPersonnelWithAreas {
  const factory SalesPersonnelWithAreas({
    required SalesPersonnel personnel,
    required List<Area> areas,
  }) = _SalesPersonnelWithAreas;
}

/// VetDoctor with area/region details
@freezed
abstract class VetDoctorWithAreas with _$VetDoctorWithAreas {
  const factory VetDoctorWithAreas({
    required VetDoctor doctor,
    required List<Area> areas,
  }) = _VetDoctorWithAreas;
}
