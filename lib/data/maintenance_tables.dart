import 'package:drift/drift.dart';

class FavoriteProducts extends Table {
  IntColumn get productId => integer()();
  TextColumn get addedAt => text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {productId};
}

class FavoriteDistributors extends Table {
  IntColumn get distributorId => integer()();
  TextColumn get addedAt => text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {distributorId};
}

class FavoriteSalesPersonnel extends Table {
  IntColumn get salesPersonnelId => integer()();
  TextColumn get addedAt => text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {salesPersonnelId};
}

class FavoriteVetDoctors extends Table {
  IntColumn get vetDoctorId => integer()();
  TextColumn get addedAt => text().clientDefault(() => DateTime.now().toIso8601String())();

  @override
  Set<Column> get primaryKey => {vetDoctorId};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

class DbMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
