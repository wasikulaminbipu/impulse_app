import 'dart:async';
import 'package:impulse_app/models/distributor.dart';
import 'package:impulse_app/providers/database_provider.dart';

import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:impulse_app/data/distributor_dao.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/debounced_query.dart';
import 'package:impulse_app/data/fts_utils.dart';
import 'package:impulse_app/utils/search_analytics.dart';

part 'stakeholder_provider.g.dart';

@Riverpod(keepAlive: true)
Future<DistributorDao> distributorDao(Ref ref) async {
  final dbWrapper = await ref.watch(distributorsDatabaseProvider.future);
  return DistributorDao(dbWrapper);
}

@Riverpod(keepAlive: true)
Future<VetDoctorDao> vetDoctorDao(Ref ref) async {
  final dbWrapper = await ref.watch(distributorsDatabaseProvider.future);
  return VetDoctorDao(dbWrapper);
}

@Riverpod(keepAlive: true)
Future<SalesPersonnelDao> salesPersonnelDao(Ref ref) async {
  final dbWrapper = await ref.watch(distributorsDatabaseProvider.future);
  return SalesPersonnelDao(dbWrapper);
}

@Riverpod(keepAlive: true)
Future<LocationDao> locationDao(Ref ref) async {
  final dbWrapper = await ref.watch(distributorsDatabaseProvider.future);
  return LocationDao(dbWrapper);
}

@riverpod
Future<List<BaseWithUpazilas>> basesWithUpazilas(Ref ref) async {
  final dao = await ref.watch(locationDaoProvider.future);
  return dao.getAllBasesWithUpazilas();
}

@riverpod
Future<List<Upazila>> upazilasList(Ref ref, {int? districtId}) async {
  final dao = await ref.watch(locationDaoProvider.future);
  return dao.getAllUpazilas(districtId: districtId);
}

@riverpod
class DistributorSearchQuery extends _$DistributorSearchQuery with DebouncedQuery {
  @override
  String build() {
    ref.onDispose(cancelDebounce);
    return '';
  }

  void updateQuery(String query) {
    debouncedUpdate(query, (val) => state = val);
  }
}

@riverpod
class SelectedContactRegionFilter extends _$SelectedContactRegionFilter {
  @override
  String? build() => null;

  void selectRegion(String? region) {
    state = region;
  }
}

@riverpod
class SelectedContactAreaFilter extends _$SelectedContactAreaFilter {
  @override
  String? build() => null;

  void selectArea(String? area) {
    state = area;
  }
}

@riverpod
class PaginatedDistributors extends _$PaginatedDistributors {
  static const int _pageSize = 20;

  @override
  Future<PaginatedState<DistributorWithLocation>> build() async {
    final dao = await ref.watch(distributorDaoProvider.future);
    final query = ref.watch(distributorSearchQueryProvider);
    final favs = await ref.read(distributorFavoritesProvider.future);
    
    final items = await dao.getFilteredDistributors(
      query: query,
      limit: _pageSize,
      offset: 0,
      favoriteIds: favs.toSet(),
    );
    
    return PaginatedState<DistributorWithLocation>(
      items: items,
      hasMore: items.length == _pageSize,
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final dao = await ref.read(distributorDaoProvider.future);
    final query = ref.read(distributorSearchQueryProvider);
    final favs = await ref.read(distributorFavoritesProvider.future);
    
    final nextChunk = await dao.getFilteredDistributors(
      query: query,
      limit: _pageSize,
      offset: currentState.items.length,
      favoriteIds: favs.toSet(),
    );
    
    final newItems = [...currentState.items, ...nextChunk];

    state = AsyncValue.data(
      PaginatedState<DistributorWithLocation>(
        items: newItems,
        hasMore: nextChunk.length == _pageSize,
        isLoadingMore: false,
      ),
    );
  }
}

@riverpod
class PaginatedVetDoctors extends _$PaginatedVetDoctors {
  static const int _pageSize = 20;

