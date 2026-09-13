import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/services/app_update_service.dart';
import 'package:impulse_app/widgets/update_prompt_sheet.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_update_provider.g.dart';

enum UpdateStatus { idle, checking, available, downloading, downloaded }

class AppUpdateState {
  final UpdateStatus status;
  final AppUpdateInfo? updateInfo;
  final bool isImmediateRequired;

  const AppUpdateState({
    this.status = UpdateStatus.idle,
    this.updateInfo,
    this.isImmediateRequired = false,
  });

  AppUpdateState copyWith({
    UpdateStatus? status,
    AppUpdateInfo? updateInfo,
    bool? isImmediateRequired,
  }) {
    return AppUpdateState(
      status: status ?? this.status,
      updateInfo: updateInfo ?? this.updateInfo,
      isImmediateRequired: isImmediateRequired ?? this.isImmediateRequired,
    );
  }

  bool get hasUpdate =>
      status == UpdateStatus.available ||
      status == UpdateStatus.downloading ||
      status == UpdateStatus.downloaded;
}

@Riverpod(keepAlive: true)
AppUpdateService appUpdateService(Ref ref) {
  return const AppUpdateService();
}

@Riverpod(keepAlive: true)
class AppUpdateNotifier extends _$AppUpdateNotifier {
  @override
  AppUpdateState build() {
    return const AppUpdateState();
  }

  /// Evaluates update availability and prompts the user if appropriate.
  /// Any errors (network, debug environment, platform) are handled silently.
  Future<void> checkAndPromptUpdate({
    BuildContext? context,
    bool force = false,
  }) async {
    final service = ref.read(appUpdateServiceProvider);
    final dao = await ref.read(appMaintenanceDaoProvider.future);

    if (!force) {
      final shouldCheck = await service.shouldCheckForUpdate(dao);
      if (!shouldCheck) {
        developer.log(
          'Update check debounced within 24 hours',
          name: 'AppUpdateNotifier',
        );
        return;
      }
    }

    state = state.copyWith(status: UpdateStatus.checking);

    await service.recordUpdateChecked(dao);
    final info = await service.checkForUpdate();

    if (info == null ||
        info.updateAvailability != UpdateAvailability.updateAvailable) {
      state = state.copyWith(status: UpdateStatus.idle);
      return;
    }

    final isImmediate =
        info.immediateUpdateAllowed &&
        (info.updatePriority >= 4 || !info.flexibleUpdateAllowed);

    state = state.copyWith(
      status: UpdateStatus.available,
      updateInfo: info,
      isImmediateRequired: isImmediate,
    );

    if (isImmediate) {
      await service.performImmediateUpdate();
      return;
    }

    final versionCode = info.availableVersionCode ?? 0;
    final shouldPrompt =
        force || await service.shouldPromptUser(dao, versionCode);

    if (shouldPrompt && context != null && context.mounted) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => UpdatePromptSheet(
          availableVersionCode: versionCode,
          stalenessDays: info.clientVersionStalenessDays,
          onUpdateNow: () {
            Navigator.of(ctx).pop();
            startFlexibleUpdate(context: context);
          },
          onRemindLater: () {
            dismissPrompt(versionCode);
            Navigator.of(ctx).pop();
          },
        ),
      );
    }
  }

  /// Begins a flexible in-app update download in the background.
  Future<void> startFlexibleUpdate({BuildContext? context}) async {
    final service = ref.read(appUpdateServiceProvider);
    state = state.copyWith(status: UpdateStatus.downloading);

    final result = await service.startFlexibleUpdate();

    if (result == AppUpdateResult.success) {
      state = state.copyWith(status: UpdateStatus.downloaded);
    } else {
      // Revert to available so user can retry or update via store
      state = state.copyWith(status: UpdateStatus.available);
    }
  }

  /// Installs downloaded flexible update and restarts the app.
  Future<void> completeFlexibleUpdate() async {
    final service = ref.read(appUpdateServiceProvider);
    final success = await service.completeFlexibleUpdate();
    if (!success) {
      state = state.copyWith(status: UpdateStatus.available);
    }
  }

  /// Records prompt dismissal to suppress popup for 24 hours.
  Future<void> dismissPrompt(int versionCode) async {
    final service = ref.read(appUpdateServiceProvider);
    final dao = await ref.read(appMaintenanceDaoProvider.future);
    await service.recordPromptDismissed(dao, versionCode);
  }
}
