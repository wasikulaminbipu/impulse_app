// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productsDatabase)
final productsDatabaseProvider = ProductsDatabaseProvider._();

final class ProductsDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProductsDb>,
          ProductsDb,
          FutureOr<ProductsDb>
        >
    with $FutureModifier<ProductsDb>, $FutureProvider<ProductsDb> {
  ProductsDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<ProductsDb> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProductsDb> create(Ref ref) {
    return productsDatabase(ref);
  }
}

String _$productsDatabaseHash() => r'a761f480d45f60409ca2c50b18ba1112c4a0fcec';

@ProviderFor(distributorsDatabase)
final distributorsDatabaseProvider = DistributorsDatabaseProvider._();

final class DistributorsDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<DistributorsDb>,
          DistributorsDb,
          FutureOr<DistributorsDb>
        >
    with $FutureModifier<DistributorsDb>, $FutureProvider<DistributorsDb> {
  DistributorsDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'distributorsDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$distributorsDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<DistributorsDb> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DistributorsDb> create(Ref ref) {
    return distributorsDatabase(ref);
  }
}

String _$distributorsDatabaseHash() =>
    r'c805aa49ec26b2501894f5f35b7921f0a0fc725a';

@ProviderFor(appMaintenanceDatabase)
final appMaintenanceDatabaseProvider = AppMaintenanceDatabaseProvider._();

final class AppMaintenanceDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppMaintenanceDb>,
          AppMaintenanceDb,
          FutureOr<AppMaintenanceDb>
        >
    with $FutureModifier<AppMaintenanceDb>, $FutureProvider<AppMaintenanceDb> {
  AppMaintenanceDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appMaintenanceDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appMaintenanceDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<AppMaintenanceDb> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppMaintenanceDb> create(Ref ref) {
    return appMaintenanceDatabase(ref);
  }
}

String _$appMaintenanceDatabaseHash() =>
    r'b02d9ad16c2dd98923b2e8ad691ffde13fbd0e41';