  @override
  Future<PaginatedState<VetDoctorWithAreas>> build() async {
    final stopwatch = Stopwatch()..start();
    final dao = await ref.watch(vetDoctorDaoProvider.future);
    final textQuery = ref.watch(vetDoctorsSearchQueryProvider);
    final regionFilter = ref.watch(selectedContactRegionFilterProvider);
    final areaFilter = ref.watch(selectedContactAreaFilterProvider);
    final favs = await ref.read(vetDoctorFavoritesProvider.future);
    
    final combinedTokens = [
      if (textQuery.trim().isNotEmpty) textQuery.trim(),
      if (regionFilter != null && regionFilter.isNotEmpty) regionFilter,
      if (areaFilter != null && areaFilter.isNotEmpty) areaFilter,
    ];
    final effectiveQuery = combinedTokens.join(' ');

    final items = await dao.getFilteredVetDoctors(
      query: effectiveQuery,
      limit: _pageSize,
      offset: 0,
      favoriteIds: favs.toSet(),
    );

    stopwatch.stop();
    SearchAnalyticsTracker.logSearch(
      query: effectiveQuery.isEmpty ? '[All Veterinarians]' : effectiveQuery,
      resultCount: items.length,
      executionTimeMs: stopwatch.elapsedMilliseconds,
      categoryOrScope: 'Veterinarians',
    );
    
    return PaginatedState<VetDoctorWithAreas>(
      items: items,
      hasMore: items.length == _pageSize,
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final dao = await ref.read(vetDoctorDaoProvider.future);
    final query = ref.read(vetDoctorsSearchQueryProvider);
    final favs = await ref.read(vetDoctorFavoritesProvider.future);
    
    final nextChunk = await dao.getFilteredVetDoctors(
      query: query,
      limit: _pageSize,
      offset: currentState.items.length,
      favoriteIds: favs.toSet(),
    );
    
    final newItems = [...currentState.items, ...nextChunk];

    state = AsyncValue.data(
      PaginatedState<VetDoctorWithAreas>(
        items: newItems,
        hasMore: nextChunk.length == _pageSize,
        isLoadingMore: false,
      ),
    );
  }
}

@riverpod
class VetDoctorsSearchQuery extends _$VetDoctorsSearchQuery with DebouncedQuery {
  @override
  String build() {
    ref.onDispose(cancelDebounce);
    return '';
  }

  void updateQuery(String query) {
    debouncedUpdate(query, (val) => state = val);
  }
}

@riverpod
class PaginatedSalesPersonnel extends _$PaginatedSalesPersonnel {
  static const int _pageSize = 20;

  @override
  Future<PaginatedState<SalesPersonnelWithAreas>> build() async {
    final stopwatch = Stopwatch()..start();
    final dao = await ref.watch(salesPersonnelDaoProvider.future);
    final textQuery = ref.watch(salesPersonnelSearchQueryProvider);
    final regionFilter = ref.watch(selectedContactRegionFilterProvider);
    final areaFilter = ref.watch(selectedContactAreaFilterProvider);
    final favs = await ref.read(salesPersonnelFavoritesProvider.future);

    final combinedTokens = [
      if (textQuery.trim().isNotEmpty) textQuery.trim(),
      if (regionFilter != null && regionFilter.isNotEmpty) regionFilter,
      if (areaFilter != null && areaFilter.isNotEmpty) areaFilter,
    ];
    final effectiveQuery = combinedTokens.join(' ');
    
    final items = await dao.getFilteredSalesPersonnel(
      query: effectiveQuery,
      limit: _pageSize,
      offset: 0,
      favoriteIds: favs.toSet(),
    );

    stopwatch.stop();
    SearchAnalyticsTracker.logSearch(
      query: effectiveQuery.isEmpty ? '[All Representatives]' : effectiveQuery,
      resultCount: items.length,
      executionTimeMs: stopwatch.elapsedMilliseconds,
      categoryOrScope: 'Representatives',
    );
    
    return PaginatedState<SalesPersonnelWithAreas>(
      items: items,
      hasMore: items.length == _pageSize,
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final dao = await ref.read(salesPersonnelDaoProvider.future);
    final query = ref.read(salesPersonnelSearchQueryProvider);
    final favs = await ref.read(salesPersonnelFavoritesProvider.future);
    
    final nextChunk = await dao.getFilteredSalesPersonnel(
      query: query,
      limit: _pageSize,
      offset: currentState.items.length,
      favoriteIds: favs.toSet(),
    );
    
    final newItems = [...currentState.items, ...nextChunk];

    state = AsyncValue.data(
      PaginatedState<SalesPersonnelWithAreas>(
        items: newItems,
        hasMore: nextChunk.length == _pageSize,
        isLoadingMore: false,
      ),
    );
  }
}

@riverpod
class SalesPersonnelSearchQuery extends _$SalesPersonnelSearchQuery with DebouncedQuery {
  @override
  String build() {
    ref.onDispose(cancelDebounce);
    return '';
  }

