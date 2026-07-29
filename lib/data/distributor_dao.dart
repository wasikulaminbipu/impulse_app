import 'package:impulse_dex/data/db_extensions.dart';
import 'package:drift/drift.dart';
import 'package:impulse_dex/models/distributor.dart';
import 'package:impulse_dex/data/fts_utils.dart';

// ============================================================================
// DISTRIBUTOR DAO
// ============================================================================

class DistributorDao {
  final QueryExecutor db;

  DistributorDao(this.db);

  static const String _baseSelect = '''
    SELECT 
      d.id, d.name_en, d.name_bn, d.designation,
      d.address_en, d.address_bn, d.mobile,
      d.is_active, d.created_at, d.updated_at,
      d.area_id,
      a.id as area_id, a.name_en as area_name_en, a.name_bn as area_name_bn,
      a.region_id,
      r.id as region_id, r.name_en as region_name_en, r.name_bn as region_name_bn
    FROM distributors d
    JOIN areas a ON d.area_id = a.id
    JOIN regions r ON a.region_id = r.id
  ''';

  /// Get all active distributors with their area and region details
  Future<List<DistributorWithLocation>> getAllDistributors() async {
    const query = '''
      $_baseSelect
      WHERE d.is_active = 1
      ORDER BY d.name_en
    ''';

    final rows = await db.customQuery(query);
    return rows.map(_mapRow).toList();
  }

  /// Get distributor by ID with area/region
  Future<DistributorWithLocation?> getDistributorById(int id) async {
    const query = '''
      $_baseSelect
      WHERE d.id = ?
    ''';

    final rows = await db.customQuery(query, [id]);
    if (rows.isEmpty) return null;

    return _mapRow(rows.first);
  }

  /// Filter distributors by area
  Future<List<DistributorWithLocation>> getDistributorsByArea(
    int areaId,
  ) async {
    const query = '''
      $_baseSelect
      WHERE d.area_id = ? AND d.is_active = 1
      ORDER BY d.name_en
    ''';

    final rows = await db.customQuery(query, [areaId]);
    return rows.map(_mapRow).toList();
  }

  /// Filter distributors by region (via area join)
  Future<List<DistributorWithLocation>> getDistributorsByRegion(
    int regionId,
  ) async {
    const query = '''
      $_baseSelect
      WHERE a.region_id = ? AND d.is_active = 1
      ORDER BY d.name_en
    ''';

    final rows = await db.customQuery(query, [regionId]);
    return rows.map(_mapRow).toList();
  }

