import 'dart:async';
import 'package:impulse_dex/models/distributor.dart';
import 'package:impulse_dex/providers/database_provider.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:impulse_dex/data/distributor_dao.dart';
import 'package:impulse_dex/providers/paginated_state.dart';
import 'package:impulse_dex/providers/debounced_query.dart';

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
class PaginatedDistributors extends _$PaginatedDistributors {
  static const int _pageSize = 20;

  @override
  Future<PaginatedState<DistributorWithLocation>> build() async {
    final dao = await ref.watch(distributorDaoProvider.future);
    final query = ref.watch(distributorSearchQueryProvider);
    final favs = await ref.watch(distributorFavoritesProvider.future);
    
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
    final dao = await ref.watch(vetDoctorDaoProvider.future);
    final query = ref.watch(vetDoctorsSearchQueryProvider);
    final favs = await ref.watch(vetDoctorFavoritesProvider.future);
    
    final items = await dao.getFilteredVetDoctors(
      query: query,
      limit: _pageSize,
      offset: 0,
      favoriteIds: favs.toSet(),
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
    final dao = await ref.watch(salesPersonnelDaoProvider.future);
    final query = ref.watch(salesPersonnelSearchQueryProvider);
    final favs = await ref.watch(salesPersonnelFavoritesProvider.future);
    
    final items = await dao.getFilteredSalesPersonnel(
      query: query,
      limit: _pageSize,
      offset: 0,
      favoriteIds: favs.toSet(),
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
