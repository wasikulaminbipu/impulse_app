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

String _$productsDatabaseHash() => r'f8b41d8cc11b8acf8fd6aa24a567d077e0432483';

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
    r'934a212a48f2f20d587cb1de6b77e5cd7c025779';

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
    r'5fc2be4238ac88acdd0aff0554b47e8051af2c23';
