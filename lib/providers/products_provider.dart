import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/data/product_dao.dart';
import 'package:impulse_dex/data/lookup_dao.dart';
import 'package:impulse_dex/data/manufacturer_dao.dart';
import 'package:impulse_dex/providers/database_provider.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/paginated_state.dart';
import 'package:impulse_dex/providers/debounced_query.dart';
import 'package:impulse_dex/domain/category_filter.dart';

part 'products_provider.g.dart';

// ------------------------------------------------------------
// DAO providers — wrap the raw sqflite Database from
// database_provider.dart with the typed DAO layer so the rest of this
// file (and the UI) never writes raw SQL directly.
// ------------------------------------------------------------

@Riverpod(keepAlive: true)
Future<ProductDao> productDao(Ref ref) async {
  final dbWrapper = await ref.watch(productsDatabaseProvider.future);
  final lookupDao = await ref.watch(lookupDaoProvider.future);
  return ProductDao(dbWrapper.executor, lookupDao);
}

@Riverpod(keepAlive: true)
Future<ManufacturerDao> manufacturerDao(Ref ref) async {
  final db = await ref.watch(productsDatabaseProvider.future);
  return ManufacturerDao(db.executor);
}

@Riverpod(keepAlive: true)
Future<LookupDao> lookupDao(Ref ref) async {
  final db = await ref.watch(productsDatabaseProvider.future);
  return LookupDao(db.executor);
}

// ------------------------------------------------------------
// UI state
// ------------------------------------------------------------

@riverpod
class ProductSearchQuery extends _$ProductSearchQuery with DebouncedQuery {
  @override
  String build() {
    ref.onDispose(cancelDebounce);
    return '';
  }

  void updateQuery(String query) {
    debouncedUpdate(query, (val) => state = val);
  }
}

// Removed ProductCategoryTab

// ------------------------------------------------------------
// Lookup tables — needed now that products.category and
// directions.species etc. are no longer free text; the UI resolves
// *_id -> display name against these.
// ------------------------------------------------------------

@riverpod
Future<List<Category>> categories(Ref ref) async {
  final dao = await ref.watch(lookupDaoProvider.future);
  return dao.getCategories();
}

@riverpod
Future<List<TargetGroup>> targetGroups(Ref ref) async {
  final dao = await ref.watch(lookupDaoProvider.future);
  return dao.getTargetGroups();
}

@riverpod
Future<List<Species>> species(Ref ref) async {
  final dao = await ref.watch(lookupDaoProvider.future);
  return dao.getSpecies();
}

@riverpod
Future<List<Manufacturer>> manufacturers(Ref ref) async {
  final dao = await ref.watch(manufacturerDaoProvider.future);
  return dao.getAll();
}

@riverpod
class ManufacturersSearchQuery extends _$ManufacturersSearchQuery with DebouncedQuery {
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
class PaginatedManufacturers extends _$PaginatedManufacturers {
  static const int _pageSize = 20;

  @override
  Future<PaginatedState<Manufacturer>> build() async {
    final dao = await ref.watch(manufacturerDaoProvider.future);
    final query = ref.watch(manufacturersSearchQueryProvider);
    
    final items = await dao.getFilteredManufacturers(
      query: query,
      limit: _pageSize + 1,
      offset: 0,
    );

    final hasMore = items.length > _pageSize;
    if (hasMore) {
      items.removeLast();
    }

    return PaginatedState<Manufacturer>(
      items: items,
      hasMore: hasMore,
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final dao = await ref.read(manufacturerDaoProvider.future);
    final query = ref.read(manufacturersSearchQueryProvider);

    final nextChunk = await dao.getFilteredManufacturers(
      query: query,
      limit: _pageSize + 1,
      offset: currentState.items.length,
    );

    final hasMore = nextChunk.length > _pageSize;
    if (hasMore) {
      nextChunk.removeLast();
    }

    final newItems = [...currentState.items, ...nextChunk];

    state = AsyncValue.data(
      PaginatedState<Manufacturer>(
        items: newItems,
        hasMore: hasMore,
        isLoadingMore: false,
      ),
    );
  }
}

// ------------------------------------------------------------
// Products
// ------------------------------------------------------------

/// Lightweight ProductLabel list for grids/tabs (no compositions/indications/
/// directions/precautions attached — see productDetail for the full
/// hydrated product). Active products only by default.
@riverpod
Future<List<ProductLabel>> products(Ref ref) async {
  final dao = await ref.watch(productDaoProvider.future);
  return dao.getAllLabels(activeOnly: true);
}

// CategoryFilterCriteria moved to domain layer

/// Fully hydrated product for the Product Detail Page: compositions,
/// indications, directions, precautions, presentations, target groups and
/// manufacturer are all loaded.
@riverpod
Future<Product> productDetail(Ref ref, int productId) async {
  final dao = await ref.watch(productDaoProvider.future);
  final product = await dao.getById(productId);
  if (product == null) {
    throw Exception('Product not found');
  }
  return product;
}

@riverpod
class PaginatedCategoryProducts extends _$PaginatedCategoryProducts {
  static const int _pageSize = 20;
  CategoryFilterCriteria? _criteria;

