import 'package:impulse_app/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_provider.g.dart';

/// Provides dynamically fetched package metadata from platform channels.
@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}

/// Dynamic app version string (e.g., '1.0.6') with fallback to AppConstants.
@Riverpod(keepAlive: true)
String appVersionDisplay(Ref ref) {
  final infoAsync = ref.watch(packageInfoProvider);
  return infoAsync.when(
    data: (info) => info.version.trim().isNotEmpty
        ? info.version.trim()
        : AppConstants.appVersion,
    loading: () => AppConstants.appVersion,
    error: (err, st) => AppConstants.appVersion,
  );
}

/// Dynamic full app version string (e.g., 'v1.0.6 (Build 7)') with fallback.
@Riverpod(keepAlive: true)
String appFullVersionDisplay(Ref ref) {
  final infoAsync = ref.watch(packageInfoProvider);
  return infoAsync.when(
    data: (info) {
      final v = info.version.trim().isNotEmpty
          ? info.version.trim()
          : AppConstants.appVersion;
      final b = info.buildNumber.trim().isNotEmpty
          ? info.buildNumber.trim()
          : AppConstants.buildNumber.toString();
      return 'v$v (Build $b)';
    },
    loading: () =>
        'v${AppConstants.appVersion} (Build ${AppConstants.buildNumber})',
    error: (err, st) =>
        'v${AppConstants.appVersion} (Build ${AppConstants.buildNumber})',
  );
}
