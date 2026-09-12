// ============================================================================
// DISTRIBUTOR DAO
// ============================================================================

import 'package:drift/drift.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/fts_utils.dart';
import 'package:impulse_app/models/distributor.dart';

/// Data access object for querying distributors, sales personnel, vet doctors,
/// and associated geographic hierarchies (divisions, districts, upazilas, regions, and areas).
class DistributorDao {
  final DistributorsDb db;

  DistributorDao(this.db);

  JoinedSelectStatement<HasResultSet, dynamic> _baseQuery() {
    return db.select(db.distributors).join([
      innerJoin(db.areas, db.areas.id.equalsExp(db.distributors.areaId)),
      innerJoin(db.regions, db.regions.id.equalsExp(db.areas.regionId)),
    ]);
  }

  DistributorWithLocation _mapTypedRow(TypedResult row) {
    final d = row.readTable(db.distributors);
    final a = row.readTable(db.areas);
    final r = row.readTable(db.regions);

    final distributor = Distributor(
      id: d.id,
      nameEn: d.nameEn,
      nameBn: d.nameBn,
      designation: d.designation,
      addressEn: d.addressEn,
      addressBn: d.addressBn,
      upazilaId: d.upazilaId,
      baseId: d.baseId,
      areaId: d.areaId,
      mobile: d.mobile,
      isActive: d.isActive == 1,
      createdAt: DateTime.tryParse(d.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(d.updatedAt) ?? DateTime.now(),
    );

    final area = Area(
      id: a.id,
      regionId: a.regionId,
      nameEn: a.nameEn,
      nameBn: a.nameBn,
    );

    final region = Region(id: r.id, nameEn: r.nameEn, nameBn: r.nameBn);

    return DistributorWithLocation(
      distributor: distributor,
      area: area,
      region: region,
    );
  }

  /// Get all active distributors with their area and region details
  Future<List<DistributorWithLocation>> getAllDistributors() async {
    final q = _baseQuery()
      ..where(db.distributors.isActive.equals(1))
      ..orderBy([OrderingTerm.asc(db.distributors.nameEn)]);

    final rows = await q.get();
    return rows.map(_mapTypedRow).toList();
  }

  /// Get distributor by ID with area/region
  Future<DistributorWithLocation?> getDistributorById(int id) async {
    final q = _baseQuery()..where(db.distributors.id.equals(id));
    final rows = await q.get();
    if (rows.isEmpty) return null;

    return _mapTypedRow(rows.first);
  }

  /// Filter distributors by area
  Future<List<DistributorWithLocation>> getDistributorsByArea(
    int areaId,
  ) async {
    final q = _baseQuery()
      ..where(
        db.distributors.areaId.equals(areaId) &
            db.distributors.isActive.equals(1),
      )
      ..orderBy([OrderingTerm.asc(db.distributors.nameEn)]);

    final rows = await q.get();
    return rows.map(_mapTypedRow).toList();
  }

  /// Filter distributors by region (via area join)
  Future<List<DistributorWithLocation>> getDistributorsByRegion(
    int regionId,
  ) async {
    final q = _baseQuery()
      ..where(
        db.areas.regionId.equals(regionId) & db.distributors.isActive.equals(1),
      )
      ..orderBy([OrderingTerm.asc(db.distributors.nameEn)]);

    final rows = await q.get();
    return rows.map(_mapTypedRow).toList();
  }

  /// Full-text search on distributors (query the FTS table with LIKE fallback)
  Future<List<DistributorWithLocation>> searchDistributors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<DistributorWithLocation> results = [];
    final isReady = await isFtsReady(db.executor, 'distributors_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        final ftsRows = await db
            .customSelect(
              'SELECT rowid FROM distributors_fts WHERE distributors_fts MATCH ? ORDER BY bm25(distributors_fts, 10.0, 10.0, 5.0, 2.0, 2.0, 1.0)',
              variables: [Variable.withString(sanitized)],
            )
            .get();
        final ids = ftsRows.map((r) => r.read<int>('rowid')).toList();
        if (ids.isNotEmpty) {
          final q = _baseQuery()
            ..where(
              db.distributors.id.isIn(ids) & db.distributors.isActive.equals(1),
            );
          final rows = await q.get();
          final rowMap = {
            for (final r in rows)
              r.readTable(db.distributors).id: _mapTypedRow(r),
          };
          results = ids
              .map((id) => rowMap[id])
              .whereType<DistributorWithLocation>()
              .toList();
        }
      } catch (_) {
        results = [];
      }
    }

    if (results.isEmpty) {
      final pattern = '%$trimmed%';
      final q = _baseQuery()
        ..where(
          db.distributors.isActive.equals(1) &
              (db.distributors.nameEn.like(pattern) |
                  db.distributors.nameBn.like(pattern) |
                  db.distributors.addressEn.like(pattern) |
                  db.distributors.addressBn.like(pattern) |
                  db.distributors.mobile.like(pattern)),
        )
        ..orderBy([OrderingTerm.asc(db.distributors.nameEn)]);
      final rows = await q.get();
      results = rows.map(_mapTypedRow).toList();
    }