  @override
  Future<PaginatedState<ProductLabel>> build(String category) async {
    final dao = await ref.watch(productDaoProvider.future);
    final cats = await ref.watch(categoriesProvider.future);
    final groups = await ref.watch(targetGroupsProvider.future);
    _criteria = resolveCategoryFilter(category, cats, groups);
    final criteria = _criteria!;
    final query = ref.watch(productSearchQueryProvider);
    
    final initialItems = await dao.getFilteredLabels(
      categoryId: criteria.categoryId,
      targetGroupId: criteria.targetGroupId,
      isFeedAdditive: criteria.isFeedAdditive,
      query: query,
      limit: _pageSize + 1,
      offset: 0,
    );

    final hasMore = initialItems.length > _pageSize;
    if (hasMore) {
      initialItems.removeLast();
    }

    return PaginatedState<ProductLabel>(
      items: initialItems,
      hasMore: hasMore,
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final dao = await ref.read(productDaoProvider.future);
    final cats = await ref.read(categoriesProvider.future);
    final groups = await ref.read(targetGroupsProvider.future);
    final criteria = _criteria ?? resolveCategoryFilter(category, cats, groups);
    final query = ref.read(productSearchQueryProvider);

    final nextChunk = await dao.getFilteredLabels(
      categoryId: criteria.categoryId,
      targetGroupId: criteria.targetGroupId,
      isFeedAdditive: criteria.isFeedAdditive,
      query: query,
      limit: _pageSize + 1,
      offset: currentState.items.length,
    );

    final hasMore = nextChunk.length > _pageSize;
    if (hasMore) {
      nextChunk.removeLast();
    }

    final newItems = [...currentState.items, ...nextChunk];

    state = AsyncValue.data(
      PaginatedState<ProductLabel>(
        items: newItems,
        hasMore: hasMore,
        isLoadingMore: false,
      ),
    );
  }
}

/// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
/// now a standalone entity, so this is a single WHERE manufacturer_id = ?
/// query instead of fuzzy-matching a duplicated manufacturer name.
@riverpod
Future<List<Product>> productsByManufacturer(
  Ref ref,
  int manufacturerId,
) async {
  final dao = await ref.watch(productDaoProvider.future);
  return dao.getByManufacturer(manufacturerId);
}

// Removed dead bulkProviders

@Riverpod(keepAlive: true)
class FavoriteToggle extends _$FavoriteToggle {
  @override
  void build() {}

  Future<void> toggle(FavoriteType type, int refId) async {
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await dao.toggleFavorite(type, refId);

    switch (type) {
      case FavoriteType.product:
        ref.invalidate(productFavoritesProvider);
        break;
      case FavoriteType.distributor:
        ref.invalidate(distributorFavoritesProvider);
        break;
      case FavoriteType.salesPersonnel:
        ref.invalidate(salesPersonnelFavoritesProvider);
        break;
      case FavoriteType.vetDoctor:
        ref.invalidate(vetDoctorFavoritesProvider);
        break;
    }
  }
}

// Removed _firstWhereOrNull
