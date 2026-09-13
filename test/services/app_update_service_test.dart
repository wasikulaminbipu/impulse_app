import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:impulse_app/services/app_update_service.dart';
import 'package:in_app_update/in_app_update.dart';

class FakePlatformWrapper extends InAppUpdatePlatformWrapper {
  AppUpdateInfo? fakeInfo;
  bool shouldThrow = false;
  bool flexibleStarted = false;
  bool flexibleCompleted = false;
  bool immediatePerformed = false;

  FakePlatformWrapper({this.fakeInfo, this.shouldThrow = false});

  @override
  Future<AppUpdateInfo> checkForUpdate() async {
    if (shouldThrow) {
      throw PlatformException(
        code: 'ERROR_API_NOT_AVAILABLE',
        message: 'Google Play Store not found',
      );
    }
    if (fakeInfo != null) return fakeInfo!;
    throw PlatformException(code: 'NO_INFO');
  }

  @override
  Future<AppUpdateResult> startFlexibleUpdate() async {
    if (shouldThrow) {
      throw PlatformException(code: 'START_FAILED');
    }
    flexibleStarted = true;
    return AppUpdateResult.success;
  }

  @override
  Future<void> completeFlexibleUpdate() async {
    if (shouldThrow) {
      throw PlatformException(code: 'COMPLETE_FAILED');
    }
    flexibleCompleted = true;
  }

  @override
  Future<AppUpdateResult> performImmediateUpdate() async {
    if (shouldThrow) {
      throw PlatformException(code: 'IMMEDIATE_FAILED');
    }
    immediatePerformed = true;
    return AppUpdateResult.success;
  }
}

void main() {
  group('AppUpdateService Unit Tests', () {
    late AppMaintenanceDb db;
    late AppMaintenanceDao dao;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      dao = AppMaintenanceDao(db);
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'shouldCheckForUpdate returns true when no prior check exists',
      () async {
        const service = AppUpdateService();
        final shouldCheck = await service.shouldCheckForUpdate(dao);
        expect(shouldCheck, isTrue);
      },
    );

    test('shouldCheckForUpdate obeys 24-hour debounce window', () async {
      const service = AppUpdateService();
      final now = DateTime(2026, 9, 12, 12);

      // Record check at t = 0
      await service.recordUpdateChecked(dao, now: now);

      // Check 5 hours later -> debounced (false)
      final check5h = await service.shouldCheckForUpdate(
        dao,
        now: now.add(const Duration(hours: 5)),
      );
      expect(check5h, isFalse);

      // Check 25 hours later -> permitted (true)
      final check25h = await service.shouldCheckForUpdate(
        dao,
        now: now.add(const Duration(hours: 25)),
      );
      expect(check25h, isTrue);
    });

    test('shouldPromptUser suppresses repeated prompts for 24 hours', () async {
      const service = AppUpdateService();
      final now = DateTime(2026, 9, 12, 12);
      const testVersion = 42;

      // Before dismissal: should prompt
      final beforeDismiss = await service.shouldPromptUser(
        dao,
        testVersion,
        now: now,
      );
      expect(beforeDismiss, isTrue);

      // Record dismissal
      await service.recordPromptDismissed(dao, testVersion, now: now);

      // Within 24 hours: should not prompt
      final suppressed = await service.shouldPromptUser(
        dao,
        testVersion,
        now: now.add(const Duration(hours: 12)),
      );
      expect(suppressed, isFalse);

      // Different version code: should prompt even within 24h
      final differentVersion = await service.shouldPromptUser(
        dao,
        99,
        now: now.add(const Duration(hours: 12)),
      );
      expect(differentVersion, isTrue);

      // After 24 hours: prompt re-allowed
      final after24h = await service.shouldPromptUser(
        dao,
        testVersion,
        now: now.add(const Duration(hours: 25)),
      );
      expect(after24h, isTrue);
    });

    test(
      'checkForUpdate catches platform exceptions silently without throwing',
      () async {
        final fakeWrapper = FakePlatformWrapper(shouldThrow: true);
        final service = AppUpdateService(platformWrapper: fakeWrapper);

        // Should return null and not throw
        final result = await service.checkForUpdate();
        expect(result, isNull);
      },
    );

    test(
      'startFlexibleUpdate catches errors silently and returns null',
      () async {
        final fakeWrapper = FakePlatformWrapper(shouldThrow: true);
        final service = AppUpdateService(platformWrapper: fakeWrapper);

        final result = await service.startFlexibleUpdate();
        expect(result, isNull);
      },
    );

    test(
      'completeFlexibleUpdate catches errors silently and returns false',
      () async {
        final fakeWrapper = FakePlatformWrapper(shouldThrow: true);
        final service = AppUpdateService(platformWrapper: fakeWrapper);

        final success = await service.completeFlexibleUpdate();
        expect(success, isFalse);
      },
    );

    test(
      'performImmediateUpdate catches errors silently and returns null',
      () async {
        final fakeWrapper = FakePlatformWrapper(shouldThrow: true);
        final service = AppUpdateService(platformWrapper: fakeWrapper);

        final result = await service.performImmediateUpdate();
        expect(result, isNull);
      },
    );

    test(
      'Flexible and Immediate updates execute successfully on wrapper',
      () async {
        final fakeWrapper = FakePlatformWrapper();
        final service = AppUpdateService(platformWrapper: fakeWrapper);

        final startResult = await service.startFlexibleUpdate();
        expect(startResult, equals(AppUpdateResult.success));
        expect(fakeWrapper.flexibleStarted, isTrue);

        final completeResult = await service.completeFlexibleUpdate();
        expect(completeResult, isTrue);
        expect(fakeWrapper.flexibleCompleted, isTrue);

        final immediateResult = await service.performImmediateUpdate();
        expect(immediateResult, equals(AppUpdateResult.success));
        expect(fakeWrapper.immediatePerformed, isTrue);
      },
    );
  });
}
