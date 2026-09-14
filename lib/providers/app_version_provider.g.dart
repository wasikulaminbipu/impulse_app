// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides dynamically fetched package metadata from platform channels.

@ProviderFor(packageInfo)
final packageInfoProvider = PackageInfoProvider._();

/// Provides dynamically fetched package metadata from platform channels.

final class PackageInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<PackageInfo>,
          PackageInfo,
          FutureOr<PackageInfo>
        >
    with $FutureModifier<PackageInfo>, $FutureProvider<PackageInfo> {
  /// Provides dynamically fetched package metadata from platform channels.
  PackageInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $FutureProviderElement<PackageInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PackageInfo> create(Ref ref) {
    return packageInfo(ref);
  }
}

String _$packageInfoHash() => r'44d37547139567a5f03c1942c1d62ff1abb07248';

/// Dynamic app version string (e.g., '1.0.6') with fallback to AppConstants.

@ProviderFor(appVersionDisplay)
final appVersionDisplayProvider = AppVersionDisplayProvider._();

/// Dynamic app version string (e.g., '1.0.6') with fallback to AppConstants.

final class AppVersionDisplayProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Dynamic app version string (e.g., '1.0.6') with fallback to AppConstants.
  AppVersionDisplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionDisplayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionDisplayHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appVersionDisplay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appVersionDisplayHash() => r'0d66bf3b34a8c2447018f2f6255029d3675883a4';

/// Dynamic full app version string (e.g., 'v1.0.6 (Build 7)') with fallback.

@ProviderFor(appFullVersionDisplay)
final appFullVersionDisplayProvider = AppFullVersionDisplayProvider._();

/// Dynamic full app version string (e.g., 'v1.0.6 (Build 7)') with fallback.

final class AppFullVersionDisplayProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Dynamic full app version string (e.g., 'v1.0.6 (Build 7)') with fallback.
  AppFullVersionDisplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appFullVersionDisplayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appFullVersionDisplayHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appFullVersionDisplay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appFullVersionDisplayHash() =>
    r'afcc2ca8427fcfd968e54d5482bb21968009f087';
