import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/providers/app_update_provider.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/services/app_update_service.dart';
import 'package:in_app_update/in_app_update.dart';

class FakeTestUpdateService extends AppUpdateService {
  final AppUpdateInfo? infoToReturn;
  final bool failFlexible;
  bool completeCalled = false;

  FakeTestUpdateService({this.infoToReturn, this.failFlexible = false});

  @override
  Future<bool> shouldCheckForUpdate(dynamic dao, {DateTime? now}) async => true;

  @override
  Future<void> recordUpdateChecked(dynamic dao, {DateTime? now}) async {}

  @override
  Future<AppUpdateInfo?> checkForUpdate() async => infoToReturn;

  @override
  Future<AppUpdateResult?> startFlexibleUpdate() async {
    return failFlexible ? null : AppUpdateResult.success;
  }

  @override
  Future<bool> completeFlexibleUpdate() async {
    completeCalled = true;
    return true;
  }

  @override
  Future<bool> shouldPromptUser(
    dynamic dao,
    int versionCode, {
    DateTime? now,
  }) async => false; // Prevents opening modal in headless container test

  @override
  Future<void> recordPromptDismissed(
    dynamic dao,
    int versionCode, {
    DateTime? now,
  }) async {}
}

void main() {
  group('AppUpdateNotifier Provider Tests', () {
    late AppMaintenanceDb db;
    late ProviderContainer container;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('initial state is idle and hasUpdate is false', () {
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
        ],
      );

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.idle));
      expect(state.hasUpdate, isFalse);
    });

    test('checkAndPromptUpdate remains idle if no update available', () async {
      final fakeService = FakeTestUpdateService();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container
          .read(appUpdateProvider.notifier)
          .checkAndPromptUpdate(force: true);

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.idle));
      expect(state.hasUpdate, isFalse);
    });

    test('flexible update download and completion updates state', () async {
      final fakeService = FakeTestUpdateService();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).startFlexibleUpdate();

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.downloaded));
      expect(state.hasUpdate, isTrue);

      await container.read(appUpdateProvider.notifier).completeFlexibleUpdate();

      expect(fakeService.completeCalled, isTrue);
    });

    test('startFlexibleUpdate reverts to available on failure', () async {
      final fakeService = FakeTestUpdateService(failFlexible: true);
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).startFlexibleUpdate();

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.available));
    });
  });
}