    return results;
  }

  /// Paginated, filtered query for Distributors screen
  Future<List<DistributorWithLocation>> getFilteredDistributors({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final trimmed = query?.trim() ?? '';
    List<int>? ftsMatchedIds;

    if (trimmed.isNotEmpty) {
      final sanitizedTokens = sanitizeFtsQuery(trimmed);
      if (sanitizedTokens.isNotEmpty) {
        final isReady = await isFtsReady(db.executor, 'distributors_fts');
        if (isReady) {
          try {
            final ftsRows = await db
                .customSelect(
                  'SELECT rowid FROM distributors_fts WHERE distributors_fts MATCH ? ORDER BY bm25(distributors_fts, 10.0, 10.0, 5.0, 2.0, 2.0, 1.0)',
                  variables: [Variable.withString(sanitizedTokens)],
                )
                .get();
            ftsMatchedIds = ftsRows.map((r) => r.read<int>('rowid')).toList();
          } catch (_) {}
        }
      }
    }

    final q = _baseQuery();
    Expression<bool> predicate = db.distributors.isActive.equals(1);

    if (ftsMatchedIds != null && ftsMatchedIds.isNotEmpty) {
      predicate = predicate & db.distributors.id.isIn(ftsMatchedIds);
    } else if (trimmed.isNotEmpty) {
      final pattern = '%$trimmed%';
      predicate =
          predicate &
          (db.distributors.nameEn.like(pattern) |
              db.distributors.nameBn.like(pattern) |
              db.distributors.addressEn.like(pattern) |
              db.distributors.addressBn.like(pattern) |
              db.distributors.mobile.like(pattern));
    }

    q.where(predicate);

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final favExpr = CustomExpression<int>(
        'CASE WHEN "distributors"."id" IN (${favoriteIds.join(",")}) THEN 0 ELSE 1 END',
      );
      q.orderBy([
        OrderingTerm.asc(favExpr),
        OrderingTerm.asc(db.distributors.nameEn),
      ]);
    } else {
      q.orderBy([OrderingTerm.asc(db.distributors.nameEn)]);
    }

    if (limit != null) {
      q.limit(limit, offset: offset ?? 0);
    }

    final rows = await q.get();
    final mapped = rows.map(_mapTypedRow).toList();

    // If FTS matches were used and no explicit favorites reordering is requested, retain FTS BM25 rank
    if (ftsMatchedIds != null &&
        ftsMatchedIds.isNotEmpty &&
        favoriteIds == null) {
      final map = {for (final item in mapped) item.distributor.id: item};
      return ftsMatchedIds
          .map((id) => map[id])
          .whereType<DistributorWithLocation>()
          .toList();
    }

    return mapped;
  }

  /// Insert or update a distributor
  Future<void> upsert(Distributor distributor) async {
    await db
        .into(db.distributors)
        .insertOnConflictUpdate(
          DistributorsCompanion(
            id: Value(distributor.id),
            nameEn: Value(distributor.nameEn),
            nameBn: Value(distributor.nameBn ?? ''),
            designation: Value(distributor.designation),
            addressEn: Value(distributor.addressEn),
            addressBn: Value(distributor.addressBn),
            upazilaId: Value(distributor.upazilaId),
            baseId: Value(distributor.baseId),
            areaId: Value(distributor.areaId),
            mobile: Value(distributor.mobile ?? ''),
            isActive: Value(distributor.isActive ? 1 : 0),
            createdAt: Value(distributor.createdAt.toIso8601String()),
            updatedAt: Value(DateTime.now().toIso8601String()),
          ),
        );
  }

  /// Soft delete (set is_active = 0)
  Future<void> deactivate(int id) async {
    await (db.update(db.distributors)..where((t) => t.id.equals(id))).write(
      DistributorsCompanion(
        isActive: const Value(0),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ),
    );
  }
}

// ============================================================================
// SALES PERSONNEL DAO
// ============================================================================

class SalesPersonnelDao {
  final DistributorsDb db;

  SalesPersonnelDao(this.db);

  SalesPersonnel _mapPersonnelEntity(SalesPersonnelEntity e) => SalesPersonnel(
    id: e.id,
    nameEn: e.nameEn,
    nameBn: e.nameBn,
    designation: e.designation,
    mobile: e.mobile,
    email: e.email,
    employeeId: e.employeeId,
    isActive: e.isActive == 1,
    createdAt: DateTime.tryParse(e.createdAt) ?? DateTime.now(),
    updatedAt: DateTime.tryParse(e.updatedAt) ?? DateTime.now(),
  );

