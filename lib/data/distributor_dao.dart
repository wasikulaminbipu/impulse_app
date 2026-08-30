import 'package:impulse_app/data/db_extensions.dart';

import 'package:impulse_app/models/distributor.dart';
import 'package:impulse_app/data/fts_utils.dart';

// ============================================================================
// DISTRIBUTOR DAO
// ============================================================================

import 'package:impulse_app/data/app_databases.dart';

class DistributorDao {
  final DistributorsDb db;

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

    final rows = await db.executor.customQuery(query);
    return rows.map(_mapRow).toList();
  }

  /// Get distributor by ID with area/region
  Future<DistributorWithLocation?> getDistributorById(int id) async {
    const query = '''
      $_baseSelect
      WHERE d.id = ?
    ''';

    final rows = await db.executor.customQuery(query, [id]);
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

    final rows = await db.executor.customQuery(query, [areaId]);
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

    final rows = await db.executor.customQuery(query, [regionId]);
    return rows.map(_mapRow).toList();
  }

  /// Full-text search on distributors (query the FTS table with LIKE fallback)
  Future<List<DistributorWithLocation>> searchDistributors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<Map<String, dynamic>> rows = [];
    final isReady = await isFtsReady(db.executor, 'distributors_fts');
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
        rows = await db.executor.customQuery(sqlQuery, [sanitized]);
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
      rows = await db.executor.customQuery(fallbackQuery, [
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
        final isReady = await isFtsReady(db.executor, 'distributors_fts');
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

    final rows = await db.executor.customQuery(sqlQuery, args);
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
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO distributors ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Soft delete (set is_active = 0)
  Future<void> deactivate(int id) async {
    await db.executor.customExecute(
      'UPDATE distributors SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// SALES PERSONNEL DAO
// ============================================================================

class SalesPersonnelDao {
  final DistributorsDb db;

  SalesPersonnelDao(this.db);

  /// Get all active sales personnel with their areas
  Future<List<SalesPersonnelWithAreas>> getAllSalesPersonnel() async {
    const query =
        'SELECT * FROM sales_personnel WHERE is_active = 1 ORDER BY name_en';
    final rows = await db.executor.customQuery(query);

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

    final trimmed = query?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        final tokenConditions = <String>[];
        for (final token in tokens) {
          final pattern = '%$token%';
          tokenConditions.add('''
            (sp.name_en LIKE ? OR sp.name_bn LIKE ? OR sp.designation LIKE ? OR sp.mobile LIKE ? OR sp.email LIKE ? OR sp.employee_id LIKE ?
             OR EXISTS (SELECT 1 FROM sales_personnel_regions spr JOIN regions r ON r.id = spr.region_id WHERE spr.sales_personnel_id = sp.id AND (r.name_en LIKE ? OR r.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM sales_personnel_areas spa JOIN areas a ON a.id = spa.area_id WHERE spa.sales_personnel_id = sp.id AND (a.name_en LIKE ? OR a.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM sales_personnel_bases spb JOIN bases b ON b.id = spb.base_id WHERE spb.sales_personnel_id = sp.id AND (b.name_en LIKE ? OR b.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM sales_personnel_upazilas spu JOIN upazilas u ON u.id = spu.upazila_id WHERE spu.sales_personnel_id = sp.id AND (u.name_en LIKE ? OR u.name_bn LIKE ?)))
          ''');
          args.addAll([
            pattern, pattern, pattern, pattern, pattern, pattern,
            pattern, pattern,
            pattern, pattern,
            pattern, pattern,
            pattern, pattern,
          ]);
        }
        where.add('(${tokenConditions.join(' AND ')})');
      }
    }

    orderBy = 'ORDER BY sp.name_en';

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final placeholders = favoriteIds.map((_) => '?').join(',');
      orderBy =
          'ORDER BY CASE WHEN sp.id IN ($placeholders) THEN 0 ELSE 1 END, ${orderBy.replaceFirst('ORDER BY ', '')}';
      args.addAll(favoriteIds);
    }

    final whereClause = 'WHERE ${where.join(' AND ')}';
    final limitClause = limit != null
        ? ' LIMIT $limit OFFSET ${offset ?? 0}'
        : '';

    final sqlQuery =
        '''
      SELECT sp.* FROM sales_personnel sp
      $whereClause
      $orderBy
      $limitClause
    ''';

    final rows = await db.executor.customQuery(sqlQuery, args);
    var results = await _hydrateList(
      rows.map((row) => SalesPersonnel.fromRow(row)).toList(),
    );

    if (results.isEmpty && trimmed.isNotEmpty) {
      final allPersonnel = await getAllSalesPersonnel();
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        final scored = <MapEntry<SalesPersonnelWithAreas, double>>[];
        for (final item in allPersonnel) {
          double maxScore = 0.0;
          for (final token in tokens) {
            final candidates = [
              item.personnel.nameEn,
              item.personnel.nameBn ?? '',
              item.personnel.designation ?? '',
              item.personnel.mobile ?? '',
              item.personnel.employeeId ?? '',
              ...item.regions.map((r) => '${r.nameEn} ${r.nameBn ?? ''}'),
              ...item.areas.map((a) => '${a.nameEn} ${a.nameBn ?? ''}'),
              ...item.bases.map((b) => '${b.nameEn} ${b.nameBn ?? ''}'),
              ...item.upazilas.map((u) => '${u.nameEn} ${u.nameBn ?? ''}'),
            ];

            for (final candidate in candidates) {
              if (candidate.isEmpty) continue;
              for (final word in candidate.split(RegExp(r'\s+'))) {
                final sim = calculateSimilarity(word, token);
                final phoneticSim = calculateSimilarity(
                  getPhoneticKey(word),
                  getPhoneticKey(token),
                );
                final bestSim = sim > phoneticSim ? sim : phoneticSim;
                if (bestSim > maxScore) maxScore = bestSim;
              }
            }
          }
          if (maxScore >= 0.55) {
            scored.add(MapEntry(item, maxScore));
          }
        }
        scored.sort((a, b) => b.value.compareTo(a.value));
        final fuzzyMatches = scored.map((e) => e.key).toList();
        final start = offset ?? 0;
        if (start < fuzzyMatches.length) {
          final end = (limit != null && start + limit < fuzzyMatches.length)
              ? start + limit
              : fuzzyMatches.length;
          results = fuzzyMatches.sublist(start, end);
        } else {
          results = [];
        }
      }
    }

    return results;
  }

  /// Get sales personnel by ID with their areas
  Future<SalesPersonnelWithAreas?> getSalesPersonnelById(int id) async {
    final rows = await db.executor.customQuery(
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

    final rows = await db.executor.customQuery(query, [salesPersonnelId]);
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

    final rows = await db.executor.customQuery(query, [areaId]);
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
    final isReady = await isFtsReady(db.executor, 'sales_personnel_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        const sqlQuery = '''
          SELECT sp.* FROM sales_personnel sp
          JOIN sales_personnel_fts fts ON fts.rowid = sp.id
          WHERE sales_personnel_fts MATCH ? AND sp.is_active = 1
          ORDER BY fts.rank
        ''';
        rows = await db.executor.customQuery(sqlQuery, [sanitized]);
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
      rows = await db.executor.customQuery(fallbackQuery, [
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

  /// Helper to batch hydrate SalesPersonnel with full coverage details (regions, areas, bases, upazilas)
  Future<List<SalesPersonnelWithAreas>> _hydrateList(
    List<SalesPersonnel> personnelList,
  ) async {
    if (personnelList.isEmpty) return [];

    final ids = personnelList.map((p) => p.id).toList();

    // 1. Fetch Areas
    final areaRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT spa.sales_personnel_id, a.* FROM areas a
      JOIN sales_personnel_areas spa ON a.id = spa.area_id
      WHERE spa.sales_personnel_id IN 
      ''',
      suffix: 'ORDER BY a.name_en',
      ids: ids,
    );
    final Map<int, List<Area>> areasByPersonnelId = {};
    for (final row in areaRows) {
      final personnelId = row['sales_personnel_id'] as int;
      areasByPersonnelId.putIfAbsent(personnelId, () => []).add(Area.fromRow(row));
    }

    // 2. Fetch Regions
    final regionRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT spr.sales_personnel_id, r.* FROM regions r
      JOIN sales_personnel_regions spr ON r.id = spr.region_id
      WHERE spr.sales_personnel_id IN 
      ''',
      suffix: 'ORDER BY r.name_en',
      ids: ids,
    );
    final Map<int, List<Region>> regionsByPersonnelId = {};
    for (final row in regionRows) {
      final personnelId = row['sales_personnel_id'] as int;
      regionsByPersonnelId.putIfAbsent(personnelId, () => []).add(Region.fromRow(row));
    }

    // 3. Fetch Bases
    final baseRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT spb.sales_personnel_id, b.* FROM bases b
      JOIN sales_personnel_bases spb ON b.id = spb.base_id
      WHERE spb.sales_personnel_id IN 
      ''',
      suffix: 'ORDER BY b.name_en',
      ids: ids,
    );
    final Map<int, List<Base>> basesByPersonnelId = {};
    for (final row in baseRows) {
      final personnelId = row['sales_personnel_id'] as int;
      basesByPersonnelId.putIfAbsent(personnelId, () => []).add(Base.fromRow(row));
    }

    // 4. Fetch Upazilas
    final upazilaRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT spu.sales_personnel_id, u.* FROM upazilas u
      JOIN sales_personnel_upazilas spu ON u.id = spu.upazila_id
      WHERE spu.sales_personnel_id IN 
      ''',
      suffix: 'ORDER BY u.name_en',
      ids: ids,
    );
    final Map<int, List<Upazila>> upazilasByPersonnelId = {};
    for (final row in upazilaRows) {
      final personnelId = row['sales_personnel_id'] as int;
      upazilasByPersonnelId.putIfAbsent(personnelId, () => []).add(Upazila.fromRow(row));
    }

    return personnelList.map((personnel) {
      return SalesPersonnelWithAreas(
        personnel: personnel.copyWith(
          regionIds: (regionsByPersonnelId[personnel.id] ?? []).map((r) => r.id).toList(),
          areaIds: (areasByPersonnelId[personnel.id] ?? []).map((a) => a.id).toList(),
          baseIds: (basesByPersonnelId[personnel.id] ?? []).map((b) => b.id).toList(),
          upazilaIds: (upazilasByPersonnelId[personnel.id] ?? []).map((u) => u.id).toList(),
        ),
        areas: areasByPersonnelId[personnel.id] ?? [],
        regions: regionsByPersonnelId[personnel.id] ?? [],
        bases: basesByPersonnelId[personnel.id] ?? [],
        upazilas: upazilasByPersonnelId[personnel.id] ?? [],
      );
    }).toList();
  }

  /// Insert or update sales personnel
  Future<void> upsert(SalesPersonnel personnel) async {
    final map = personnel.toMap();
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO sales_personnel ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Add or update area assignment for a sales person
  Future<void> assignArea(int salesPersonnelId, int areaId) async {
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO sales_personnel_areas (sales_personnel_id, area_id) VALUES (?, ?)',
      [salesPersonnelId, areaId],
    );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int salesPersonnelId, int areaId) async {
    await db.executor.customExecute(
      'DELETE FROM sales_personnel_areas WHERE sales_personnel_id = ? AND area_id = ?',
      [salesPersonnelId, areaId],
    );
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await db.executor.customExecute(
      'UPDATE sales_personnel SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// VET DOCTOR DAO
// ============================================================================

class VetDoctorDao {
  final DistributorsDb db;

  VetDoctorDao(this.db);

  /// Get all active vet doctors with their areas
  Future<List<VetDoctorWithAreas>> getAllVetDoctors() async {
    const query =
        'SELECT * FROM vet_doctors WHERE is_active = 1 ORDER BY name_en';
    final rows = await db.executor.customQuery(query);

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

    final trimmed = query?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        final tokenConditions = <String>[];
        for (final token in tokens) {
          final pattern = '%$token%';
          tokenConditions.add('''
            (vd.name_en LIKE ? OR vd.name_bn LIKE ? OR vd.qualification LIKE ? OR vd.specialization LIKE ? OR vd.bvc_registration_no LIKE ? OR vd.clinic_or_hospital_name_en LIKE ? OR vd.clinic_or_hospital_name_bn LIKE ? OR vd.address_en LIKE ? OR vd.address_bn LIKE ? OR vd.mobile LIKE ? OR vd.email LIKE ?
             OR EXISTS (SELECT 1 FROM vet_doctors_regions vdr JOIN regions r ON r.id = vdr.region_id WHERE vdr.vet_doctor_id = vd.id AND (r.name_en LIKE ? OR r.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM vet_doctors_areas vda JOIN areas a ON a.id = vda.area_id WHERE vda.vet_doctor_id = vd.id AND (a.name_en LIKE ? OR a.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM vet_doctors_bases vdb JOIN bases b ON b.id = vdb.base_id WHERE vdb.vet_doctor_id = vd.id AND (b.name_en LIKE ? OR b.name_bn LIKE ?))
             OR EXISTS (SELECT 1 FROM vet_doctors_upazilas vdu JOIN upazilas u ON u.id = vdu.upazila_id WHERE vdu.vet_doctor_id = vd.id AND (u.name_en LIKE ? OR u.name_bn LIKE ?)))
          ''');
          args.addAll([
            pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern, pattern,
            pattern, pattern,
            pattern, pattern,
            pattern, pattern,
            pattern, pattern,
          ]);
        }
        where.add('(${tokenConditions.join(' AND ')})');
      }
    }

    orderBy = 'ORDER BY vd.name_en';

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final placeholders = favoriteIds.map((_) => '?').join(',');
      orderBy =
          'ORDER BY CASE WHEN vd.id IN ($placeholders) THEN 0 ELSE 1 END, ${orderBy.replaceFirst('ORDER BY ', '')}';
      args.addAll(favoriteIds);
    }

    final whereClause = 'WHERE ${where.join(' AND ')}';
    final limitClause = limit != null
        ? ' LIMIT $limit OFFSET ${offset ?? 0}'
        : '';

    final sqlQuery =
        '''
      SELECT vd.* FROM vet_doctors vd
      $whereClause
      $orderBy
      $limitClause
    ''';

    final rows = await db.executor.customQuery(sqlQuery, args);
    var results = await _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());

    if (results.isEmpty && trimmed.isNotEmpty) {
      final allDoctors = await getAllVetDoctors();
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        final scored = <MapEntry<VetDoctorWithAreas, double>>[];
        for (final item in allDoctors) {
          double maxScore = 0.0;
          for (final token in tokens) {
            final candidates = [
              item.doctor.nameEn,
              item.doctor.nameBn ?? '',
              item.doctor.qualification ?? '',
              item.doctor.specialization ?? '',
              item.doctor.bvcRegistrationNo ?? '',
              item.doctor.clinicOrHospitalNameEn ?? '',
              item.doctor.clinicOrHospitalNameBn ?? '',
              item.doctor.mobile ?? '',
              item.doctor.email ?? '',
              ...item.regions.map((r) => '${r.nameEn} ${r.nameBn ?? ''}'),
              ...item.areas.map((a) => '${a.nameEn} ${a.nameBn ?? ''}'),
              ...item.bases.map((b) => '${b.nameEn} ${b.nameBn ?? ''}'),
              ...item.upazilas.map((u) => '${u.nameEn} ${u.nameBn ?? ''}'),
            ];

            for (final candidate in candidates) {
              if (candidate.isEmpty) continue;
              for (final word in candidate.split(RegExp(r'\s+'))) {
                final sim = calculateSimilarity(word, token);
                final phoneticSim = calculateSimilarity(
                  getPhoneticKey(word),
                  getPhoneticKey(token),
                );
                final bestSim = sim > phoneticSim ? sim : phoneticSim;
                if (bestSim > maxScore) maxScore = bestSim;
              }
            }
          }
          if (maxScore >= 0.55) {
            scored.add(MapEntry(item, maxScore));
          }
        }
        scored.sort((a, b) => b.value.compareTo(a.value));
        final fuzzyMatches = scored.map((e) => e.key).toList();
        final start = offset ?? 0;
        if (start < fuzzyMatches.length) {
          final end = (limit != null && start + limit < fuzzyMatches.length)
              ? start + limit
              : fuzzyMatches.length;
          results = fuzzyMatches.sublist(start, end);
        } else {
          results = [];
        }
      }
    }

    return results;
  }

  /// Get vet doctor by ID with their areas
  Future<VetDoctorWithAreas?> getVetDoctorById(int id) async {
    final rows = await db.executor.customQuery(
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

    final rows = await db.executor.customQuery(query, [vetDoctorId]);
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

    final rows = await db.executor.customQuery(query, [areaId]);
    return _hydrateList(rows.map((row) => VetDoctor.fromRow(row)).toList());
  }

  /// Full-text search on vet doctors
  Future<List<VetDoctorWithAreas>> searchVetDoctors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<Map<String, dynamic>> rows = [];
    final isReady = await isFtsReady(db.executor, 'vet_doctors_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        const sqlQuery = '''
          SELECT vd.* FROM vet_doctors vd
          JOIN vet_doctors_fts fts ON fts.rowid = vd.id
          WHERE vet_doctors_fts MATCH ? AND vd.is_active = 1
          ORDER BY fts.rank
        ''';
        rows = await db.executor.customQuery(sqlQuery, [sanitized]);
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
      rows = await db.executor.customQuery(fallbackQuery, [
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

  /// Helper to batch hydrate VetDoctors with full coverage details (regions, areas, bases, upazilas)
  Future<List<VetDoctorWithAreas>> _hydrateList(List<VetDoctor> doctors) async {
    if (doctors.isEmpty) return [];

    final ids = doctors.map((d) => d.id).toList();

    // 1. Fetch Areas
    final areaRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT vda.vet_doctor_id, a.* FROM areas a
      JOIN vet_doctors_areas vda ON a.id = vda.area_id
      WHERE vda.vet_doctor_id IN 
      ''',
      suffix: 'ORDER BY a.name_en',
      ids: ids,
    );
    final Map<int, List<Area>> areasByDoctorId = {};
    for (final row in areaRows) {
      final doctorId = row['vet_doctor_id'] as int;
      areasByDoctorId.putIfAbsent(doctorId, () => []).add(Area.fromRow(row));
    }

    // 2. Fetch Regions
    final regionRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT vdr.vet_doctor_id, r.* FROM regions r
      JOIN vet_doctors_regions vdr ON r.id = vdr.region_id
      WHERE vdr.vet_doctor_id IN 
      ''',
      suffix: 'ORDER BY r.name_en',
      ids: ids,
    );
    final Map<int, List<Region>> regionsByDoctorId = {};
    for (final row in regionRows) {
      final doctorId = row['vet_doctor_id'] as int;
      regionsByDoctorId.putIfAbsent(doctorId, () => []).add(Region.fromRow(row));
    }

    // 3. Fetch Bases
    final baseRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT vdb.vet_doctor_id, b.* FROM bases b
      JOIN vet_doctors_bases vdb ON b.id = vdb.base_id
      WHERE vdb.vet_doctor_id IN 
      ''',
      suffix: 'ORDER BY b.name_en',
      ids: ids,
    );
    final Map<int, List<Base>> basesByDoctorId = {};
    for (final row in baseRows) {
      final doctorId = row['vet_doctor_id'] as int;
      basesByDoctorId.putIfAbsent(doctorId, () => []).add(Base.fromRow(row));
    }

    // 4. Fetch Upazilas
    final upazilaRows = await db.executor.chunkedInQuery(
      prefix: '''
      SELECT vdu.vet_doctor_id, u.* FROM upazilas u
      JOIN vet_doctors_upazilas vdu ON u.id = vdu.upazila_id
      WHERE vdu.vet_doctor_id IN 
      ''',
      suffix: 'ORDER BY u.name_en',
      ids: ids,
    );
    final Map<int, List<Upazila>> upazilasByDoctorId = {};
    for (final row in upazilaRows) {
      final doctorId = row['vet_doctor_id'] as int;
      upazilasByDoctorId.putIfAbsent(doctorId, () => []).add(Upazila.fromRow(row));
    }

    return doctors.map((doctor) {
      return VetDoctorWithAreas(
        doctor: doctor.copyWith(
          regionIds: (regionsByDoctorId[doctor.id] ?? []).map((r) => r.id).toList(),
          areaIds: (areasByDoctorId[doctor.id] ?? []).map((a) => a.id).toList(),
          baseIds: (basesByDoctorId[doctor.id] ?? []).map((b) => b.id).toList(),
          upazilaIds: (upazilasByDoctorId[doctor.id] ?? []).map((u) => u.id).toList(),
        ),
        areas: areasByDoctorId[doctor.id] ?? [],
        regions: regionsByDoctorId[doctor.id] ?? [],
        bases: basesByDoctorId[doctor.id] ?? [],
        upazilas: upazilasByDoctorId[doctor.id] ?? [],
      );
    }).toList();
  }

  /// Insert or update vet doctor
  Future<void> upsert(VetDoctor doctor) async {
    final map = doctor.toMap();
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO vet_doctors ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );
  }

  /// Add or update area assignment for a vet doctor
  Future<void> assignArea(int vetDoctorId, int areaId) async {
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO vet_doctors_areas (vet_doctor_id, area_id) VALUES (?, ?)',
      [vetDoctorId, areaId],
    );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int vetDoctorId, int areaId) async {
    await db.executor.customExecute(
      'DELETE FROM vet_doctors_areas WHERE vet_doctor_id = ? AND area_id = ?',
      [vetDoctorId, areaId],
    );
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await db.executor.customExecute(
      'UPDATE vet_doctors SET is_active = 0, updated_at = ? WHERE id = ?',
      [DateTime.now().toIso8601String(), id],
    );
  }
}

