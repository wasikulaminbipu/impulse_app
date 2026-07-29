import 'package:drift/drift.dart';

@DataClassName('RegionEntity')
class Regions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('AreaEntity')
class Areas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get regionId => integer().customConstraint('NOT NULL REFERENCES regions(id)')();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

@DataClassName('DistributorEntity')
class Distributors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
  TextColumn get designation => text().nullable()();
  TextColumn get addressEn => text().nullable()();
  TextColumn get addressBn => text().nullable()();
  IntColumn get areaId => integer().customConstraint('NOT NULL REFERENCES areas(id)')();
  TextColumn get mobile => text()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  TextColumn get createdAt => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt => text().clientDefault(() => DateTime.now().toIso8601String())();
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
  TextColumn get createdAt => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt => text().clientDefault(() => DateTime.now().toIso8601String())();
}

class SalesPersonnelAreas extends Table {
  IntColumn get salesPersonnelId => integer().customConstraint('NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE')();
  IntColumn get areaId => integer().customConstraint('NOT NULL REFERENCES areas(id)')();
  @override
  Set<Column> get primaryKey => {salesPersonnelId, areaId};
}

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
  TextColumn get createdAt => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt => text().clientDefault(() => DateTime.now().toIso8601String())();
}

class VetDoctorsAreas extends Table {
  IntColumn get vetDoctorId => integer().customConstraint('NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE')();
  IntColumn get areaId => integer().customConstraint('NOT NULL REFERENCES areas(id)')();
  @override
  Set<Column> get primaryKey => {vetDoctorId, areaId};
}
