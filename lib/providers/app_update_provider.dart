import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/constants/app_keys.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_version_provider.dart';
import 'package:impulse_app/services/app_update_service.dart';
import 'package:impulse_app/widgets/update_prompt_sheet.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _showSnackBar(SnackBar snackBar) {
    try {
      AppKeys.rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
      AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    } catch (_) {
      // Safely ignore if running in pure headless unit tests
    }
  }

  void _hideSnackBar() {
    try {
      AppKeys.rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    } catch (_) {
      // Safely ignore if running in pure headless unit tests
    }
  }

  /// Evaluates update availability and prompts the user if appropriate.
  /// Any errors (network, debug environment, platform) are handled gracefully.
  Future<void> checkAndPromptUpdate({
    BuildContext? context,
    bool force = false,
  }) async {
    final lang = ref.read(languageSettingProvider);
    final isBn = lang == 'bn';
    final appVersion = ref.read(appVersionDisplayProvider);

    if (force) {
      _showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isBn ? 'আপডেট পরীক্ষা করা হচ্ছে...' : 'Checking for updates...',
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

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

    if (!ref.mounted) return;
    state = state.copyWith(status: UpdateStatus.checking);

    await service.recordUpdateChecked(dao);
    final info = await service.checkForUpdate();

    if (!ref.mounted) return;

    BuildContext? targetContext = (context != null && context.mounted)
        ? context
        : null;
    if (targetContext == null) {
      try {
        targetContext = AppKeys.rootNavigatorKey.currentContext;
      } catch (_) {
        targetContext = null;
      }
    }

    if (info == null ||
        info.updateAvailability != UpdateAvailability.updateAvailable) {
      state = state.copyWith(status: UpdateStatus.idle);
      if (force) {
        _showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.greenAccent,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isBn
                        ? 'আপনার অ্যাপটি আপ-টু-ডেট রয়েছে (v$appVersion)।'
                        : 'Your app is up to date (v$appVersion).',
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: isBn ? 'প্লে স্টোর' : 'Play Store',
              textColor: Colors.amberAccent,
              onPressed: () async {
                final uri = Uri.parse(AppConstants.playStoreUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ),
        );
      }
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

    if (force) {
      _hideSnackBar();
    }

    if (isImmediate) {
      await service.performImmediateUpdate();
      return;
    }

    final versionCode = info.availableVersionCode ?? 0;
    final shouldPrompt =
        force || await service.shouldPromptUser(dao, versionCode);

    if (shouldPrompt && targetContext != null && targetContext.mounted) {
      await showModalBottomSheet<void>(
        context: targetContext,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => UpdatePromptSheet(
          availableVersionCode: versionCode,
          stalenessDays: info.clientVersionStalenessDays,
          onUpdateNow: () {
            Navigator.of(ctx).pop();
            startFlexibleUpdate(context: targetContext);
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
