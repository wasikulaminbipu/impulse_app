// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stakeholder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(distributorDao)
final distributorDaoProvider = DistributorDaoProvider._();

final class DistributorDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<DistributorDao>,
          DistributorDao,
          FutureOr<DistributorDao>
        >
    with $FutureModifier<DistributorDao>, $FutureProvider<DistributorDao> {
  DistributorDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'distributorDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$distributorDaoHash();

  @$internal
  @override
  $FutureProviderElement<DistributorDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DistributorDao> create(Ref ref) {
    return distributorDao(ref);
  }
}

String _$distributorDaoHash() => r'e08cf9085a38052489d2853237e6106102cb0537';

@ProviderFor(vetDoctorDao)
final vetDoctorDaoProvider = VetDoctorDaoProvider._();

final class VetDoctorDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<VetDoctorDao>,
          VetDoctorDao,
          FutureOr<VetDoctorDao>
        >
    with $FutureModifier<VetDoctorDao>, $FutureProvider<VetDoctorDao> {
  VetDoctorDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vetDoctorDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vetDoctorDaoHash();

  @$internal
  @override
  $FutureProviderElement<VetDoctorDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VetDoctorDao> create(Ref ref) {
    return vetDoctorDao(ref);
  }
}

String _$vetDoctorDaoHash() => r'69de96a21b86f6860529e49f151353d246ef1211';

@ProviderFor(salesPersonnelDao)
final salesPersonnelDaoProvider = SalesPersonnelDaoProvider._();

final class SalesPersonnelDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<SalesPersonnelDao>,
          SalesPersonnelDao,
          FutureOr<SalesPersonnelDao>
        >
    with
        $FutureModifier<SalesPersonnelDao>,
        $FutureProvider<SalesPersonnelDao> {
  SalesPersonnelDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesPersonnelDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesPersonnelDaoHash();

  @$internal
  @override
  $FutureProviderElement<SalesPersonnelDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SalesPersonnelDao> create(Ref ref) {
    return salesPersonnelDao(ref);
  }
}

String _$salesPersonnelDaoHash() => r'e3562964f266e55da31ceb3247b3fe4bc774afe5';

@ProviderFor(DistributorSearchQuery)
final distributorSearchQueryProvider = DistributorSearchQueryProvider._();

final class DistributorSearchQueryProvider
    extends $NotifierProvider<DistributorSearchQuery, String> {
  DistributorSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'distributorSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$distributorSearchQueryHash();

  @$internal
  @override
  DistributorSearchQuery create() => DistributorSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$distributorSearchQueryHash() =>
    r'ab578f44104367de427a62dd233a7615598ac0d6';

abstract class _$DistributorSearchQuery extends $Notifier<String> {
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

@ProviderFor(PaginatedDistributors)
final paginatedDistributorsProvider = PaginatedDistributorsProvider._();

final class PaginatedDistributorsProvider
    extends
        $AsyncNotifierProvider<
          PaginatedDistributors,
          PaginatedState<DistributorWithLocation>
        > {
  PaginatedDistributorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedDistributorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedDistributorsHash();

  @$internal
  @override
  PaginatedDistributors create() => PaginatedDistributors();
}

String _$paginatedDistributorsHash() =>
    r'94341e2e39990dcaf631b8ef11c0ecb0a0eac13d';

abstract class _$PaginatedDistributors
    extends $AsyncNotifier<PaginatedState<DistributorWithLocation>> {
  FutureOr<PaginatedState<DistributorWithLocation>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedState<DistributorWithLocation>>,
              PaginatedState<DistributorWithLocation>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedState<DistributorWithLocation>>,
                PaginatedState<DistributorWithLocation>
              >,
              AsyncValue<PaginatedState<DistributorWithLocation>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(PaginatedVetDoctors)
final paginatedVetDoctorsProvider = PaginatedVetDoctorsProvider._();

final class PaginatedVetDoctorsProvider
    extends
        $AsyncNotifierProvider<
          PaginatedVetDoctors,
          PaginatedState<VetDoctorWithAreas>
        > {
  PaginatedVetDoctorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedVetDoctorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedVetDoctorsHash();

  @$internal
  @override
  PaginatedVetDoctors create() => PaginatedVetDoctors();
}

String _$paginatedVetDoctorsHash() =>
    r'6d2ea4c0936ef87db35ef534d635fb0f714f4868';

abstract class _$PaginatedVetDoctors
    extends $AsyncNotifier<PaginatedState<VetDoctorWithAreas>> {
  FutureOr<PaginatedState<VetDoctorWithAreas>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedState<VetDoctorWithAreas>>,
              PaginatedState<VetDoctorWithAreas>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedState<VetDoctorWithAreas>>,
                PaginatedState<VetDoctorWithAreas>
              >,
              AsyncValue<PaginatedState<VetDoctorWithAreas>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(VetDoctorsSearchQuery)
final vetDoctorsSearchQueryProvider = VetDoctorsSearchQueryProvider._();

final class VetDoctorsSearchQueryProvider
    extends $NotifierProvider<VetDoctorsSearchQuery, String> {
  VetDoctorsSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vetDoctorsSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vetDoctorsSearchQueryHash();

  @$internal
  @override
  VetDoctorsSearchQuery create() => VetDoctorsSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$vetDoctorsSearchQueryHash() =>
    r'5b96e844219006b6a5335b56e71dabe7ad12f6c3';

abstract class _$VetDoctorsSearchQuery extends $Notifier<String> {
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

@ProviderFor(PaginatedSalesPersonnel)
final paginatedSalesPersonnelProvider = PaginatedSalesPersonnelProvider._();

final class PaginatedSalesPersonnelProvider
    extends
        $AsyncNotifierProvider<
          PaginatedSalesPersonnel,
          PaginatedState<SalesPersonnelWithAreas>
        > {
  PaginatedSalesPersonnelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedSalesPersonnelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedSalesPersonnelHash();

  @$internal
  @override
  PaginatedSalesPersonnel create() => PaginatedSalesPersonnel();
}

String _$paginatedSalesPersonnelHash() =>
    r'e6986036163df3a1792ed7328a6e874d3b8bf668';

abstract class _$PaginatedSalesPersonnel
    extends $AsyncNotifier<PaginatedState<SalesPersonnelWithAreas>> {
  FutureOr<PaginatedState<SalesPersonnelWithAreas>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedState<SalesPersonnelWithAreas>>,
              PaginatedState<SalesPersonnelWithAreas>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedState<SalesPersonnelWithAreas>>,
                PaginatedState<SalesPersonnelWithAreas>
              >,
              AsyncValue<PaginatedState<SalesPersonnelWithAreas>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SalesPersonnelSearchQuery)
final salesPersonnelSearchQueryProvider = SalesPersonnelSearchQueryProvider._();

final class SalesPersonnelSearchQueryProvider
    extends $NotifierProvider<SalesPersonnelSearchQuery, String> {
  SalesPersonnelSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesPersonnelSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesPersonnelSearchQueryHash();

  @$internal
  @override
  SalesPersonnelSearchQuery create() => SalesPersonnelSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$salesPersonnelSearchQueryHash() =>
    r'a94f3431a25603611e129acf4366ac6866887e18';

abstract class _$SalesPersonnelSearchQuery extends $Notifier<String> {
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