  void updateQuery(String query) {
    debouncedUpdate(query, (val) => state = val);
  }
}

@riverpod
Future<AutocompleteTrie> salesPersonnelSearchTrie(Ref ref) async {
  final dao = await ref.watch(salesPersonnelDaoProvider.future);
  final allPersonnel = await dao.getAllSalesPersonnel();
  final trie = AutocompleteTrie();

  for (final p in allPersonnel) {
    trie.insert(p.personnel.nameEn);
    if (p.personnel.nameBn != null) trie.insert(p.personnel.nameBn!);
    if (p.personnel.designation != null) trie.insert(p.personnel.designation!);
    if (p.personnel.employeeId != null) trie.insert(p.personnel.employeeId!);

    for (final r in p.regions) {
      trie.insert(r.nameEn);
      if (r.nameBn != null) trie.insert(r.nameBn!);
    }
    for (final a in p.areas) {
      trie.insert(a.nameEn);
      if (a.nameBn != null) trie.insert(a.nameBn!);
    }
    for (final b in p.bases) {
      trie.insert(b.nameEn);
      if (b.nameBn != null) trie.insert(b.nameBn!);
    }
    for (final u in p.upazilas) {
      trie.insert(u.nameEn);
      if (u.nameBn != null) trie.insert(u.nameBn!);
    }
  }

  return trie;
}

@riverpod
Future<List<String>> salesPersonnelSearchTrieSuggestions(Ref ref) async {
  final query = ref.watch(salesPersonnelSearchQueryProvider);
  if (query.trim().isEmpty) return const [];
  final trie = await ref.watch(salesPersonnelSearchTrieProvider.future);
  return trie.getSuggestions(query, maxResults: 8);
}

@riverpod
Future<AutocompleteTrie> vetDoctorSearchTrie(Ref ref) async {
  final dao = await ref.watch(vetDoctorDaoProvider.future);
  final allDoctors = await dao.getAllVetDoctors();
  final trie = AutocompleteTrie();

  for (final d in allDoctors) {
    trie.insert(d.doctor.nameEn);
    if (d.doctor.nameBn != null) trie.insert(d.doctor.nameBn!);
    if (d.doctor.qualification != null) trie.insert(d.doctor.qualification!);
    if (d.doctor.specialization != null) trie.insert(d.doctor.specialization!);
    if (d.doctor.clinicOrHospitalNameEn != null) trie.insert(d.doctor.clinicOrHospitalNameEn!);
    if (d.doctor.clinicOrHospitalNameBn != null) trie.insert(d.doctor.clinicOrHospitalNameBn!);

    for (final r in d.regions) {
      trie.insert(r.nameEn);
      if (r.nameBn != null) trie.insert(r.nameBn!);
    }
    for (final a in d.areas) {
      trie.insert(a.nameEn);
      if (a.nameBn != null) trie.insert(a.nameBn!);
    }
    for (final b in d.bases) {
      trie.insert(b.nameEn);
      if (b.nameBn != null) trie.insert(b.nameBn!);
    }
    for (final u in d.upazilas) {
      trie.insert(u.nameEn);
      if (u.nameBn != null) trie.insert(u.nameBn!);
    }
  }

  return trie;
}

@riverpod
Future<List<String>> vetDoctorSearchTrieSuggestions(Ref ref) async {
  final query = ref.watch(vetDoctorsSearchQueryProvider);
  if (query.trim().isEmpty) return const [];
  final trie = await ref.watch(vetDoctorSearchTrieProvider.future);
  return trie.getSuggestions(query, maxResults: 8);
}

