// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productDao)
final productDaoProvider = ProductDaoProvider._();

final class ProductDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProductDao>,
          ProductDao,
          FutureOr<ProductDao>
        >
    with $FutureModifier<ProductDao>, $FutureProvider<ProductDao> {
  ProductDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productDaoHash();

  @$internal
  @override
  $FutureProviderElement<ProductDao> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProductDao> create(Ref ref) {
    return productDao(ref);
  }
}

String _$productDaoHash() => r'3cc03203e15900009e0819d07ea430fede92738f';

@ProviderFor(manufacturerDao)
final manufacturerDaoProvider = ManufacturerDaoProvider._();

final class ManufacturerDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<ManufacturerDao>,
          ManufacturerDao,
          FutureOr<ManufacturerDao>
        >
    with $FutureModifier<ManufacturerDao>, $FutureProvider<ManufacturerDao> {
  ManufacturerDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manufacturerDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manufacturerDaoHash();

  @$internal
  @override
  $FutureProviderElement<ManufacturerDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ManufacturerDao> create(Ref ref) {
    return manufacturerDao(ref);
  }
}

String _$manufacturerDaoHash() => r'22151f672d2406f003126c14d7b90b39199987af';

@ProviderFor(lookupDao)
final lookupDaoProvider = LookupDaoProvider._();

final class LookupDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<LookupDao>,
          LookupDao,
          FutureOr<LookupDao>
        >
    with $FutureModifier<LookupDao>, $FutureProvider<LookupDao> {
  LookupDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lookupDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lookupDaoHash();

  @$internal
  @override
  $FutureProviderElement<LookupDao> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LookupDao> create(Ref ref) {
    return lookupDao(ref);
  }
}

String _$lookupDaoHash() => r'ae369bd812b09a73db905ef0c8bdad496c57abc7';

@ProviderFor(ProductSearchQuery)
final productSearchQueryProvider = ProductSearchQueryProvider._();

final class ProductSearchQueryProvider
    extends $NotifierProvider<ProductSearchQuery, String> {
  ProductSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productSearchQueryHash();

  @$internal
  @override
  ProductSearchQuery create() => ProductSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$productSearchQueryHash() =>
    r'3f92e55c37e520796571944c864a8fcef1b34bc4';

abstract class _$ProductSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ProductSearchScope)
final productSearchScopeProvider = ProductSearchScopeProvider._();

final class ProductSearchScopeProvider
    extends $NotifierProvider<ProductSearchScope, SearchScope> {
  ProductSearchScopeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productSearchScopeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productSearchScopeHash();

  @$internal
  @override
  ProductSearchScope create() => ProductSearchScope();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchScope value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchScope>(value),
    );
  }
}

String _$productSearchScopeHash() =>
    r'c65374d3ccf42698e900c2f720dd3acb7e58fd8c';

abstract class _$ProductSearchScope extends $Notifier<SearchScope> {
  SearchScope build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchScope, SearchScope>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchScope, SearchScope>,
              SearchScope,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Provides populated Autocomplete Trie data structure loaded from database terms.

@ProviderFor(autocompleteTrie)
final autocompleteTrieProvider = AutocompleteTrieProvider._();

/// Provides populated Autocomplete Trie data structure loaded from database terms.

final class AutocompleteTrieProvider
    extends
        $FunctionalProvider<
          AsyncValue<AutocompleteTrie>,
          AutocompleteTrie,
          FutureOr<AutocompleteTrie>
        >
    with $FutureModifier<AutocompleteTrie>, $FutureProvider<AutocompleteTrie> {
  /// Provides populated Autocomplete Trie data structure loaded from database terms.
  AutocompleteTrieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autocompleteTrieProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autocompleteTrieHash();

  @$internal
  @override
  $FutureProviderElement<AutocompleteTrie> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AutocompleteTrie> create(Ref ref) {
    return autocompleteTrie(ref);
  }
}

String _$autocompleteTrieHash() => r'687d6aec2aaa128d6a9d91a687271e55012c4d6f';

/// Provides sub-millisecond autocomplete suggestions from in-memory trie.

@ProviderFor(productSearchTrieSuggestions)
final productSearchTrieSuggestionsProvider =
    ProductSearchTrieSuggestionsProvider._();

/// Provides sub-millisecond autocomplete suggestions from in-memory trie.

final class ProductSearchTrieSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Provides sub-millisecond autocomplete suggestions from in-memory trie.
  ProductSearchTrieSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productSearchTrieSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productSearchTrieSuggestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return productSearchTrieSuggestions(ref);
  }
}

