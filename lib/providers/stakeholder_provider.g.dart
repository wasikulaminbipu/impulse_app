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

String _$distributorDaoHash() => r'3f3ddeae087c29ee1095117577d49e990ad29435';

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

String _$vetDoctorDaoHash() => r'37a454f16a8ea70aed60f96568ee851651120ab1';

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

String _$salesPersonnelDaoHash() => r'8f6b9580041ed5a61e3b0f705020eeb2d5c8bcd6';

@ProviderFor(locationDao)
final locationDaoProvider = LocationDaoProvider._();

final class LocationDaoProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocationDao>,
          LocationDao,
          FutureOr<LocationDao>
        >
    with $FutureModifier<LocationDao>, $FutureProvider<LocationDao> {
  LocationDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationDaoHash();

  @$internal
  @override
  $FutureProviderElement<LocationDao> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocationDao> create(Ref ref) {
    return locationDao(ref);
  }
}

String _$locationDaoHash() => r'7d869daf89b996317e39e11a97f215ea47fd965d';

@ProviderFor(basesWithUpazilas)
final basesWithUpazilasProvider = BasesWithUpazilasProvider._();

final class BasesWithUpazilasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BaseWithUpazilas>>,
          List<BaseWithUpazilas>,
          FutureOr<List<BaseWithUpazilas>>
        >
    with
        $FutureModifier<List<BaseWithUpazilas>>,
        $FutureProvider<List<BaseWithUpazilas>> {
  BasesWithUpazilasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'basesWithUpazilasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$basesWithUpazilasHash();

  @$internal
  @override
  $FutureProviderElement<List<BaseWithUpazilas>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BaseWithUpazilas>> create(Ref ref) {
    return basesWithUpazilas(ref);
  }
}

String _$basesWithUpazilasHash() => r'c8564978d136377d4758ffa86b69529be82c6edb';

@ProviderFor(upazilasList)
final upazilasListProvider = UpazilasListFamily._();

final class UpazilasListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Upazila>>,
          List<Upazila>,
          FutureOr<List<Upazila>>
        >
    with $FutureModifier<List<Upazila>>, $FutureProvider<List<Upazila>> {
  UpazilasListProvider._({
    required UpazilasListFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'upazilasListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upazilasListHash();

  @override
  String toString() {
    return r'upazilasListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Upazila>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Upazila>> create(Ref ref) {
    final argument = this.argument as int?;
    return upazilasList(ref, districtId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpazilasListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upazilasListHash() => r'344bcb56b4de6d38756ba670b236b784acbd5f77';

final class UpazilasListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Upazila>>, int?> {
  UpazilasListFamily._()
    : super(
        retry: null,
        name: r'upazilasListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpazilasListProvider call({int? districtId}) =>
      UpazilasListProvider._(argument: districtId, from: this);

  @override
  String toString() => r'upazilasListProvider';
}

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

@ProviderFor(SelectedContactRegionFilter)
final selectedContactRegionFilterProvider =
    SelectedContactRegionFilterProvider._();

final class SelectedContactRegionFilterProvider
    extends $NotifierProvider<SelectedContactRegionFilter, String?> {
  SelectedContactRegionFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedContactRegionFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedContactRegionFilterHash();

  @$internal
  @override
  SelectedContactRegionFilter create() => SelectedContactRegionFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedContactRegionFilterHash() =>
    r'3e839d860897c4fdffc569d84e65725f9055ecec';

abstract class _$SelectedContactRegionFilter extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedContactAreaFilter)
final selectedContactAreaFilterProvider = SelectedContactAreaFilterProvider._();

final class SelectedContactAreaFilterProvider
    extends $NotifierProvider<SelectedContactAreaFilter, String?> {
  SelectedContactAreaFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedContactAreaFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedContactAreaFilterHash();

  @$internal
  @override
  SelectedContactAreaFilter create() => SelectedContactAreaFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedContactAreaFilterHash() =>
    r'fa337c40465d2033b04b69684179fc8cc049339d';

abstract class _$SelectedContactAreaFilter extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
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
    r'140d5dd4740112df3fc7b6b6c11a63f6b759f113';

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
    r'b7e9cd4a94ecf6efa728b22085f5b24bab182f73';

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
    r'f367af14419b9f7ceeb9282dd4c59b6029398997';

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

@ProviderFor(salesPersonnelSearchTrie)
final salesPersonnelSearchTrieProvider = SalesPersonnelSearchTrieProvider._();

final class SalesPersonnelSearchTrieProvider
    extends
        $FunctionalProvider<
          AsyncValue<AutocompleteTrie>,
          AutocompleteTrie,
          FutureOr<AutocompleteTrie>
        >
    with $FutureModifier<AutocompleteTrie>, $FutureProvider<AutocompleteTrie> {
  SalesPersonnelSearchTrieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesPersonnelSearchTrieProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesPersonnelSearchTrieHash();

  @$internal
  @override
  $FutureProviderElement<AutocompleteTrie> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AutocompleteTrie> create(Ref ref) {
    return salesPersonnelSearchTrie(ref);
  }
}

String _$salesPersonnelSearchTrieHash() =>
    r'8827aa3023a49bf4b017a15d00c4cc04051884dd';

@ProviderFor(salesPersonnelSearchTrieSuggestions)
final salesPersonnelSearchTrieSuggestionsProvider =
    SalesPersonnelSearchTrieSuggestionsProvider._();

final class SalesPersonnelSearchTrieSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  SalesPersonnelSearchTrieSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesPersonnelSearchTrieSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$salesPersonnelSearchTrieSuggestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return salesPersonnelSearchTrieSuggestions(ref);
  }
}

String _$salesPersonnelSearchTrieSuggestionsHash() =>
    r'7d97a0c7ae102ec1ba4cd16e87fc1abdd51dbf2e';

@ProviderFor(vetDoctorSearchTrie)
final vetDoctorSearchTrieProvider = VetDoctorSearchTrieProvider._();

final class VetDoctorSearchTrieProvider
    extends
        $FunctionalProvider<
          AsyncValue<AutocompleteTrie>,
          AutocompleteTrie,
          FutureOr<AutocompleteTrie>
        >
    with $FutureModifier<AutocompleteTrie>, $FutureProvider<AutocompleteTrie> {
  VetDoctorSearchTrieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vetDoctorSearchTrieProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vetDoctorSearchTrieHash();

  @$internal
  @override
  $FutureProviderElement<AutocompleteTrie> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AutocompleteTrie> create(Ref ref) {
    return vetDoctorSearchTrie(ref);
  }
}

String _$vetDoctorSearchTrieHash() =>
    r'da3d5a35f510e5d9767b4b27f078966c09561f6e';

@ProviderFor(vetDoctorSearchTrieSuggestions)
final vetDoctorSearchTrieSuggestionsProvider =
    VetDoctorSearchTrieSuggestionsProvider._();

final class VetDoctorSearchTrieSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  VetDoctorSearchTrieSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vetDoctorSearchTrieSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vetDoctorSearchTrieSuggestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return vetDoctorSearchTrieSuggestions(ref);
  }
}

String _$vetDoctorSearchTrieSuggestionsHash() =>
    r'c5b636bde8e037f9b730084e27b872ffcd3bd899';