  /// Get all active sales personnel with their areas
  Future<List<SalesPersonnelWithAreas>> getAllSalesPersonnel() async {
    final rows =
        await (db.select(db.salesPersonnel)
              ..where((t) => t.isActive.equals(1))
              ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
            .get();

    return _hydrateList(rows.map(_mapPersonnelEntity).toList());
  }

  /// Paginated, filtered query for Sales Personnel screen
  Future<List<SalesPersonnelWithAreas>> getFilteredSalesPersonnel({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final q = db.select(db.salesPersonnel);
    Expression<bool> predicate = db.salesPersonnel.isActive.equals(1);

    final trimmed = query?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        Expression<bool>? tokenPredicate;
        for (final token in tokens) {
          final pattern = '%$token%';
          final hasRegion = existsQuery(
            db.selectOnly(db.salesPersonnelRegions)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.regions,
                  db.regions.id.equalsExp(db.salesPersonnelRegions.regionId),
                ),
              ])
              ..where(
                db.salesPersonnelRegions.salesPersonnelId.equalsExp(
                      db.salesPersonnel.id,
                    ) &
                    (db.regions.nameEn.like(pattern) |
                        db.regions.nameBn.like(pattern)),
              ),
          );
          final hasArea = existsQuery(
            db.selectOnly(db.salesPersonnelAreas)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.areas,
                  db.areas.id.equalsExp(db.salesPersonnelAreas.areaId),
                ),
              ])
              ..where(
                db.salesPersonnelAreas.salesPersonnelId.equalsExp(
                      db.salesPersonnel.id,
                    ) &
                    (db.areas.nameEn.like(pattern) |
                        db.areas.nameBn.like(pattern)),
              ),
          );
          final hasBase = existsQuery(
            db.selectOnly(db.salesPersonnelBases)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.bases,
                  db.bases.id.equalsExp(db.salesPersonnelBases.baseId),
                ),
              ])
              ..where(
                db.salesPersonnelBases.salesPersonnelId.equalsExp(
                      db.salesPersonnel.id,
                    ) &
                    (db.bases.nameEn.like(pattern) |
                        db.bases.nameBn.like(pattern)),
              ),
          );
          final hasUpazila = existsQuery(
            db.selectOnly(db.salesPersonnelUpazilas)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.upazilas,
                  db.upazilas.id.equalsExp(db.salesPersonnelUpazilas.upazilaId),
                ),
              ])
              ..where(
                db.salesPersonnelUpazilas.salesPersonnelId.equalsExp(
                      db.salesPersonnel.id,
                    ) &
                    (db.upazilas.nameEn.like(pattern) |
                        db.upazilas.nameBn.like(pattern)),
              ),
          );

          final tokenMatch =
              db.salesPersonnel.nameEn.like(pattern) |
              db.salesPersonnel.nameBn.like(pattern) |
              db.salesPersonnel.designation.like(pattern) |
              db.salesPersonnel.mobile.like(pattern) |
              db.salesPersonnel.email.like(pattern) |
              db.salesPersonnel.employeeId.like(pattern) |
              hasRegion |
              hasArea |
              hasBase |
              hasUpazila;

          tokenPredicate = (tokenPredicate != null)
              ? (tokenPredicate & tokenMatch)
              : tokenMatch;
        }
        if (tokenPredicate != null) {
          predicate = predicate & tokenPredicate;
        }
      }
    }

    q.where((_) => predicate);

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final favExpr = CustomExpression<int>(
        'CASE WHEN "sales_personnel"."id" IN (${favoriteIds.join(",")}) THEN 0 ELSE 1 END',
      );
      q.orderBy([
        (t) => OrderingTerm.asc(favExpr),
        (t) => OrderingTerm.asc(t.nameEn),
      ]);
    } else {
      q.orderBy([(t) => OrderingTerm.asc(t.nameEn)]);
    }

    if (limit != null) {
      q.limit(limit, offset: offset ?? 0);
    }

    final rows = await q.get();
    var results = await _hydrateList(rows.map(_mapPersonnelEntity).toList());

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
    final row = await (db.select(
      db.salesPersonnel,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (row == null) return null;

    final personnel = _mapPersonnelEntity(row);
    final hydrated = await _hydrateList([personnel]);
    return hydrated.first;
  }

  /// Get all areas for a sales person (via junction table)
  Future<List<Area>> getAreasForSalesPersonnel(int salesPersonnelId) async {
    final q =
        db.select(db.areas).join([
            innerJoin(
              db.salesPersonnelAreas,
              db.salesPersonnelAreas.areaId.equalsExp(db.areas.id),
            ),
          ])
          ..where(
            db.salesPersonnelAreas.salesPersonnelId.equals(salesPersonnelId),
          )
          ..orderBy([OrderingTerm.asc(db.areas.nameEn)]);

    final rows = await q.get();
    return rows.map((r) {
      final a = r.readTable(db.areas);
      return Area(
        id: a.id,
        regionId: a.regionId,
        nameEn: a.nameEn,
        nameBn: a.nameBn,
      );
    }).toList();
  }

  /// Get all sales personnel covering a specific area
  Future<List<SalesPersonnelWithAreas>> getSalesPersonnelByArea(
    int areaId,
  ) async {
    final q =
        db.select(db.salesPersonnel).join([
            innerJoin(
              db.salesPersonnelAreas,
              db.salesPersonnelAreas.salesPersonnelId.equalsExp(
                db.salesPersonnel.id,
              ),
            ),
          ])
          ..where(
            db.salesPersonnelAreas.areaId.equals(areaId) &
                db.salesPersonnel.isActive.equals(1),
          )
          ..orderBy([OrderingTerm.asc(db.salesPersonnel.nameEn)]);

    final rows = await q.get();
    return _hydrateList(
      rows
          .map((r) => _mapPersonnelEntity(r.readTable(db.salesPersonnel)))
          .toList(),
    );
  }

  /// Full-text search on sales personnel
  Future<List<SalesPersonnelWithAreas>> searchSalesPersonnel(
    String query,
  ) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<SalesPersonnelWithAreas> results = [];
    final isReady = await isFtsReady(db.executor, 'sales_personnel_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        final ftsRows = await db
            .customSelect(
              'SELECT rowid FROM sales_personnel_fts WHERE sales_personnel_fts MATCH ?',
              variables: [Variable.withString(sanitized)],
            )
            .get();
        final ids = ftsRows.map((r) => r.read<int>('rowid')).toList();
        if (ids.isNotEmpty) {
          final rows = await (db.select(
            db.salesPersonnel,
          )..where((t) => t.id.isIn(ids) & t.isActive.equals(1))).get();
          final rowMap = {for (final r in rows) r.id: _mapPersonnelEntity(r)};
          final ordered = ids
              .map((id) => rowMap[id])
              .whereType<SalesPersonnel>()
              .toList();
          results = await _hydrateList(ordered);
        }
      } catch (_) {
        results = [];
      }
    }

    if (results.isEmpty) {
      final pattern = '%$trimmed%';
      final rows =
          await (db.select(db.salesPersonnel)
                ..where(
                  (t) =>
                      t.isActive.equals(1) &
                      (t.nameEn.like(pattern) |
                          t.nameBn.like(pattern) |
                          t.designation.like(pattern) |
                          t.mobile.like(pattern) |
                          t.email.like(pattern) |
                          t.employeeId.like(pattern)),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
              .get();
      results = await _hydrateList(rows.map(_mapPersonnelEntity).toList());
    }

    return results;
  }

  /// Helper to batch hydrate SalesPersonnel with full coverage details (regions, areas, bases, upazilas)
  Future<List<SalesPersonnelWithAreas>> _hydrateList(
    List<SalesPersonnel> personnelList,
  ) async {
    if (personnelList.isEmpty) return [];

    final ids = personnelList.map((p) => p.id).toList();

    const chunkSize = 500;
    final Map<int, List<Area>> areasByPersonnelId = {};
    final Map<int, List<Region>> regionsByPersonnelId = {};
    final Map<int, List<Base>> basesByPersonnelId = {};
    final Map<int, List<Upazila>> upazilasByPersonnelId = {};

    for (var i = 0; i < ids.length; i += chunkSize) {
      final end = (i + chunkSize > ids.length) ? ids.length : i + chunkSize;
      final chunk = ids.sublist(i, end);

      // 1. Fetch Areas
      final areaQ =
          db.select(db.areas).join([
              innerJoin(
                db.salesPersonnelAreas,
                db.salesPersonnelAreas.areaId.equalsExp(db.areas.id),
              ),
            ])
            ..where(db.salesPersonnelAreas.salesPersonnelId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.areas.nameEn)]);
      final areaRows = await areaQ.get();
      for (final row in areaRows) {
        final personnelId = row
            .readTable(db.salesPersonnelAreas)
            .salesPersonnelId;
        final a = row.readTable(db.areas);
        areasByPersonnelId
            .putIfAbsent(personnelId, () => [])
            .add(
              Area(
                id: a.id,
                regionId: a.regionId,
                nameEn: a.nameEn,
                nameBn: a.nameBn,
              ),
            );
      }

      // 2. Fetch Regions
      final regionQ =
          db.select(db.regions).join([
              innerJoin(
                db.salesPersonnelRegions,
                db.salesPersonnelRegions.regionId.equalsExp(db.regions.id),
              ),
            ])
            ..where(db.salesPersonnelRegions.salesPersonnelId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.regions.nameEn)]);
      final regionRows = await regionQ.get();
      for (final row in regionRows) {
        final personnelId = row
            .readTable(db.salesPersonnelRegions)
            .salesPersonnelId;
        final r = row.readTable(db.regions);
        regionsByPersonnelId
            .putIfAbsent(personnelId, () => [])
            .add(Region(id: r.id, nameEn: r.nameEn, nameBn: r.nameBn));
      }

      // 3. Fetch Bases
      final baseQ =
          db.select(db.bases).join([
              innerJoin(
                db.salesPersonnelBases,
                db.salesPersonnelBases.baseId.equalsExp(db.bases.id),
              ),
            ])
            ..where(db.salesPersonnelBases.salesPersonnelId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.bases.nameEn)]);
      final baseRows = await baseQ.get();
      for (final row in baseRows) {
        final personnelId = row
            .readTable(db.salesPersonnelBases)
            .salesPersonnelId;
        final b = row.readTable(db.bases);
        basesByPersonnelId
            .putIfAbsent(personnelId, () => [])
            .add(
              Base(
                id: b.id,
                areaId: b.areaId,
                nameEn: b.nameEn,
                nameBn: b.nameBn,
              ),
            );
      }

      // 4. Fetch Upazilas
      final upazilaQ =
          db.select(db.upazilas).join([
              innerJoin(
                db.salesPersonnelUpazilas,
                db.salesPersonnelUpazilas.upazilaId.equalsExp(db.upazilas.id),
              ),
            ])
            ..where(db.salesPersonnelUpazilas.salesPersonnelId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.upazilas.nameEn)]);
      final upazilaRows = await upazilaQ.get();
      for (final row in upazilaRows) {
        final personnelId = row
            .readTable(db.salesPersonnelUpazilas)
            .salesPersonnelId;
        final u = row.readTable(db.upazilas);
        upazilasByPersonnelId
            .putIfAbsent(personnelId, () => [])
            .add(
              Upazila(
                id: u.id,
                districtId: u.districtId,
                nameEn: u.nameEn,
                nameBn: u.nameBn,
              ),
            );
      }
    }

    return personnelList.map((personnel) {
      return SalesPersonnelWithAreas(
        personnel: personnel.copyWith(
          regionIds: (regionsByPersonnelId[personnel.id] ?? [])
              .map((r) => r.id)
              .toList(),
          areaIds: (areasByPersonnelId[personnel.id] ?? [])
              .map((a) => a.id)
              .toList(),
          baseIds: (basesByPersonnelId[personnel.id] ?? [])
              .map((b) => b.id)
              .toList(),
          upazilaIds: (upazilasByPersonnelId[personnel.id] ?? [])
              .map((u) => u.id)
              .toList(),
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
    await db
        .into(db.salesPersonnel)
        .insertOnConflictUpdate(
          SalesPersonnelCompanion(
            id: Value(personnel.id),
            nameEn: Value(personnel.nameEn),
            nameBn: Value(personnel.nameBn ?? ''),
            designation: Value(personnel.designation),
            mobile: Value(personnel.mobile ?? ''),
            email: Value(personnel.email),
            employeeId: Value(personnel.employeeId),
            isActive: Value(personnel.isActive ? 1 : 0),
            createdAt: Value(personnel.createdAt.toIso8601String()),
            updatedAt: Value(DateTime.now().toIso8601String()),
          ),
        );
  }

  /// Add or update area assignment for a sales person
  Future<void> assignArea(int salesPersonnelId, int areaId) async {
    await db
        .into(db.salesPersonnelAreas)
        .insertOnConflictUpdate(
          SalesPersonnelAreasCompanion(
            salesPersonnelId: Value(salesPersonnelId),
            areaId: Value(areaId),
          ),
        );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int salesPersonnelId, int areaId) async {
    await (db.delete(db.salesPersonnelAreas)..where(
          (t) =>
              t.salesPersonnelId.equals(salesPersonnelId) &
              t.areaId.equals(areaId),
        ))
        .go();
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await (db.update(db.salesPersonnel)..where((t) => t.id.equals(id))).write(
      SalesPersonnelCompanion(
        isActive: const Value(0),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ),
    );
  }
}

// ============================================================================
// VET DOCTOR DAO
// ============================================================================

class VetDoctorDao {
  final DistributorsDb db;

  VetDoctorDao(this.db);

  VetDoctor _mapDoctorEntity(VetDoctorEntity e) => VetDoctor(
    id: e.id,
    nameEn: e.nameEn,
    nameBn: e.nameBn,
    qualification: e.qualification,
    specialization: e.specialization,
    bvcRegistrationNo: e.bvcRegistrationNo,
    clinicOrHospitalNameEn: e.clinicOrHospitalNameEn,
    clinicOrHospitalNameBn: e.clinicOrHospitalNameBn,
    addressEn: e.addressEn,
    addressBn: e.addressBn,
    mobile: e.mobile,
    email: e.email,
    isActive: e.isActive == 1,
    createdAt: DateTime.tryParse(e.createdAt) ?? DateTime.now(),
    updatedAt: DateTime.tryParse(e.updatedAt) ?? DateTime.now(),
  );

  /// Get all active vet doctors with their areas
  Future<List<VetDoctorWithAreas>> getAllVetDoctors() async {
    final rows =
        await (db.select(db.vetDoctors)
              ..where((t) => t.isActive.equals(1))
              ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
            .get();

    return _hydrateList(rows.map(_mapDoctorEntity).toList());
  }

  /// Paginated, filtered query for Vet Doctors screen
  Future<List<VetDoctorWithAreas>> getFilteredVetDoctors({
    String? query,
    int? limit,
    int? offset,
    Set<int>? favoriteIds,
  }) async {
    final q = db.select(db.vetDoctors);
    Expression<bool> predicate = db.vetDoctors.isActive.equals(1);

    final trimmed = query?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      final tokens = trimmed
          .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      if (tokens.isNotEmpty) {
        Expression<bool>? tokenPredicate;
        for (final token in tokens) {
          final pattern = '%$token%';
          final hasRegion = existsQuery(
            db.selectOnly(db.vetDoctorsRegions)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.regions,
                  db.regions.id.equalsExp(db.vetDoctorsRegions.regionId),
                ),
              ])
              ..where(
                db.vetDoctorsRegions.vetDoctorId.equalsExp(db.vetDoctors.id) &
                    (db.regions.nameEn.like(pattern) |
                        db.regions.nameBn.like(pattern)),
              ),
          );
          final hasArea = existsQuery(
            db.selectOnly(db.vetDoctorsAreas)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.areas,
                  db.areas.id.equalsExp(db.vetDoctorsAreas.areaId),
                ),
              ])
              ..where(
                db.vetDoctorsAreas.vetDoctorId.equalsExp(db.vetDoctors.id) &
                    (db.areas.nameEn.like(pattern) |
                        db.areas.nameBn.like(pattern)),
              ),
          );
          final hasBase = existsQuery(
            db.selectOnly(db.vetDoctorsBases)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.bases,
                  db.bases.id.equalsExp(db.vetDoctorsBases.baseId),
                ),
              ])
              ..where(
                db.vetDoctorsBases.vetDoctorId.equalsExp(db.vetDoctors.id) &
                    (db.bases.nameEn.like(pattern) |
                        db.bases.nameBn.like(pattern)),
              ),
          );
          final hasUpazila = existsQuery(
            db.selectOnly(db.vetDoctorsUpazilas)
              ..addColumns([const Constant(1)])
              ..join([
                innerJoin(
                  db.upazilas,
                  db.upazilas.id.equalsExp(db.vetDoctorsUpazilas.upazilaId),
                ),
              ])
              ..where(
                db.vetDoctorsUpazilas.vetDoctorId.equalsExp(db.vetDoctors.id) &
                    (db.upazilas.nameEn.like(pattern) |
                        db.upazilas.nameBn.like(pattern)),
              ),
          );

          final tokenMatch =
              db.vetDoctors.nameEn.like(pattern) |
              db.vetDoctors.nameBn.like(pattern) |
              db.vetDoctors.qualification.like(pattern) |
              db.vetDoctors.specialization.like(pattern) |
              db.vetDoctors.bvcRegistrationNo.like(pattern) |
              db.vetDoctors.clinicOrHospitalNameEn.like(pattern) |
              db.vetDoctors.clinicOrHospitalNameBn.like(pattern) |
              db.vetDoctors.addressEn.like(pattern) |
              db.vetDoctors.addressBn.like(pattern) |
              db.vetDoctors.mobile.like(pattern) |
              db.vetDoctors.email.like(pattern) |
              hasRegion |
              hasArea |
              hasBase |
              hasUpazila;

          tokenPredicate = (tokenPredicate != null)
              ? (tokenPredicate & tokenMatch)
              : tokenMatch;
        }
        if (tokenPredicate != null) {
          predicate = predicate & tokenPredicate;
        }
      }
    }

    q.where((_) => predicate);

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      final favExpr = CustomExpression<int>(
        'CASE WHEN "vet_doctors"."id" IN (${favoriteIds.join(",")}) THEN 0 ELSE 1 END',
      );
      q.orderBy([
        (t) => OrderingTerm.asc(favExpr),
        (t) => OrderingTerm.asc(t.nameEn),
      ]);
    } else {
      q.orderBy([(t) => OrderingTerm.asc(t.nameEn)]);
    }

    if (limit != null) {
      q.limit(limit, offset: offset ?? 0);
    }

    final rows = await q.get();
    var results = await _hydrateList(rows.map(_mapDoctorEntity).toList());

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
    final row = await (db.select(
      db.vetDoctors,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (row == null) return null;

    final doctor = _mapDoctorEntity(row);
    final hydrated = await _hydrateList([doctor]);
    return hydrated.first;
  }

  /// Get all areas for a vet doctor (via junction table)
  Future<List<Area>> getAreasForVetDoctor(int vetDoctorId) async {
    final q =
        db.select(db.areas).join([
            innerJoin(
              db.vetDoctorsAreas,
              db.vetDoctorsAreas.areaId.equalsExp(db.areas.id),
            ),
          ])
          ..where(db.vetDoctorsAreas.vetDoctorId.equals(vetDoctorId))
          ..orderBy([OrderingTerm.asc(db.areas.nameEn)]);

    final rows = await q.get();
    return rows.map((r) {
      final a = r.readTable(db.areas);
      return Area(
        id: a.id,
        regionId: a.regionId,
        nameEn: a.nameEn,
        nameBn: a.nameBn,
      );
    }).toList();
  }

  /// Get all vet doctors in a specific area
  Future<List<VetDoctorWithAreas>> getVetDoctorsByArea(int areaId) async {
    final q =
        db.select(db.vetDoctors).join([
            innerJoin(
              db.vetDoctorsAreas,
              db.vetDoctorsAreas.vetDoctorId.equalsExp(db.vetDoctors.id),
            ),
          ])
          ..where(
            db.vetDoctorsAreas.areaId.equals(areaId) &
                db.vetDoctors.isActive.equals(1),
          )
          ..orderBy([OrderingTerm.asc(db.vetDoctors.nameEn)]);

    final rows = await q.get();
    return _hydrateList(
      rows.map((r) => _mapDoctorEntity(r.readTable(db.vetDoctors))).toList(),
    );
  }

  /// Full-text search on vet doctors
  Future<List<VetDoctorWithAreas>> searchVetDoctors(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final sanitized = sanitizeFtsQuery(query);
    List<VetDoctorWithAreas> results = [];
    final isReady = await isFtsReady(db.executor, 'vet_doctors_fts');
    if (isReady && sanitized.isNotEmpty) {
      try {
        final ftsRows = await db
            .customSelect(
              'SELECT rowid FROM vet_doctors_fts WHERE vet_doctors_fts MATCH ?',
              variables: [Variable.withString(sanitized)],
            )
            .get();
        final ids = ftsRows.map((r) => r.read<int>('rowid')).toList();
        if (ids.isNotEmpty) {
          final rows = await (db.select(
            db.vetDoctors,
          )..where((t) => t.id.isIn(ids) & t.isActive.equals(1))).get();
          final rowMap = {for (final r in rows) r.id: _mapDoctorEntity(r)};
          final ordered = ids
              .map((id) => rowMap[id])
              .whereType<VetDoctor>()
              .toList();
          results = await _hydrateList(ordered);
        }
      } catch (_) {
        results = [];
      }
    }

    if (results.isEmpty) {
      final pattern = '%$trimmed%';
      final rows =
          await (db.select(db.vetDoctors)
                ..where(
                  (t) =>
                      t.isActive.equals(1) &
                      (t.nameEn.like(pattern) |
                          t.nameBn.like(pattern) |
                          t.qualification.like(pattern) |
                          t.specialization.like(pattern) |
                          t.addressEn.like(pattern) |
                          t.mobile.like(pattern)),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
              .get();
      results = await _hydrateList(rows.map(_mapDoctorEntity).toList());
    }

    return results;
  }

  /// Helper to batch hydrate VetDoctors with full coverage details (regions, areas, bases, upazilas)
  Future<List<VetDoctorWithAreas>> _hydrateList(List<VetDoctor> doctors) async {
    if (doctors.isEmpty) return [];

    final ids = doctors.map((d) => d.id).toList();

    const chunkSize = 500;
    final Map<int, List<Area>> areasByDoctorId = {};
    final Map<int, List<Region>> regionsByDoctorId = {};
    final Map<int, List<Base>> basesByDoctorId = {};
    final Map<int, List<Upazila>> upazilasByDoctorId = {};

    for (var i = 0; i < ids.length; i += chunkSize) {
      final end = (i + chunkSize > ids.length) ? ids.length : i + chunkSize;
      final chunk = ids.sublist(i, end);

      // 1. Fetch Areas
      final areaQ =
          db.select(db.areas).join([
              innerJoin(
                db.vetDoctorsAreas,
                db.vetDoctorsAreas.areaId.equalsExp(db.areas.id),
              ),
            ])
            ..where(db.vetDoctorsAreas.vetDoctorId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.areas.nameEn)]);
      final areaRows = await areaQ.get();
      for (final row in areaRows) {
        final doctorId = row.readTable(db.vetDoctorsAreas).vetDoctorId;
        final a = row.readTable(db.areas);
        areasByDoctorId
            .putIfAbsent(doctorId, () => [])
            .add(
              Area(
                id: a.id,
                regionId: a.regionId,
                nameEn: a.nameEn,
                nameBn: a.nameBn,
              ),
            );
      }

      // 2. Fetch Regions
      final regionQ =
          db.select(db.regions).join([
              innerJoin(
                db.vetDoctorsRegions,
                db.vetDoctorsRegions.regionId.equalsExp(db.regions.id),
              ),
            ])
            ..where(db.vetDoctorsRegions.vetDoctorId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.regions.nameEn)]);
      final regionRows = await regionQ.get();
      for (final row in regionRows) {
        final doctorId = row.readTable(db.vetDoctorsRegions).vetDoctorId;
        final r = row.readTable(db.regions);
        regionsByDoctorId
            .putIfAbsent(doctorId, () => [])
            .add(Region(id: r.id, nameEn: r.nameEn, nameBn: r.nameBn));
      }

      // 3. Fetch Bases
      final baseQ =
          db.select(db.bases).join([
              innerJoin(
                db.vetDoctorsBases,
                db.vetDoctorsBases.baseId.equalsExp(db.bases.id),
              ),
            ])
            ..where(db.vetDoctorsBases.vetDoctorId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.bases.nameEn)]);
      final baseRows = await baseQ.get();
      for (final row in baseRows) {
        final doctorId = row.readTable(db.vetDoctorsBases).vetDoctorId;
        final b = row.readTable(db.bases);
        basesByDoctorId
            .putIfAbsent(doctorId, () => [])
            .add(
              Base(
                id: b.id,
                areaId: b.areaId,
                nameEn: b.nameEn,
                nameBn: b.nameBn,
              ),
            );
      }

      // 4. Fetch Upazilas
      final upazilaQ =
          db.select(db.upazilas).join([
              innerJoin(
                db.vetDoctorsUpazilas,
                db.vetDoctorsUpazilas.upazilaId.equalsExp(db.upazilas.id),
              ),
            ])
            ..where(db.vetDoctorsUpazilas.vetDoctorId.isIn(chunk))
            ..orderBy([OrderingTerm.asc(db.upazilas.nameEn)]);
      final upazilaRows = await upazilaQ.get();
      for (final row in upazilaRows) {
        final doctorId = row.readTable(db.vetDoctorsUpazilas).vetDoctorId;
        final u = row.readTable(db.upazilas);
        upazilasByDoctorId
            .putIfAbsent(doctorId, () => [])
            .add(
              Upazila(
                id: u.id,
                districtId: u.districtId,
                nameEn: u.nameEn,
                nameBn: u.nameBn,
              ),
            );
      }
    }

    return doctors.map((doctor) {
      return VetDoctorWithAreas(
        doctor: doctor.copyWith(
          regionIds: (regionsByDoctorId[doctor.id] ?? [])
              .map((r) => r.id)
              .toList(),
          areaIds: (areasByDoctorId[doctor.id] ?? []).map((a) => a.id).toList(),
          baseIds: (basesByDoctorId[doctor.id] ?? []).map((b) => b.id).toList(),
          upazilaIds: (upazilasByDoctorId[doctor.id] ?? [])
              .map((u) => u.id)
              .toList(),
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
    await db
        .into(db.vetDoctors)
        .insertOnConflictUpdate(
          VetDoctorsCompanion(
            id: Value(doctor.id),
            nameEn: Value(doctor.nameEn),
            nameBn: Value(doctor.nameBn ?? ''),
            qualification: Value(doctor.qualification),
            specialization: Value(doctor.specialization),
            bvcRegistrationNo: Value(doctor.bvcRegistrationNo),
            clinicOrHospitalNameEn: Value(doctor.clinicOrHospitalNameEn),
            clinicOrHospitalNameBn: Value(doctor.clinicOrHospitalNameBn),
            addressEn: Value(doctor.addressEn),
            addressBn: Value(doctor.addressBn),
            mobile: Value(doctor.mobile ?? ''),
            email: Value(doctor.email),
            isActive: Value(doctor.isActive ? 1 : 0),
            createdAt: Value(doctor.createdAt.toIso8601String()),
            updatedAt: Value(DateTime.now().toIso8601String()),
          ),
        );
  }

  /// Add or update area assignment for a vet doctor
  Future<void> assignArea(int vetDoctorId, int areaId) async {
    await db
        .into(db.vetDoctorsAreas)
        .insertOnConflictUpdate(
          VetDoctorsAreasCompanion(
            vetDoctorId: Value(vetDoctorId),
            areaId: Value(areaId),
          ),
        );
  }

  /// Remove area assignment
  Future<void> removeAreaAssignment(int vetDoctorId, int areaId) async {
    await (db.delete(db.vetDoctorsAreas)..where(
          (t) => t.vetDoctorId.equals(vetDoctorId) & t.areaId.equals(areaId),
        ))
        .go();
  }

  /// Soft delete
  Future<void> deactivate(int id) async {
    await (db.update(db.vetDoctors)..where((t) => t.id.equals(id))).write(
      VetDoctorsCompanion(
        isActive: const Value(0),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ),
    );
  }
}

// ============================================================================
// LOCATION DAO (regions, areas, bases, divisions, districts, upazilas)
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
    final rows = await (db.select(
      db.regions,
    )..orderBy([(t) => OrderingTerm.asc(t.nameEn)])).get();
    _cachedRegions = rows
        .map((e) => Region(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn))
        .toList();
    return _cachedRegions!;
  }

  /// Get all areas (cached in memory, optionally filtered by region)
  Future<List<Area>> getAllAreas({int? regionId}) async {
    if (_cachedAreas == null) {
      final rows = await (db.select(
        db.areas,
      )..orderBy([(t) => OrderingTerm.asc(t.nameEn)])).get();
      _cachedAreas = rows
          .map(
            (e) => Area(
              id: e.id,
              regionId: e.regionId,
              nameEn: e.nameEn,
              nameBn: e.nameBn,
            ),
          )
          .toList();
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
    final row = await (db.select(
      db.areas,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null
        ? null
        : Area(
            id: row.id,
            regionId: row.regionId,
            nameEn: row.nameEn,
            nameBn: row.nameBn,
          );
  }

  /// Get region by ID
  Future<Region?> getRegionById(int id) async {
    if (_cachedRegions != null) {
      for (final region in _cachedRegions!) {
        if (region.id == id) return region;
      }
      return null;
    }
    final row = await (db.select(
      db.regions,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null
        ? null
        : Region(id: row.id, nameEn: row.nameEn, nameBn: row.nameBn);
  }

  /// Get all bases (optionally filtered by area)
  Future<List<Base>> getAllBases({int? areaId}) async {
    final statement = db.select(db.bases);
    if (areaId != null) {
      statement.where((t) => t.areaId.equals(areaId));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.nameEn)]);
    final rows = await statement.get();
    return rows
        .map(
          (e) => Base(
            id: e.id,
            areaId: e.areaId,
            nameEn: e.nameEn,
            nameBn: e.nameBn,
          ),
        )
        .toList();
  }

  /// Get base by ID
  Future<Base?> getBaseById(int id) async {
    final row = await (db.select(
      db.bases,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null
        ? null
        : Base(
            id: row.id,
            areaId: row.areaId,
            nameEn: row.nameEn,
            nameBn: row.nameBn,
          );
  }

  /// Get upazilas covered by a specific base
  Future<List<Upazila>> getUpazilasForBase(int baseId) async {
    final q =
        db.select(db.upazilas).join([
            innerJoin(
              db.baseUpazilas,
              db.baseUpazilas.upazilaId.equalsExp(db.upazilas.id),
            ),
          ])
          ..where(db.baseUpazilas.baseId.equals(baseId))
          ..orderBy([OrderingTerm.asc(db.upazilas.nameEn)]);

    final rows = await q.get();
    return rows.map((r) {
      final u = r.readTable(db.upazilas);
      return Upazila(
        id: u.id,
        districtId: u.districtId,
        nameEn: u.nameEn,
        nameBn: u.nameBn,
      );
    }).toList();
  }

  /// Get all bases hydrated with Area, Region, and covered Upazilas
  Future<List<BaseWithUpazilas>> getAllBasesWithUpazilas() async {
    final q =
        db.select(db.bases).join([
          innerJoin(db.areas, db.areas.id.equalsExp(db.bases.areaId)),
          innerJoin(db.regions, db.regions.id.equalsExp(db.areas.regionId)),
        ])..orderBy([
          OrderingTerm.asc(db.regions.nameEn),
          OrderingTerm.asc(db.areas.nameEn),
          OrderingTerm.asc(db.bases.nameEn),
        ]);

    final rows = await q.get();
    if (rows.isEmpty) return [];

    final baseIds = rows.map((r) => r.readTable(db.bases).id).toList();

    final upazilaQ =
        db.select(db.upazilas).join([
            innerJoin(
              db.baseUpazilas,
              db.baseUpazilas.upazilaId.equalsExp(db.upazilas.id),
            ),
          ])
          ..where(db.baseUpazilas.baseId.isIn(baseIds))
          ..orderBy([OrderingTerm.asc(db.upazilas.nameEn)]);

    final upazilaRows = await upazilaQ.get();

    final Map<int, List<Upazila>> upazilasByBaseId = {};
    for (final r in upazilaRows) {
      final bId = r.readTable(db.baseUpazilas).baseId;
      final u = r.readTable(db.upazilas);
      upazilasByBaseId
          .putIfAbsent(bId, () => [])
          .add(
            Upazila(
              id: u.id,
              districtId: u.districtId,
              nameEn: u.nameEn,
              nameBn: u.nameBn,
            ),
          );
    }

    return rows.map((row) {
      final b = row.readTable(db.bases);
      final a = row.readTable(db.areas);
      final reg = row.readTable(db.regions);

      final base = Base(
        id: b.id,
        areaId: b.areaId,
        nameEn: b.nameEn,
        nameBn: b.nameBn,
        upazilaIds: (upazilasByBaseId[b.id] ?? []).map((u) => u.id).toList(),
      );
      final area = Area(
        id: a.id,
        regionId: a.regionId,
        nameEn: a.nameEn,
        nameBn: a.nameBn,
      );
      final region = Region(id: reg.id, nameEn: reg.nameEn, nameBn: reg.nameBn);
      return BaseWithUpazilas(
        base: base,
        area: area,
        region: region,
        upazilas: upazilasByBaseId[b.id] ?? [],
      );
    }).toList();
  }

  /// Get all divisions
  Future<List<Division>> getAllDivisions() async {
    final rows = await (db.select(
      db.divisions,
    )..orderBy([(t) => OrderingTerm.asc(t.nameEn)])).get();
    return rows
        .map((e) => Division(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn))
        .toList();
  }

  /// Get all districts (optionally filtered by division)
  Future<List<District>> getAllDistricts({int? divisionId}) async {
    final statement = db.select(db.districts);
    if (divisionId != null) {
      statement.where((t) => t.divisionId.equals(divisionId));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.nameEn)]);
    final rows = await statement.get();
    return rows
        .map(
          (e) => District(
            id: e.id,
            divisionId: e.divisionId,
            nameEn: e.nameEn,
            nameBn: e.nameBn,
          ),
        )
        .toList();
  }

  /// Get all upazilas (optionally filtered by district)
  Future<List<Upazila>> getAllUpazilas({int? districtId}) async {
    final statement = db.select(db.upazilas);
    if (districtId != null) {
      statement.where((t) => t.districtId.equals(districtId));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.nameEn)]);
    final rows = await statement.get();
    return rows
        .map(
          (e) => Upazila(
            id: e.id,
            districtId: e.districtId,
            nameEn: e.nameEn,
            nameBn: e.nameBn,
          ),
        )
        .toList();
  }

  /// Insert or update base and set its covered upazilas
  Future<void> upsertBase(Base base, {List<int>? upazilaIds}) async {
    await db
        .into(db.bases)
        .insertOnConflictUpdate(
          BasesCompanion(
            id: Value(base.id),
            areaId: Value(base.areaId),
            nameEn: Value(base.nameEn),
            nameBn: Value(base.nameBn ?? ''),
          ),
        );

    if (upazilaIds != null) {
      await (db.delete(
        db.baseUpazilas,
      )..where((t) => t.baseId.equals(base.id))).go();
      for (final uId in upazilaIds) {
        await assignUpazilaToBase(base.id, uId);
      }
    }
  }

  /// Assign an upazila to a base
  Future<void> assignUpazilaToBase(int baseId, int upazilaId) async {
    await db
        .into(db.baseUpazilas)
        .insertOnConflictUpdate(
          BaseUpazilasCompanion(
            baseId: Value(baseId),
            upazilaId: Value(upazilaId),
          ),
        );
  }

  /// Remove upazila assignment from base
  Future<void> removeUpazilaFromBase(int baseId, int upazilaId) async {
    await (db.delete(db.baseUpazilas)..where(
          (t) => t.baseId.equals(baseId) & t.upazilaId.equals(upazilaId),
        ))
        .go();
  }

  /// Delete base
  Future<void> deleteBase(int id) async {
    await (db.delete(db.bases)..where((t) => t.id.equals(id))).go();
  }
}
