import 'package:drift/drift.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/data/db_extensions.dart';

class ManufacturerDao {
  final QueryExecutor db;
  ManufacturerDao(this.db);

  Future<Manufacturer?> getById(int id) async {
    final rows = await db.query(
      'manufacturers',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Manufacturer.fromRow(rows.first);
  }

  Future<List<Manufacturer>> getAll() async {
    final rows = await db.query('manufacturers', orderBy: 'name_en');
    return rows.map(Manufacturer.fromRow).toList();
  }

  Future<List<Manufacturer>> getFilteredManufacturers({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final where = query.isEmpty ? null : 'name_en LIKE ? OR name_bn LIKE ?';
    final args = query.isEmpty ? null : ['%$query%', '%$query%'];

    final rows = await db.query(
      'manufacturers',
      where: where,
      whereArgs: args,
      orderBy: 'name_en',
      limit: limit,
      offset: offset,
    );
    return rows.map(Manufacturer.fromRow).toList();
  }
}