// ============================================================================
// LOCATION DAO (regions, areas)
// ============================================================================

class LocationDao {
  final DistributorsDb db;

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
    final rows = await db.executor.customQuery('SELECT * FROM regions ORDER BY name_en');
    _cachedRegions = rows.map((row) => Region.fromRow(row)).toList();
    return _cachedRegions!;
  }

  /// Get all areas (cached in memory, optionally filtered by region)
  Future<List<Area>> getAllAreas({int? regionId}) async {
    if (_cachedAreas == null) {
      final rows = await db.executor.customQuery('SELECT * FROM areas ORDER BY name_en');
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
    final rows = await db.executor.customQuery('SELECT * FROM areas WHERE id = ?', [id]);
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
    final rows = await db.executor.customQuery('SELECT * FROM regions WHERE id = ?', [
      id,
    ]);
    return rows.isNotEmpty ? Region.fromRow(rows.first) : null;
  }

  /// Get all bases (optionally filtered by area)
  Future<List<Base>> getAllBases({int? areaId}) async {
    final rows = areaId == null
        ? await db.executor.customQuery('SELECT * FROM bases ORDER BY name_en')
        : await db.executor.customQuery('SELECT * FROM bases WHERE area_id = ? ORDER BY name_en', [areaId]);
    return rows.map((row) => Base.fromRow(row)).toList();
  }

  /// Get base by ID
  Future<Base?> getBaseById(int id) async {
    final rows = await db.executor.customQuery('SELECT * FROM bases WHERE id = ?', [id]);
    return rows.isNotEmpty ? Base.fromRow(rows.first) : null;
  }

  /// Get upazilas covered by a specific base
  Future<List<Upazila>> getUpazilasForBase(int baseId) async {
    const query = '''
      SELECT u.* FROM upazilas u
      JOIN base_upazilas bu ON u.id = bu.upazila_id
      WHERE bu.base_id = ?
      ORDER BY u.name_en
    ''';
    final rows = await db.executor.customQuery(query, [baseId]);
    return rows.map((row) => Upazila.fromRow(row)).toList();
  }

  /// Get all bases hydrated with Area, Region, and covered Upazilas
  Future<List<BaseWithUpazilas>> getAllBasesWithUpazilas() async {
    const query = '''
      SELECT 
        b.id as base_id, b.name_en as base_name_en, b.name_bn as base_name_bn, b.area_id,
        a.name_en as area_name_en, a.name_bn as area_name_bn, a.region_id,
        r.name_en as region_name_en, r.name_bn as region_name_bn
      FROM bases b
      JOIN areas a ON b.area_id = a.id
      JOIN regions r ON a.region_id = r.id
      ORDER BY r.name_en, a.name_en, b.name_en
    ''';
    final rows = await db.executor.customQuery(query);
    if (rows.isEmpty) return [];

    final baseIds = rows.map((r) => r['base_id'] as int).toList();
    final upazilaRows = await db.executor.chunkedInQuery(
      prefix: '''
        SELECT bu.base_id, u.* FROM upazilas u
        JOIN base_upazilas bu ON u.id = bu.upazila_id
        WHERE bu.base_id IN 
      ''',
      suffix: ' ORDER BY u.name_en',
      ids: baseIds,
    );

    final Map<int, List<Upazila>> upazilasByBaseId = {};
    for (final row in upazilaRows) {
      final bId = row['base_id'] as int;
      final upazila = Upazila.fromRow(row);
      upazilasByBaseId.putIfAbsent(bId, () => []).add(upazila);
    }

    return rows.map((row) {
      final bId = row['base_id'] as int;
      final base = Base(
        id: bId,
        areaId: row['area_id'] as int,
        nameEn: row['base_name_en'] as String,
        nameBn: row['base_name_bn'] as String?,
        upazilaIds: (upazilasByBaseId[bId] ?? []).map((u) => u.id).toList(),
      );
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
      return BaseWithUpazilas(
        base: base,
        area: area,
        region: region,
        upazilas: upazilasByBaseId[bId] ?? [],
      );
    }).toList();
  }

  /// Get all divisions
  Future<List<Division>> getAllDivisions() async {
    final rows = await db.executor.customQuery('SELECT * FROM divisions ORDER BY name_en');
    return rows.map((row) => Division.fromRow(row)).toList();
  }

  /// Get all districts (optionally filtered by division)
  Future<List<District>> getAllDistricts({int? divisionId}) async {
    final rows = divisionId == null
        ? await db.executor.customQuery('SELECT * FROM districts ORDER BY name_en')
        : await db.executor.customQuery('SELECT * FROM districts WHERE division_id = ? ORDER BY name_en', [divisionId]);
    return rows.map((row) => District.fromRow(row)).toList();
  }

  /// Get all upazilas (optionally filtered by district)
  Future<List<Upazila>> getAllUpazilas({int? districtId}) async {
    final rows = districtId == null
        ? await db.executor.customQuery('SELECT * FROM upazilas ORDER BY name_en')
        : await db.executor.customQuery('SELECT * FROM upazilas WHERE district_id = ? ORDER BY name_en', [districtId]);
    return rows.map((row) => Upazila.fromRow(row)).toList();
  }

  /// Insert or update base and set its covered upazilas
  Future<void> upsertBase(Base base, {List<int>? upazilaIds}) async {
    final map = base.toMap()..remove('upazila_ids');
    final keys = map.keys.join(',');
    final placeholders = map.keys.map((_) => '?').join(',');
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO bases ($keys) VALUES ($placeholders)',
      map.values.toList(),
    );

    if (upazilaIds != null) {
      await db.executor.customExecute('DELETE FROM base_upazilas WHERE base_id = ?', [base.id]);
      for (final uId in upazilaIds) {
        await assignUpazilaToBase(base.id, uId);
      }
    }
  }

  /// Assign an upazila to a base
  Future<void> assignUpazilaToBase(int baseId, int upazilaId) async {
    await db.executor.customExecute(
      'INSERT OR REPLACE INTO base_upazilas (base_id, upazila_id) VALUES (?, ?)',
      [baseId, upazilaId],
    );
  }

  /// Remove upazila assignment from base
  Future<void> removeUpazilaFromBase(int baseId, int upazilaId) async {
    await db.executor.customExecute(
      'DELETE FROM base_upazilas WHERE base_id = ? AND upazila_id = ?',
      [baseId, upazilaId],
    );
  }

  /// Delete base
  Future<void> deleteBase(int id) async {
    await db.executor.customExecute('DELETE FROM bases WHERE id = ?', [id]);
  }
}

