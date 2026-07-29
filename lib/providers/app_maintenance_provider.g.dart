// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_maintenance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appMaintenanceDao)
final appMaintenanceDaoProvider = AppMaintenanceDaoProvider._();

final class AppMaintenanceDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppMaintenanceDao>,
          AppMaintenanceDao,
          FutureOr<AppMaintenanceDao>
        >
    with
        $FutureModifier<AppMaintenanceDao>,
        $FutureProvider<AppMaintenanceDao> {
  AppMaintenanceDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appMaintenanceDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appMaintenanceDaoHash();

  @$internal
  @override
  $FutureProviderElement<AppMaintenanceDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppMaintenanceDao> create(Ref ref) {
    return appMaintenanceDao(ref);
  }
}

String _$appMaintenanceDaoHash() => r'aaf6d917e2fcfe8df3722edd0583e7c7242699eb';

@ProviderFor(distributorFavorites)
final distributorFavoritesProvider = DistributorFavoritesProvider._();

final class DistributorFavoritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  DistributorFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'distributorFavoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$distributorFavoritesHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return distributorFavorites(ref);
  }
}

String _$distributorFavoritesHash() =>
    r'179d8f3937e91c60fdff88600f2ea7481441d94f';

@ProviderFor(vetDoctorFavorites)
final vetDoctorFavoritesProvider = VetDoctorFavoritesProvider._();

final class VetDoctorFavoritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  VetDoctorFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vetDoctorFavoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vetDoctorFavoritesHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return vetDoctorFavorites(ref);
  }
}

String _$vetDoctorFavoritesHash() =>
    r'58889cff6c0aff87e4b4df1970de8698d8928f8e';

@ProviderFor(salesPersonnelFavorites)
final salesPersonnelFavoritesProvider = SalesPersonnelFavoritesProvider._();

final class SalesPersonnelFavoritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  SalesPersonnelFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesPersonnelFavoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesPersonnelFavoritesHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return salesPersonnelFavorites(ref);
  }
}

String _$salesPersonnelFavoritesHash() =>
    r'62a9d3261fc55978bd7db89004189a36060cf33c';

@ProviderFor(productFavorites)
final productFavoritesProvider = ProductFavoritesProvider._();

final class ProductFavoritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  ProductFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productFavoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productFavoritesHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return productFavorites(ref);
  }
}

String _$productFavoritesHash() => r'b23f7223b395441be5209a4543ec4005a4de876e';

@ProviderFor(LanguageSetting)
final languageSettingProvider = LanguageSettingProvider._();

final class LanguageSettingProvider
    extends $NotifierProvider<LanguageSetting, String> {
  LanguageSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageSettingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageSettingHash();

  @$internal
  @override
  LanguageSetting create() => LanguageSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$languageSettingHash() => r'3a34852c0bb52782dc93748463ef41564b3d5a15';

abstract class _$LanguageSetting extends $Notifier<String> {
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