String _$productSearchTrieSuggestionsHash() =>
    r'ebfb6588cfc8bfc4c0b23d74cd46865d4ab7ac84';

/// Provides fuzzy typo suggestions when search query returns zero results.

@ProviderFor(productSearchFuzzySuggestions)
final productSearchFuzzySuggestionsProvider =
    ProductSearchFuzzySuggestionsProvider._();

/// Provides fuzzy typo suggestions when search query returns zero results.

final class ProductSearchFuzzySuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Provides fuzzy typo suggestions when search query returns zero results.
  ProductSearchFuzzySuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productSearchFuzzySuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productSearchFuzzySuggestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return productSearchFuzzySuggestions(ref);
  }
}

String _$productSearchFuzzySuggestionsHash() =>
    r'89d000228e01f46f0207e13506a5bc089b8c51ef';

/// Provides dynamic search facet aggregations (category counts) for active search query results.

@ProviderFor(productSearchFacets)
final productSearchFacetsProvider = ProductSearchFacetsProvider._();

/// Provides dynamic search facet aggregations (category counts) for active search query results.

final class ProductSearchFacetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<FacetCount>>>,
          Map<String, List<FacetCount>>,
          FutureOr<Map<String, List<FacetCount>>>
        >
    with
        $FutureModifier<Map<String, List<FacetCount>>>,
        $FutureProvider<Map<String, List<FacetCount>>> {
  /// Provides dynamic search facet aggregations (category counts) for active search query results.
  ProductSearchFacetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productSearchFacetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productSearchFacetsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<FacetCount>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<FacetCount>>> create(Ref ref) {
    return productSearchFacets(ref);
  }
}

String _$productSearchFacetsHash() =>
    r'cdceb61c0de20bd6c2bf73d745f34968bb0a9124';

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Category>>,
          List<Category>,
          FutureOr<List<Category>>
        >
    with $FutureModifier<List<Category>>, $FutureProvider<List<Category>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Category>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Category>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'446091015abc6cac5b4a0b3e3966b60008cf7593';

@ProviderFor(availableCategories)
final availableCategoriesProvider = AvailableCategoriesProvider._();

final class AvailableCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  AvailableCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return availableCategories(ref);
  }
}

String _$availableCategoriesHash() =>
    r'6cdabfe3fe0d2d5b7ba3cad06cc6b9bba81ae010';

@ProviderFor(targetGroups)
final targetGroupsProvider = TargetGroupsProvider._();

final class TargetGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TargetGroup>>,
          List<TargetGroup>,
          FutureOr<List<TargetGroup>>
        >
    with
        $FutureModifier<List<TargetGroup>>,
        $FutureProvider<List<TargetGroup>> {
  TargetGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'targetGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$targetGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<TargetGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TargetGroup>> create(Ref ref) {
    return targetGroups(ref);
  }
}

String _$targetGroupsHash() => r'514276d28d2b4dcfabf18657462576e2d7aa1585';

@ProviderFor(species)
final speciesProvider = SpeciesProvider._();

final class SpeciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Species>>,
          List<Species>,
          FutureOr<List<Species>>
        >
    with $FutureModifier<List<Species>>, $FutureProvider<List<Species>> {
  SpeciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speciesHash();

  @$internal
  @override
  $FutureProviderElement<List<Species>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Species>> create(Ref ref) {
    return species(ref);
  }
}

String _$speciesHash() => r'4e94fec5cd5bd6e812e1bd3c44e3335ef948d35a';

@ProviderFor(manufacturers)
final manufacturersProvider = ManufacturersProvider._();

final class ManufacturersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manufacturer>>,
          List<Manufacturer>,
          FutureOr<List<Manufacturer>>
        >
    with
        $FutureModifier<List<Manufacturer>>,
        $FutureProvider<List<Manufacturer>> {
  ManufacturersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manufacturersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manufacturersHash();

  @$internal
  @override
  $FutureProviderElement<List<Manufacturer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manufacturer>> create(Ref ref) {
    return manufacturers(ref);
  }
}

String _$manufacturersHash() => r'3510ec95210c3a4acf941fd5b9fbce0794379a12';

@ProviderFor(ManufacturersSearchQuery)
final manufacturersSearchQueryProvider = ManufacturersSearchQueryProvider._();