  /// Full-text search on distributors (query the FTS table with LIKE fallback)
  Future<List<DistributorWithLocation>> searchDistributors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<Map<String, dynamic>> rows = [];
    final isReady = await isFtsReady(db, 'distributors_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        const sqlQuery = '''
          SELECT 
            d.id, d.name_en, d.name_bn, d.designation,
            d.address_en, d.address_bn, d.mobile,
            d.is_active, d.created_at, d.updated_at,
            d.area_id,
            a.id as area_id, a.name_en as area_name_en, a.name_bn as area_name_bn,
            a.region_id,
            r.id as region_id, r.name_en as region_name_en, r.name_bn as region_name_bn
          FROM distributors d
          JOIN distributors_fts fts ON fts.rowid = d.id
          JOIN areas a ON d.area_id = a.id
          JOIN regions r ON a.region_id = r.id
          WHERE distributors_fts MATCH ? AND d.is_active = 1
          ORDER BY bm25(distributors_fts, 10.0, 10.0, 5.0, 2.0, 2.0, 1.0)
        ''';
        rows = await db.customQuery(sqlQuery, [sanitized]);
      } catch (_) {
        rows = [];
      }
    }

    if (rows.isEmpty) {
      final pattern = '%$trimmed%';
      const fallbackQuery = '''
        $_baseSelect
        WHERE d.is_active = 1 AND (d.name_en LIKE ? OR d.name_bn LIKE ? OR d.address_en LIKE ? OR d.address_bn LIKE ? OR d.mobile LIKE ?)
        ORDER BY d.name_en
      ''';
      rows = await db.customQuery(fallbackQuery, [
        pattern,
        pattern,
        pattern,
        pattern,
        pattern,
      ]);
    }

    return rows.map(_mapRow).toList();
  }

  /// Paginated, filtered query for Distributors screen
  Future<List<DistributorWithLocation>> getFilteredDistributors({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final args = <dynamic>[];
    List<String> where = ['d.is_active = 1'];
    String orderBy = '';

    if (query != null && query.isNotEmpty) {
      final sanitizedTokens = sanitizeFtsQuery(query);
      if (sanitizedTokens.isNotEmpty) {
        final isReady = await isFtsReady(db, 'distributors_fts');
        if (isReady) {
          where.add('distributors_fts MATCH ?');
          args.add(sanitizedTokens);
          orderBy =
              'ORDER BY bm25(distributors_fts, 10.0, 10.0, 5.0, 2.0, 2.0, 1.0)';
        } else {
          final pattern = '%$query%';
          where.add(
            '(d.name_en LIKE ? OR d.name_bn LIKE ? OR d.address_en LIKE ? OR d.address_bn LIKE ?)',
          );
          args.addAll([pattern, pattern, pattern, pattern]);
          orderBy = 'ORDER BY d.name_en';
        }
      } else {
        final pattern = '%$query%';
        where.add(
          '(d.name_en LIKE ? OR d.name_bn LIKE ? OR d.address_en LIKE ? OR d.address_bn LIKE ?)',
        );
        args.addAll([pattern, pattern, pattern, pattern]);
        orderBy = 'ORDER BY d.name_en';
      }
    } else {
      orderBy = 'ORDER BY d.name_en';
    }

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final placeholders = favoriteIds.map((_) => '?').join(',');
      orderBy =
          'ORDER BY CASE WHEN d.id IN ($placeholders) THEN 0 ELSE 1 END, ${orderBy.replaceFirst('ORDER BY ', '')}';
      args.addAll(favoriteIds);
    }

    final whereClause = 'WHERE ${where.join(' AND ')}';
    final ftsJoin = where.any((w) => w.contains('distributors_fts MATCH'))
        ? 'JOIN distributors_fts fts ON fts.rowid = d.id'
        : '';
    final limitClause = limit != null
        ? ' LIMIT $limit OFFSET ${offset ?? 0}'
        : '';

    final sqlQuery =
        '''
      SELECT 
        d.id, d.name_en, d.name_bn, d.designation,
        d.address_en, d.address_bn, d.mobile,
        d.is_active, d.created_at, d.updated_at,
        d.area_id,
        a.id as area_id, a.name_en as area_name_en, a.name_bn as area_name_bn,
        a.region_id,
        r.id as region_id, r.name_en as region_name_en, r.name_bn as region_name_bn
      FROM distributors d
      $ftsJoin
      JOIN areas a ON d.area_id = a.id
      JOIN regions r ON a.region_id = r.id
      $whereClause
      $orderBy
      $limitClause
    ''';

    final rows = await db.customQuery(sqlQuery, args);
    return rows.map(_mapRow).toList();
  }

  DistributorWithLocation _mapRow(Map<String, dynamic> row) {
    final distributor = Distributor.fromRow(row);
    final area = Area(
      id: row['area_id'] as int,
      regionId: row['region_id'] as int,
      nameEn: row['area_name_en'] as String,
      nameBn: row['area_name_bn'] as String?,
    );
    final region = Region(
      id: row['region_id'] as int,
      nameEn: row['region_name_en'] as String,
      nameBn: row['region_name_bn'] as String?,
    );
    return DistributorWithLocation(
      distributor: distributor,
      area: area,
      region: region,
    );
  }

  /// Insert or update a distributor
  Future<void> upsert(Distributor distributor) async {
    final map = distributor.toMap();
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.customExecute(
      'INSERT OR REPLACE INTO distributors ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Soft delete (set is_active = 0)
  Future<void> deactivate(int id) async {
    await db.customExecute(
      'UPDATE distributors SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// SALES PERSONNEL DAO
// ============================================================================

class SalesPersonnelDao {
  final QueryExecutor db;

  SalesPersonnelDao(this.db);

  /// Get all active sales personnel with their areas
  Future<List<SalesPersonnelWithAreas>> getAllSalesPersonnel() async {
    const query =
        'SELECT * FROM sales_personnel WHERE is_active = 1 ORDER BY name_en';
    final rows = await db.customQuery(query);

    return _hydrateList(
      rows.map((row) => SalesPersonnel.fromRow(row)).toList(),
    );
  }

  /// Paginated, filtered query for Sales Personnel screen
  Future<List<SalesPersonnelWithAreas>> getFilteredSalesPersonnel({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final args = <dynamic>[];
    List<String> where = ['sp.is_active = 1'];
    String orderBy = '';

    if (query != null && query.isNotEmpty) {
      final sanitizedTokens = sanitizeFtsQuery(query);
      if (sanitizedTokens.isNotEmpty) {
        final isReady = await isFtsReady(db, 'sales_personnel_fts');
        if (isReady) {
          where.add('sales_personnel_fts MATCH ?');
          args.add(sanitizedTokens);
          orderBy = 'ORDER BY fts.rank';
        } else {
          final pattern = '%$query%';
          where.add(
            '(sp.name_en LIKE ? OR sp.name_bn LIKE ? OR sp.designation LIKE ? OR sp.mobile LIKE ? OR sp.email LIKE ? OR sp.employee_id LIKE ?)',
          );
          args.addAll([pattern, pattern, pattern, pattern, pattern, pattern]);
          orderBy = 'ORDER BY sp.name_en';
        }
      } else {
        final pattern = '%$query%';
        where.add(
          '(sp.name_en LIKE ? OR sp.name_bn LIKE ? OR sp.designation LIKE ? OR sp.mobile LIKE ? OR sp.email LIKE ? OR sp.employee_id LIKE ?)',
        );
        args.addAll([pattern, pattern, pattern, pattern, pattern, pattern]);
        orderBy = 'ORDER BY sp.name_en';
      }
    } else {
      orderBy = 'ORDER BY sp.name_en';
    }

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final placeholders = favoriteIds.map((_) => '?').join(',');
      orderBy =
          'ORDER BY CASE WHEN sp.id IN ($placeholders) THEN 0 ELSE 1 END, ${orderBy.replaceFirst('ORDER BY ', '')}';
      args.addAll(favoriteIds);
    }

    final whereClause = 'WHERE ${where.join(' AND ')}';
    final ftsJoin = where.any((w) => w.contains('sales_personnel_fts MATCH'))
        ? 'JOIN sales_personnel_fts fts ON fts.rowid = sp.id'
        : '';
    final limitClause = limit != null
        ? ' LIMIT $limit OFFSET ${offset ?? 0}'
        : '';

    final sqlQuery =
        '''
      SELECT sp.* FROM sales_personnel sp
      $ftsJoin
      $whereClause
      $orderBy
      $limitClause
    ''';

    final rows = await db.customQuery(sqlQuery, args);
    return _hydrateList(
      rows.map((row) => SalesPersonnel.fromRow(row)).toList(),
    );
  }

  /// Get sales personnel by ID with their areas
  Future<SalesPersonnelWithAreas?> getSalesPersonnelById(int id) async {
    final rows = await db.customQuery(
      'SELECT * FROM sales_personnel WHERE id = ?',
      [id],
    );

    if (rows.isEmpty) return null;

    final personnel = SalesPersonnel.fromRow(rows.first);
    final hydrated = await _hydrateList([personnel]);
    return hydrated.first;
  }

  /// Get all areas for a sales person (via junction table)
  Future<List<Area>> getAreasForSalesPersonnel(int salesPersonnelId) async {
    const query = '''
      SELECT a.* FROM areas a
      JOIN sales_personnel_areas spa ON a.id = spa.area_id
      WHERE spa.sales_personnel_id = ?
      ORDER BY a.name_en
    ''';

    final rows = await db.customQuery(query, [salesPersonnelId]);
    return rows.map((row) => Area.fromRow(row)).toList();
  }

  /// Get all sales personnel covering a specific area
  Future<List<SalesPersonnelWithAreas>> getSalesPersonnelByArea(
    int areaId,
  ) async {
    const query = '''
      SELECT sp.* FROM sales_personnel sp
      JOIN sales_personnel_areas spa ON sp.id = spa.sales_personnel_id
      WHERE spa.area_id = ? AND sp.is_active = 1
      ORDER BY sp.name_en
    ''';

    final rows = await db.customQuery(query, [areaId]);
    return _hydrateList(
      rows.map((row) => SalesPersonnel.fromRow(row)).toList(),
    );
  }

  /// Full-text search on sales personnel
  Future<List<SalesPersonnelWithAreas>> searchSalesPersonnel(
    String query,
  ) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<Map<String, dynamic>> rows = [];
    final isReady = await isFtsReady(db, 'sales_personnel_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        const sqlQuery = '''
          SELECT sp.* FROM sales_personnel sp
          JOIN sales_personnel_fts fts ON fts.rowid = sp.id
          WHERE sales_personnel_fts MATCH ? AND sp.is_active = 1
          ORDER BY fts.rank
        ''';
        rows = await db.customQuery(sqlQuery, [sanitized]);
      } catch (_) {
        rows = [];
      }
    }

    if (rows.isEmpty) {
      final pattern = '%$trimmed%';
      const fallbackQuery = '''
        SELECT sp.* FROM sales_personnel sp
        WHERE sp.is_active = 1 AND (sp.name_en LIKE ? OR sp.name_bn LIKE ? OR sp.designation LIKE ? OR sp.mobile LIKE ? OR sp.email LIKE ? OR sp.employee_id LIKE ?)
        ORDER BY sp.name_en
      ''';
      rows = await db.customQuery(fallbackQuery, [
        pattern,
        pattern,
        pattern,
        pattern,
        pattern,
        pattern,
      ]);
    }

    return _hydrateList(
      rows.map((row) => SalesPersonnel.fromRow(row)).toList(),
    );
  }

  /// Helper to batch hydrate SalesPersonnel with their areas
  Future<List<SalesPersonnelWithAreas>> _hydrateList(
    List<SalesPersonnel> personnelList,
  ) async {
    if (personnelList.isEmpty) return [];

    final ids = personnelList.map((p) => p.id).toList();
    final placeholders = List.filled(ids.length, '?').join(',');

    final query =
        '''
      SELECT spa.sales_personnel_id, a.* FROM areas a
      JOIN sales_personnel_areas spa ON a.id = spa.area_id
      WHERE spa.sales_personnel_id IN ($placeholders)
      ORDER BY a.name_en
    ''';

    final rows = await db.customQuery(query, ids);
    final Map<int, List<Area>> areasByPersonnelId = {};

    for (final row in rows) {
      final personnelId = row['sales_personnel_id'] as int;
      final area = Area.fromRow(row);
      areasByPersonnelId.putIfAbsent(personnelId, () => []).add(area);
    }

    return personnelList.map((personnel) {
      final areas = areasByPersonnelId[personnel.id] ?? [];
      return SalesPersonnelWithAreas(personnel: personnel, areas: areas);
    }).toList();
  }

  /// Insert or update sales personnel
  Future<void> upsert(SalesPersonnel personnel) async {
    final map = personnel.toMap();
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.customExecute(
      'INSERT OR REPLACE INTO sales_personnel ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Add or update area assignment for a sales person
  Future<void> assignArea(int salesPersonnelId, int areaId) async {
    await db.customExecute(
      'INSERT OR REPLACE INTO sales_personnel_areas (sales_personnel_id, area_id) VALUES (?, ?)',
      [salesPersonnelId, areaId],
    );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int salesPersonnelId, int areaId) async {
    await db.customExecute(
      'DELETE FROM sales_personnel_areas WHERE sales_personnel_id = ? AND area_id = ?',
      [salesPersonnelId, areaId],
    );
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await db.customExecute(
      'UPDATE sales_personnel SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// VET DOCTOR DAO
// ============================================================================

class VetDoctorDao {
  final QueryExecutor db;

  VetDoctorDao(this.db);

  /// Get all active vet doctors with their areas
  Future<List<VetDoctorWithAreas>> getAllVetDoctors() async {
    const query =
        'SELECT * FROM vet_doctors WHERE is_active = 1 ORDER BY name_en';
    final rows = await db.customQuery(query);

    return _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());
  }

  /// Paginated, filtered query for Vet Doctors screen
  Future<List<VetDoctorWithAreas>> getFilteredVetDoctors({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final args = <dynamic>[];
    List<String> where = ['vd.is_active = 1'];
    String orderBy = '';

    if (query != null && query.isNotEmpty) {
      final sanitizedTokens = sanitizeFtsQuery(query);
      if (sanitizedTokens.isNotEmpty) {
        final isReady = await isFtsReady(db, 'vet_doctors_fts');
        if (isReady) {
          where.add('vet_doctors_fts MATCH ?');
          args.add(sanitizedTokens);
          orderBy = 'ORDER BY fts.rank';
        } else {
          final pattern = '%$query%';
          where.add(
            '(vd.name_en LIKE ? OR vd.name_bn LIKE ? OR vd.qualification LIKE ? OR vd.specialization LIKE ? OR vd.address_en LIKE ? OR vd.mobile LIKE ?)',
          );
          args.addAll([pattern, pattern, pattern, pattern, pattern, pattern]);
          orderBy = 'ORDER BY vd.name_en';
        }
      } else {
        final pattern = '%$query%';
        where.add(
          '(vd.name_en LIKE ? OR vd.name_bn LIKE ? OR vd.qualification LIKE ? OR vd.specialization LIKE ? OR vd.address_en LIKE ? OR vd.mobile LIKE ?)',
        );
        args.addAll([pattern, pattern, pattern, pattern, pattern, pattern]);
        orderBy = 'ORDER BY vd.name_en';
      }
    } else {
      orderBy = 'ORDER BY vd.name_en';
    }

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final placeholders = favoriteIds.map((_) => '?').join(',');
      orderBy =
          'ORDER BY CASE WHEN vd.id IN ($placeholders) THEN 0 ELSE 1 END, ${orderBy.replaceFirst('ORDER BY ', '')}';
      args.addAll(favoriteIds);
    }

    final whereClause = 'WHERE ${where.join(' AND ')}';
    final ftsJoin = where.any((w) => w.contains('vet_doctors_fts MATCH'))
        ? 'JOIN vet_doctors_fts fts ON fts.rowid = vd.id'
        : '';
    final limitClause = limit != null
        ? ' LIMIT $limit OFFSET ${offset ?? 0}'
        : '';

    final sqlQuery =
        '''
      SELECT vd.* FROM vet_doctors vd
      $ftsJoin
      $whereClause
      $orderBy
      $limitClause
    ''';

    final rows = await db.customQuery(sqlQuery, args);
    return _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());
  }

  /// Get vet doctor by ID with their areas
  Future<VetDoctorWithAreas?> getVetDoctorById(int id) async {
    final rows = await db.customQuery(
      'SELECT * FROM vet_doctors WHERE id = ?',
      [id],
    );

    if (rows.isEmpty) return null;

    final doctor = VetDoctor.fromRow(rows.first);
    final hydrated = await _hydrateList([doctor]);
    return hydrated.first;
  }

  /// Get all areas for a vet doctor (via junction table)
  Future<List<Area>> getAreasForVetDoctor(int vetDoctorId) async {
    const query = '''
      SELECT a.* FROM areas a
      JOIN vet_doctors_areas vda ON a.id = vda.area_id
      WHERE vda.vet_doctor_id = ?
      ORDER BY a.name_en
    ''';

    final rows = await db.customQuery(query, [vetDoctorId]);
    return rows.map((row) => Area.fromRow(row)).toList();
  }

  /// Get all vet doctors in a specific area
  Future<List<VetDoctorWithAreas>> getVetDoctorsByArea(int areaId) async {
    const query = '''
      SELECT vd.* FROM vet_doctors vd
      JOIN vet_doctors_areas vda ON vd.id = vda.vet_doctor_id
      WHERE vda.area_id = ? AND vd.is_active = 1
      ORDER BY vd.name_en
    ''';

    final rows = await db.customQuery(query, [areaId]);
    return _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());
  }

  /// Full-text search on vet doctors
  Future<List<VetDoctorWithAreas>> searchVetDoctors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<Map<String, dynamic>> rows = [];
    final isReady = await isFtsReady(db, 'vet_doctors_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        const sqlQuery = '''
          SELECT vd.* FROM vet_doctors vd
          JOIN vet_doctors_fts fts ON fts.rowid = vd.id
          WHERE vet_doctors_fts MATCH ? AND vd.is_active = 1
          ORDER BY fts.rank
        ''';
        rows = await db.customQuery(sqlQuery, [sanitized]);
      } catch (_) {
        rows = [];
      }
    }

    if (rows.isEmpty) {
      final pattern = '%$trimmed%';
      const fallbackQuery = '''
        SELECT vd.* FROM vet_doctors vd
        WHERE vd.is_active = 1 AND (vd.name_en LIKE ? OR vd.name_bn LIKE ? OR vd.qualification LIKE ? OR vd.specialization LIKE ? OR vd.address_en LIKE ? OR vd.mobile LIKE ?)
        ORDER BY vd.name_en
      ''';
      rows = await db.customQuery(fallbackQuery, [
        pattern,
        pattern,
        pattern,
        pattern,
        pattern,
        pattern,
      ]);
    }

    return _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());
  }

  /// Helper to batch hydrate VetDoctors with their areas
  Future<List<VetDoctorWithAreas>> _hydrateList(List<VetDoctor> doctors) async {
    if (doctors.isEmpty) return [];

    final ids = doctors.map((d) => d.id).toList();
    final placeholders = List.filled(ids.length, '?').join(',');

    final query =
        '''
      SELECT vda.vet_doctor_id, a.* FROM areas a
      JOIN vet_doctors_areas vda ON a.id = vda.area_id
      WHERE vda.vet_doctor_id IN ($placeholders)
      ORDER BY a.name_en
    ''';

    final rows = await db.customQuery(query, ids);
    final Map<int, List<Area>> areasByDoctorId = {};

    for (final row in rows) {
      final doctorId = row['vet_doctor_id'] as int;
      final area = Area.fromRow(row);
      areasByDoctorId.putIfAbsent(doctorId, () => []).add(area);
    }

    return doctors.map((doctor) {
      final areas = areasByDoctorId[doctor.id] ?? [];
      return VetDoctorWithAreas(doctor: doctor, areas: areas);
    }).toList();
  }

  /// Insert or update vet doctor
  Future<void> upsert(VetDoctor doctor) async {
    final map = doctor.toMap();
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.customExecute(
      'INSERT OR REPLACE INTO vet_doctors ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Add or update area assignment for a vet doctor
  Future<void> assignArea(int vetDoctorId, int areaId) async {
    await db.customExecute(
      'INSERT OR REPLACE INTO vet_doctors_areas (vet_doctor_id, area_id) VALUES (?, ?)',
      [vetDoctorId, areaId],
    );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int vetDoctorId, int areaId) async {
    await db.customExecute(
      'DELETE FROM vet_doctors_areas WHERE vet_doctor_id = ? AND area_id = ?',
      [vetDoctorId, areaId],
    );
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await db.customExecute(
      'UPDATE vet_doctors SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// LOCATION DAO (regions, areas)
// ============================================================================

class LocationDao {
  final QueryExecutor db;

  List<Region>? _cachedRegions;
  List<Area>? _cachedAreas;

  LocationDao(this.db);

  /// Clears the in-memory cache
  void clearCache() {
    _cachedRegions = null;
    _cachedAreas = null;
  }

  /// Get all regions (cached in memory)
  Future<List<Region>> getAllRegions() async {
    if (_cachedRegions != null) {
      return _cachedRegions!;
    }
    final rows = await db.customQuery('SELECT * FROM regions ORDER BY name_en');
    _cachedRegions = rows.map((row) => Region.fromRow(row)).toList();
    return _cachedRegions!;
  }

  /// Get all areas (cached in memory, optionally filtered by region)
  Future<List<Area>> getAllAreas({int? regionId}) async {
    if (_cachedAreas == null) {
      final rows = await db.customQuery('SELECT * FROM areas ORDER BY name_en');
      _cachedAreas = rows.map((row) => Area.fromRow(row)).toList();
    }

    if (regionId == null) {
      return _cachedAreas!;
    } else {
      return _cachedAreas!.where((area) => area.regionId == regionId).toList();
    }
  }

  /// Get area by ID
  Future<Area?> getAreaById(int id) async {
    if (_cachedAreas != null) {
      for (final area in _cachedAreas!) {
        if (area.id == id) return area;
      }
      return null;
    }
    final rows = await db.customQuery('SELECT * FROM areas WHERE id = ?', [id]);
    return rows.isNotEmpty ? Area.fromRow(rows.first) : null;
  }

  /// Get region by ID
  Future<Region?> getRegionById(int id) async {
    if (_cachedRegions != null) {
      for (final region in _cachedRegions!) {
        if (region.id == id) return region;
      }
      return null;
    }
    final rows = await db.customQuery('SELECT * FROM regions WHERE id = ?', [
      id,
    ]);
    return rows.isNotEmpty ? Region.fromRow(rows.first) : null;
  }
}
