import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/data/product_dao.dart';
import 'package:impulse_dex/data/lookup_dao.dart';
import 'package:impulse_dex/data/manufacturer_dao.dart';
import 'package:impulse_dex/data/fts_utils.dart';
import 'package:impulse_dex/providers/database_provider.dart';

import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/paginated_state.dart';
import 'package:impulse_dex/providers/debounced_query.dart';
import 'package:impulse_dex/domain/category_filter.dart';
import 'package:impulse_dex/domain/search_scope.dart';
import 'package:impulse_dex/utils/app_constants.dart';
import 'package:impulse_dex/utils/search_analytics.dart';

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
  return ProductDao(dbWrapper, lookupDao);
}

@Riverpod(keepAlive: true)
Future<ManufacturerDao> manufacturerDao(Ref ref) async {
  final db = await ref.watch(productsDatabaseProvider.future);
  return ManufacturerDao(db);
}

@Riverpod(keepAlive: true)
Future<LookupDao> lookupDao(Ref ref) async {
  final db = await ref.watch(productsDatabaseProvider.future);
  final dao = LookupDao(db);
  await dao.preloadAll();
  return dao;
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

  void update(String newQuery) {
    debouncedUpdate(newQuery, (val) => state = val);
  }

  void updateQuery(String newQuery) {
    debouncedUpdate(newQuery, (val) => state = val);
  }

  void clear() {
    cancelDebounce();
    state = '';
  }
}

@riverpod
class ProductSearchScope extends _$ProductSearchScope {
  @override
  SearchScope build() => SearchScope.all;

  void setScope(SearchScope scope) {
    state = scope;
  }
}

/// Provides populated Autocomplete Trie data structure loaded from database terms.
@Riverpod(keepAlive: true)
Future<AutocompleteTrie> autocompleteTrie(Ref ref) async {
  final dao = await ref.watch(productDaoProvider.future);
  final terms = await dao.getAllSearchTerms();
  final trie = AutocompleteTrie();
  trie.populate(terms);
  return trie;
}

/// Provides sub-millisecond autocomplete suggestions from in-memory trie.
@riverpod
Future<List<String>> productSearchTrieSuggestions(Ref ref) async {
  final query = ref.watch(productSearchQueryProvider);
  if (query.trim().isEmpty) return const [];

  final trie = await ref.watch(autocompleteTrieProvider.future);
  return trie.getSuggestions(query, maxResults: 5);
}

/// Provides fuzzy typo suggestions when search query returns zero results.
@riverpod
Future<List<String>> productSearchFuzzySuggestions(Ref ref) async {
  final query = ref.watch(productSearchQueryProvider);
  if (query.trim().isEmpty) return const [];
  
  final dao = await ref.watch(productDaoProvider.future);
  return dao.findFuzzyProductSuggestions(query);
}

/// Provides dynamic search facet aggregations (category counts) for active search query results.
@riverpod
Future<Map<String, List<FacetCount>>> productSearchFacets(Ref ref) async {
  final query = ref.watch(productSearchQueryProvider);
  final scope = ref.watch(productSearchScopeProvider);
  if (query.trim().isEmpty) return const {};

  final dao = await ref.watch(productDaoProvider.future);
  final items = await dao.getFilteredLabels(
    query: query,
    scope: scope,
    limit: 100,
    offset: 0,
  );

  return calculateFacets<ProductLabel>(
    items: items,
    facetExtractors: {
      'category': (item) => item.category.nameEn,
    },
  );
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
Future<List<String>> availableCategories(Ref ref) async {
  final dao = await ref.watch(productDaoProvider.future);
  final cats = await ref.watch(categoriesProvider.future);
  final groups = await ref.watch(targetGroupsProvider.future);

  final candidateCategories = [
    AppConstants.categoryAll,
    AppConstants.categoryPoultry,
    AppConstants.categoryCattle,
    AppConstants.categoryAqua,
    AppConstants.categoryFeedAdditives,
    AppConstants.categoryVaccines,
  ];

  final available = <String>[];

  for (final category in candidateCategories) {
    if (category == AppConstants.categoryAll) {
      available.add(category);
      continue;
    }

    final criteria = resolveCategoryFilter(category, cats, groups);
    final items = await dao.getFilteredLabels(
      categoryId: criteria.categoryId,
      targetGroupId: criteria.targetGroupId,
      isFeedAdditive: criteria.isFeedAdditive,
      query: '',
      scope: SearchScope.all,
      limit: 1,
      offset: 0,
    );

    if (items.isNotEmpty) {
      available.add(category);
    }
  }

  return available;
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
    final scope = ref.watch(productSearchScopeProvider);
    
    final stopwatch = Stopwatch()..start();
    final initialItems = await dao.getFilteredLabels(
      categoryId: criteria.categoryId,
      targetGroupId: criteria.targetGroupId,
      isFeedAdditive: criteria.isFeedAdditive,
      query: query,
      scope: scope,
      limit: _pageSize + 1,
      offset: 0,
    );
    stopwatch.stop();

    if (query.trim().isNotEmpty) {
      SearchAnalyticsTracker.logSearch(
        query: query,
        resultCount: initialItems.length > _pageSize ? initialItems.length - 1 : initialItems.length,
        executionTimeMs: stopwatch.elapsedMilliseconds,
      );
    }

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
    final scope = ref.read(productSearchScopeProvider);

    final nextChunk = await dao.getFilteredLabels(
      categoryId: criteria.categoryId,
      targetGroupId: criteria.targetGroupId,
      isFeedAdditive: criteria.isFeedAdditive,
      query: query,
      scope: scope,
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

@riverpod
Future<List<Product>> alikeProducts(
  Ref ref,
  int productId, {
  int limit = 10,
}) async {
  final dao = await ref.watch(productDaoProvider.future);
  return dao.getAlikeProducts(productId, limit: limit);
}

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
