// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the selected tab index of the main screen navigation.
/// 0: Products Directory, 1: Manufacturers, 2: Contact Details

@ProviderFor(MainNavIndex)
final mainNavIndexProvider = MainNavIndexProvider._();

/// Manages the selected tab index of the main screen navigation.
/// 0: Products Directory, 1: Manufacturers, 2: Contact Details
final class MainNavIndexProvider extends $NotifierProvider<MainNavIndex, int> {
  /// Manages the selected tab index of the main screen navigation.
  /// 0: Products Directory, 1: Manufacturers, 2: Contact Details
  MainNavIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainNavIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainNavIndexHash();

  @$internal
  @override
  MainNavIndex create() => MainNavIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainNavIndexHash() => r'8861df9d1845f69d9ee9bb761d47f3ae8610253d';

/// Manages the selected tab index of the main screen navigation.
/// 0: Products Directory, 1: Manufacturers, 2: Contact Details

abstract class _$MainNavIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