final class ManufacturersSearchQueryProvider
    extends $NotifierProvider<ManufacturersSearchQuery, String> {
  ManufacturersSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manufacturersSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manufacturersSearchQueryHash();

  @$internal
  @override
  ManufacturersSearchQuery create() => ManufacturersSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$manufacturersSearchQueryHash() =>
    r'd8e60a71c79a03587d049451b0a37e8bfdcc8444';

abstract class _$ManufacturersSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(PaginatedManufacturers)
final paginatedManufacturersProvider = PaginatedManufacturersProvider._();

final class PaginatedManufacturersProvider
    extends
        $AsyncNotifierProvider<
          PaginatedManufacturers,
          PaginatedState<Manufacturer>
        > {
  PaginatedManufacturersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedManufacturersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedManufacturersHash();

  @$internal
  @override
  PaginatedManufacturers create() => PaginatedManufacturers();
}

String _$paginatedManufacturersHash() =>
    r'8223eb1fd0248bb099090cb5d2d1e4eca13122f8';

abstract class _$PaginatedManufacturers
    extends $AsyncNotifier<PaginatedState<Manufacturer>> {
  FutureOr<PaginatedState<Manufacturer>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedState<Manufacturer>>,
              PaginatedState<Manufacturer>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedState<Manufacturer>>,
                PaginatedState<Manufacturer>
              >,
              AsyncValue<PaginatedState<Manufacturer>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Lightweight ProductLabel list for grids/tabs (no compositions/indications/
/// directions/precautions attached — see productDetail for the full
/// hydrated product). Active products only by default.

@ProviderFor(products)
final productsProvider = ProductsProvider._();

/// Lightweight ProductLabel list for grids/tabs (no compositions/indications/
/// directions/precautions attached — see productDetail for the full
/// hydrated product). Active products only by default.

final class ProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductLabel>>,
          List<ProductLabel>,
          FutureOr<List<ProductLabel>>
        >
    with
        $FutureModifier<List<ProductLabel>>,
        $FutureProvider<List<ProductLabel>> {
  /// Lightweight ProductLabel list for grids/tabs (no compositions/indications/
  /// directions/precautions attached — see productDetail for the full
  /// hydrated product). Active products only by default.
  ProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductLabel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductLabel>> create(Ref ref) {
    return products(ref);
  }
}

String _$productsHash() => r'666f31bbc786d6516bd13d397ffdb1041b85544a';

/// Fully hydrated product for the Product Detail Page: compositions,
/// indications, directions, precautions, presentations, target groups and
/// manufacturer are all loaded.

@ProviderFor(productDetail)
final productDetailProvider = ProductDetailFamily._();

/// Fully hydrated product for the Product Detail Page: compositions,
/// indications, directions, precautions, presentations, target groups and
/// manufacturer are all loaded.

final class ProductDetailProvider
    extends $FunctionalProvider<AsyncValue<Product>, Product, FutureOr<Product>>
    with $FutureModifier<Product>, $FutureProvider<Product> {
  /// Fully hydrated product for the Product Detail Page: compositions,
  /// indications, directions, precautions, presentations, target groups and
  /// manufacturer are all loaded.
  ProductDetailProvider._({
    required ProductDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailHash();

  @override
  String toString() {
    return r'productDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Product> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Product> create(Ref ref) {
    final argument = this.argument as int;
    return productDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailHash() => r'ce452595d47719d3041d623442bac16555927d70';

/// Fully hydrated product for the Product Detail Page: compositions,
/// indications, directions, precautions, presentations, target groups and
/// manufacturer are all loaded.

final class ProductDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Product>, int> {
  ProductDetailFamily._()
    : super(
        retry: null,
        name: r'productDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fully hydrated product for the Product Detail Page: compositions,
  /// indications, directions, precautions, presentations, target groups and
  /// manufacturer are all loaded.

  ProductDetailProvider call(int productId) =>
      ProductDetailProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailProvider';
}

@ProviderFor(PaginatedCategoryProducts)
final paginatedCategoryProductsProvider = PaginatedCategoryProductsFamily._();

final class PaginatedCategoryProductsProvider
    extends
        $AsyncNotifierProvider<
          PaginatedCategoryProducts,
          PaginatedState<ProductLabel>
        > {
  PaginatedCategoryProductsProvider._({
    required PaginatedCategoryProductsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paginatedCategoryProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paginatedCategoryProductsHash();

  @override
  String toString() {
    return r'paginatedCategoryProductsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PaginatedCategoryProducts create() => PaginatedCategoryProducts();

  @override
  bool operator ==(Object other) {
    return other is PaginatedCategoryProductsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paginatedCategoryProductsHash() =>
    r'430e015be0be60cb48372cf9c142fad1afaa11dc';

final class PaginatedCategoryProductsFamily extends $Family
    with
        $ClassFamilyOverride<
          PaginatedCategoryProducts,
          AsyncValue<PaginatedState<ProductLabel>>,
          PaginatedState<ProductLabel>,
          FutureOr<PaginatedState<ProductLabel>>,
          String
        > {
  PaginatedCategoryProductsFamily._()
    : super(
        retry: null,
        name: r'paginatedCategoryProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PaginatedCategoryProductsProvider call(String category) =>
      PaginatedCategoryProductsProvider._(argument: category, from: this);

  @override
  String toString() => r'paginatedCategoryProductsProvider';
}

abstract class _$PaginatedCategoryProducts
    extends $AsyncNotifier<PaginatedState<ProductLabel>> {
  late final _$args = ref.$arg as String;
  String get category => _$args;

  FutureOr<PaginatedState<ProductLabel>> build(String category);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedState<ProductLabel>>,
              PaginatedState<ProductLabel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedState<ProductLabel>>,
                PaginatedState<ProductLabel>
              >,
              AsyncValue<PaginatedState<ProductLabel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
/// now a standalone entity, so this is a single WHERE manufacturer_id = ?
/// query instead of fuzzy-matching a duplicated manufacturer name.

@ProviderFor(productsByManufacturer)
final productsByManufacturerProvider = ProductsByManufacturerFamily._();

/// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
/// now a standalone entity, so this is a single WHERE manufacturer_id = ?
/// query instead of fuzzy-matching a duplicated manufacturer name.

final class ProductsByManufacturerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          FutureOr<List<Product>>
        >
    with $FutureModifier<List<Product>>, $FutureProvider<List<Product>> {
  /// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
  /// now a standalone entity, so this is a single WHERE manufacturer_id = ?
  /// query instead of fuzzy-matching a duplicated manufacturer name.
  ProductsByManufacturerProvider._({
    required ProductsByManufacturerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productsByManufacturerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productsByManufacturerHash();

  @override
  String toString() {
    return r'productsByManufacturerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Product>> create(Ref ref) {
    final argument = this.argument as int;
    return productsByManufacturer(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByManufacturerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productsByManufacturerHash() =>
    r'a61f69645d0f7eb1f664a7c661b78be0d1224f55';

/// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
/// now a standalone entity, so this is a single WHERE manufacturer_id = ?
/// query instead of fuzzy-matching a duplicated manufacturer name.

final class ProductsByManufacturerFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Product>>, int> {
  ProductsByManufacturerFamily._()
    : super(
        retry: null,
        name: r'productsByManufacturerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Manufacturer Detail Page: products by manufacturer id. Manufacturers are
  /// now a standalone entity, so this is a single WHERE manufacturer_id = ?
  /// query instead of fuzzy-matching a duplicated manufacturer name.

  ProductsByManufacturerProvider call(int manufacturerId) =>
      ProductsByManufacturerProvider._(argument: manufacturerId, from: this);

  @override
  String toString() => r'productsByManufacturerProvider';
}

@ProviderFor(alikeProducts)
final alikeProductsProvider = AlikeProductsFamily._();

final class AlikeProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          FutureOr<List<Product>>
        >
    with $FutureModifier<List<Product>>, $FutureProvider<List<Product>> {
  AlikeProductsProvider._({
    required AlikeProductsFamily super.from,
    required (int, {int limit}) super.argument,
  }) : super(
         retry: null,
         name: r'alikeProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$alikeProductsHash();

  @override
  String toString() {
    return r'alikeProductsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Product>> create(Ref ref) {
    final argument = this.argument as (int, {int limit});
    return alikeProducts(ref, argument.$1, limit: argument.limit);
  }

  @override
  bool operator ==(Object other) {
    return other is AlikeProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$alikeProductsHash() => r'67c161957723134c55d4fe1557fd176d524abf39';

final class AlikeProductsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<Product>>, (int, {int limit})> {
  AlikeProductsFamily._()
    : super(
        retry: null,
        name: r'alikeProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AlikeProductsProvider call(int productId, {int limit = 10}) =>
      AlikeProductsProvider._(argument: (productId, limit: limit), from: this);

  @override
  String toString() => r'alikeProductsProvider';
}

@ProviderFor(FavoriteToggle)
final favoriteToggleProvider = FavoriteToggleProvider._();

final class FavoriteToggleProvider
    extends $NotifierProvider<FavoriteToggle, void> {
  FavoriteToggleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteToggleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteToggleHash();

  @$internal
  @override
  FavoriteToggle create() => FavoriteToggle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$favoriteToggleHash() => r'942e86940fe294a6fed3729482de321acfae6ad8';

abstract class _$FavoriteToggle extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
