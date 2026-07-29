import 'package:drift/drift.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/providers/database_provider.dart';

class ManufacturerDao {
  final ProductsDb db;
  ManufacturerDao(this.db);

  Manufacturer _map(ManufacturerEntity e) => Manufacturer(
    id: e.id,
    nameEn: e.nameEn,
    nameBn: e.nameBn,
    logoUrl: e.logoUrl,
    addressEn: e.addressEn,
    addressBn: e.addressBn,
    email: e.email,
    website: e.website,
    mobile: e.mobile,
    countryOfOriginEn: e.countryOfOriginEn,
    countryOfOriginBn: e.countryOfOriginBn,
  );

  Future<Manufacturer?> getById(int id) async {
    final e = await (db.select(db.manufacturers)..where((t) => t.id.equals(id))).getSingleOrNull();
    return e == null ? null : _map(e);
  }

  Future<List<Manufacturer>> getAll() async {
    final rows = await (db.select(db.manufacturers)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return rows.map(_map).toList();
  }

  Future<List<Manufacturer>> getFilteredManufacturers({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final statement = db.select(db.manufacturers);
    if (query.isNotEmpty) {
      final pattern = '%$query%';
      statement.where((t) => t.nameEn.like(pattern) | t.nameBn.like(pattern));
    }
    statement.orderBy([(t) => OrderingTerm(expression: t.nameEn)]);
    statement.limit(limit, offset: offset);
    
    final rows = await statement.get();
    return rows.map(_map).toList();
  }
}
