// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_review_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appReviewService)
final appReviewServiceProvider = AppReviewServiceProvider._();

final class AppReviewServiceProvider
    extends
        $FunctionalProvider<
          AppReviewService,
          AppReviewService,
          AppReviewService
        >
    with $Provider<AppReviewService> {
  AppReviewServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appReviewServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appReviewServiceHash();

  @$internal
  @override
  $ProviderElement<AppReviewService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppReviewService create(Ref ref) {
    return appReviewService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppReviewService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppReviewService>(value),
    );
  }
}

String _$appReviewServiceHash() => r'a7d5a9c9af02782659e40b80d91e5763d75613ee';

@ProviderFor(AppReviewNotifier)
final appReviewProvider = AppReviewNotifierProvider._();

final class AppReviewNotifierProvider
    extends $NotifierProvider<AppReviewNotifier, void> {
  AppReviewNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appReviewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appReviewNotifierHash();

  @$internal
  @override
  AppReviewNotifier create() => AppReviewNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$appReviewNotifierHash() => r'491e2f8a4cf12445ae549b7588fc3d6240a30c6f';

abstract class _$AppReviewNotifier extends $Notifier<void> {
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
