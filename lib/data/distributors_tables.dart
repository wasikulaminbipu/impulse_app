import 'package:drift/drift.dart';

// --- Address Hierarchy (Geographic) ---

@DataClassName('DivisionEntity')
class Divisions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('DistrictEntity')
class Districts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get divisionId => integer().customConstraint(
    'NOT NULL REFERENCES divisions(id) ON DELETE CASCADE',
  )();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

@DataClassName('UpazilaEntity')
class Upazilas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get districtId => integer().customConstraint(
    'NOT NULL REFERENCES districts(id) ON DELETE CASCADE',
  )();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

// --- Company Operational Hierarchy (Bases) ---

@DataClassName('RegionEntity')
class Regions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('AreaEntity')
class Areas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get regionId => integer().customConstraint(
    'NOT NULL REFERENCES regions(id) ON DELETE CASCADE',
  )();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

@DataClassName('BaseEntity')
class Bases extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get areaId => integer().customConstraint(
    'NOT NULL REFERENCES areas(id) ON DELETE CASCADE',
  )();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

// Base coverage of one or more Upazilas
@DataClassName('BaseUpazilaEntity')
class BaseUpazilas extends Table {
  IntColumn get baseId => integer().customConstraint(
    'NOT NULL REFERENCES bases(id) ON DELETE CASCADE',
  )();
  IntColumn get upazilaId => integer().customConstraint(
    'NOT NULL REFERENCES upazilas(id) ON DELETE CASCADE',
  )();

  @override
  Set<Column> get primaryKey => {baseId, upazilaId};
}

// --- Entities ---

@DataClassName('DistributorEntity')
class Distributors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  TextColumn get designation => text().nullable()();
  TextColumn get addressEn => text().nullable()();
  TextColumn get addressBn => text().nullable()();

  // Complete Address Hierarchy link (Upazila -> District -> Division)
  IntColumn get upazilaId =>
      integer().nullable().customConstraint('REFERENCES upazilas(id)')();

  // Operational Base link (Base -> Area -> Region)
  IntColumn get baseId =>
      integer().nullable().customConstraint('REFERENCES bases(id)')();

  // Legacy areaId reference kept nullable for fallback backwards-compatibility
  IntColumn get areaId =>
      integer().nullable().customConstraint('REFERENCES areas(id)')();

  TextColumn get mobile => text()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  TextColumn get createdAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}

@DataClassName('SalesPersonnelEntity')
class SalesPersonnel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  TextColumn get designation => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get mobile => text()();
  TextColumn get email => text().nullable()();
  TextColumn get employeeId => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  TextColumn get createdAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}

// --- Sales Personnel Scope Coverage Mappings ---

class SalesPersonnelRegions extends Table {
  IntColumn get salesPersonnelId => integer().customConstraint(
    'NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE',
  )();
  IntColumn get regionId => integer().customConstraint(
    'NOT NULL REFERENCES regions(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {salesPersonnelId, regionId};
}

class SalesPersonnelAreas extends Table {
  IntColumn get salesPersonnelId => integer().customConstraint(
    'NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE',
  )();
  IntColumn get areaId => integer().customConstraint(
    'NOT NULL REFERENCES areas(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {salesPersonnelId, areaId};
}

class SalesPersonnelBases extends Table {
  IntColumn get salesPersonnelId => integer().customConstraint(
    'NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE',
  )();
  IntColumn get baseId => integer().customConstraint(
    'NOT NULL REFERENCES bases(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {salesPersonnelId, baseId};
}

class SalesPersonnelUpazilas extends Table {
  IntColumn get salesPersonnelId => integer().customConstraint(
    'NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE',
  )();
  IntColumn get upazilaId => integer().customConstraint(
    'NOT NULL REFERENCES upazilas(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {salesPersonnelId, upazilaId};
}

// --- Vet Doctors Scope ---

@DataClassName('VetDoctorEntity')
class VetDoctors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get qualification => text().nullable()();
  TextColumn get specialization => text().nullable()();
  TextColumn get bvcRegistrationNo => text().nullable()();
  TextColumn get clinicOrHospitalNameEn => text().nullable()();
  TextColumn get clinicOrHospitalNameBn => text().nullable()();
  TextColumn get addressEn => text().nullable()();
  TextColumn get addressBn => text().nullable()();
  TextColumn get mobile => text()();
  TextColumn get email => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  TextColumn get createdAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt =>
      text().clientDefault(() => DateTime.now().toIso8601String())();
}

class VetDoctorsRegions extends Table {
  IntColumn get vetDoctorId => integer().customConstraint(
    'NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE',
  )();
  IntColumn get regionId => integer().customConstraint(
    'NOT NULL REFERENCES regions(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {vetDoctorId, regionId};
}

class VetDoctorsAreas extends Table {
  IntColumn get vetDoctorId => integer().customConstraint(
    'NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE',
  )();
  IntColumn get areaId => integer().customConstraint(
    'NOT NULL REFERENCES areas(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {vetDoctorId, areaId};
}

class VetDoctorsBases extends Table {
  IntColumn get vetDoctorId => integer().customConstraint(
    'NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE',
  )();
  IntColumn get baseId => integer().customConstraint(
    'NOT NULL REFERENCES bases(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {vetDoctorId, baseId};
}

class VetDoctorsUpazilas extends Table {
  IntColumn get vetDoctorId => integer().customConstraint(
    'NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE',
  )();
  IntColumn get upazilaId => integer().customConstraint(
    'NOT NULL REFERENCES upazilas(id) ON DELETE CASCADE',
  )();
  @override
  Set<Column> get primaryKey => {vetDoctorId, upazilaId};
}
