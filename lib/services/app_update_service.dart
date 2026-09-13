import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:in_app_update/in_app_update.dart';

/// Abstraction layer over [InAppUpdate] platform calls to allow mocking in tests
/// and centralized silent error containment.
class InAppUpdatePlatformWrapper {
  const InAppUpdatePlatformWrapper();

  Future<AppUpdateInfo> checkForUpdate() => InAppUpdate.checkForUpdate();

  Future<AppUpdateResult> startFlexibleUpdate() =>
      InAppUpdate.startFlexibleUpdate();

  Future<void> completeFlexibleUpdate() => InAppUpdate.completeFlexibleUpdate();

  Future<AppUpdateResult> performImmediateUpdate() =>
      InAppUpdate.performImmediateUpdate();
}

/// Service handling Google Play In-App Updates, debounce caching, and silent error handling.
class AppUpdateService {
  final InAppUpdatePlatformWrapper platformWrapper;

  static const String keyLastUpdateCheckEpoch = 'last_update_check_epoch';
  static const String keyLastDismissedEpoch = 'last_update_dismissed_epoch';
  static const String keyLastDismissedVersion = 'last_dismissed_version_code';

  /// Default debounce window: 24 hours.
  static const Duration debounceInterval = Duration(hours: 24);

  const AppUpdateService({
    this.platformWrapper = const InAppUpdatePlatformWrapper(),
  });

  /// Checks if an update check should be performed based on the 24-hour debounce window.
  Future<bool> shouldCheckForUpdate(
    AppMaintenanceDao dao, {
    DateTime? now,
  }) async {
    try {
      final lastCheckStr = await dao.getSetting(keyLastUpdateCheckEpoch);
      if (lastCheckStr == null) return true;

      final lastCheckEpoch = int.tryParse(lastCheckStr);
      if (lastCheckEpoch == null) return true;

      final lastCheckDate = DateTime.fromMillisecondsSinceEpoch(lastCheckEpoch);
      final currentDate = now ?? DateTime.now();

      return currentDate.difference(lastCheckDate) >= debounceInterval;
    } catch (e) {
      // In case of any database error, default to true to permit check
      return true;
    }
  }

  /// Records the timestamp of an update check.
  Future<void> recordUpdateChecked(
    AppMaintenanceDao dao, {
    DateTime? now,
  }) async {
    try {
      final currentEpoch = (now ?? DateTime.now()).millisecondsSinceEpoch;
      await dao.setSetting(keyLastUpdateCheckEpoch, currentEpoch.toString());
    } catch (e) {
      // Silently ignore storage errors
      developer.log(
        'Failed to record update check epoch: $e',
        name: 'AppUpdateService',
      );
    }
  }

  /// Checks if the user should be prompted for this specific [versionCode].
  /// Returns false if the user dismissed this version within the last 24 hours.
  Future<bool> shouldPromptUser(
    AppMaintenanceDao dao,
    int versionCode, {
    DateTime? now,
  }) async {
    try {
      final lastDismissedVersionStr = await dao.getSetting(
        keyLastDismissedVersion,
      );
      final lastDismissedEpochStr = await dao.getSetting(keyLastDismissedEpoch);

      if (lastDismissedVersionStr == null || lastDismissedEpochStr == null) {
        return true;
      }

      final lastDismissedVersion = int.tryParse(lastDismissedVersionStr);
      final lastDismissedEpoch = int.tryParse(lastDismissedEpochStr);

      if (lastDismissedVersion != versionCode || lastDismissedEpoch == null) {
        return true;
      }

      final dismissedDate = DateTime.fromMillisecondsSinceEpoch(
        lastDismissedEpoch,
      );
      final currentDate = now ?? DateTime.now();

      return currentDate.difference(dismissedDate) >= debounceInterval;
    } catch (e) {
      return true;
    }
  }

  /// Records that the user dismissed the update prompt for [versionCode].
  Future<void> recordPromptDismissed(
    AppMaintenanceDao dao,
    int versionCode, {
    DateTime? now,
  }) async {
    try {
      final currentEpoch = (now ?? DateTime.now()).millisecondsSinceEpoch;
      await dao.setSetting(keyLastDismissedEpoch, currentEpoch.toString());
      await dao.setSetting(keyLastDismissedVersion, versionCode.toString());
    } catch (e) {
      developer.log(
        'Failed to record prompt dismissal: $e',
        name: 'AppUpdateService',
      );
    }
  }

  /// Checks Google Play for an available update.
  /// Returns [AppUpdateInfo] if available, or `null` if no update or if any error occurs
  /// (such as offline, running in debug, sideloaded build, or unsupported device).
  Future<AppUpdateInfo?> checkForUpdate() async {
    // In-app updates only operate on Android
    if (defaultTargetPlatform != TargetPlatform.android) {
      return null;
    }

    try {
      final info = await platformWrapper.checkForUpdate();
      return info;
    } catch (error, stackTrace) {
      // Silent error handling: Never crash or alert the user
      developer.log(
        'InAppUpdate check silently swallowed: $error',
        name: 'AppUpdateService',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Starts a flexible update in the background.
  /// Returns [AppUpdateResult.success] on initiation or null on failure.
  Future<AppUpdateResult?> startFlexibleUpdate() async {
    try {
      return await platformWrapper.startFlexibleUpdate();
    } catch (error, stackTrace) {
      developer.log(
        'InAppUpdate startFlexibleUpdate silently swallowed: $error',
        name: 'AppUpdateService',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Completes the downloaded flexible update, restarting the app.
  Future<bool> completeFlexibleUpdate() async {
    try {
      await platformWrapper.completeFlexibleUpdate();
      return true;
    } catch (error, stackTrace) {
      developer.log(
        'InAppUpdate completeFlexibleUpdate silently swallowed: $error',
        name: 'AppUpdateService',
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// Initiates an immediate, full-screen update flow.
  Future<AppUpdateResult?> performImmediateUpdate() async {
    try {
      return await platformWrapper.performImmediateUpdate();
    } catch (error, stackTrace) {
      developer.log(
        'InAppUpdate performImmediateUpdate silently swallowed: $error',
        name: 'AppUpdateService',
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}
