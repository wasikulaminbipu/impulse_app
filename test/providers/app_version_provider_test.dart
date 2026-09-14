import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_version_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppVersionProvider Tests', () {
    test('appVersionDisplayProvider falls back to fallbackAppVersion when packageInfo is loading/empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final version = container.read(appVersionDisplayProvider);
      expect(version, equals(fallbackAppVersion));
    });

    test('appFullVersionDisplayProvider falls back to fallbackAppVersion when packageInfo is loading/empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final fullVersion = container.read(appFullVersionDisplayProvider);
      expect(
        fullVersion,
        equals('v$fallbackAppVersion (Build $fallbackBuildNumber)'),
      );
    });

    test('dynamic package info with mock initial values resolves version and build number', () async {
      PackageInfo.setMockInitialValues(
        appName: 'Impulse App',
        packageName: 'com.impulseagriscienceltd.impulse_app',
        version: '1.2.3',
        buildNumber: '45',
        buildSignature: '',
      );

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final info = await container.read(packageInfoProvider.future);
      expect(info.version, equals('1.2.3'));
      expect(info.buildNumber, equals('45'));

      final version = container.read(appVersionDisplayProvider);
      expect(version, equals('1.2.3'));

      final fullVersion = container.read(appFullVersionDisplayProvider);
      expect(fullVersion, equals('v1.2.3 (Build 45)'));
    });
  });
}
