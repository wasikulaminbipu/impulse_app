import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_provider.g.dart';

/// Fallback version metadata used only before platform PackageInfo resolves.
const String fallbackAppVersion = '1.0.9';
const int fallbackBuildNumber = 10;

/// Provides dynamically fetched package metadata from platform channels.
@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}

/// Dynamic app version string (e.g., '1.0.6') with fallback.
@Riverpod(keepAlive: true)
String appVersionDisplay(Ref ref) {
  final infoAsync = ref.watch(packageInfoProvider);
  return infoAsync.when(
    data: (info) => info.version.trim().isNotEmpty
        ? info.version.trim()
        : fallbackAppVersion,
    loading: () => fallbackAppVersion,
    error: (err, st) => fallbackAppVersion,
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
          : fallbackAppVersion;
      final b = info.buildNumber.trim().isNotEmpty
          ? info.buildNumber.trim()
          : fallbackBuildNumber.toString();
      return 'v$v (Build $b)';
    },
    loading: () => 'v$fallbackAppVersion (Build $fallbackBuildNumber)',
    error: (err, st) => 'v$fallbackAppVersion (Build $fallbackBuildNumber)',
  );
}
