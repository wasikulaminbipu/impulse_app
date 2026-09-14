import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:url_launcher/url_launcher.dart';

/// Abstraction layer over [launchUrl] calls to allow clean mocking in tests.
class UrlLauncherWrapper {
  const UrlLauncherWrapper();

  Future<bool> launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) => launchUrl(uri, mode: mode);

  Future<bool> canLaunch(Uri uri) => canLaunchUrl(uri);
}

/// Service handling Play Store review heuristics, feedback routing, and customer comfort safeguards.
class AppReviewService {
  final UrlLauncherWrapper launcher;

  static const String keySessionCount = 'review_session_count';
  static const String keyLastPromptEpoch = 'review_last_prompt_epoch';
  static const String keyUserActionState = 'review_user_action_state';

  static const String stateRated = 'rated';
  static const String stateNever = 'never';
  static const String statePostponed = 'postponed';

  /// Minimum number of app sessions before an automated prompt can be shown.
  static const int minSessionsBeforePrompt = 5;

  /// Cooldown window between prompts if user postponed (60 days).
  static const Duration cooldownInterval = Duration(days: 60);

  const AppReviewService({this.launcher = const UrlLauncherWrapper()});

  /// Records a new app session incrementing the count by 1.
  Future<int> recordSession(AppMaintenanceDao dao) async {
    try {
      final count = await getSessionCount(dao);
      final newCount = count + 1;
      await dao.setSetting(keySessionCount, newCount.toString());
      return newCount;
    } catch (e, st) {
      developer.log(
        'Failed to record review session',
        error: e,
        stackTrace: st,
      );
      return 0;
    }
  }

  /// Retrieves the recorded number of app sessions.
  Future<int> getSessionCount(AppMaintenanceDao dao) async {
    try {
      final str = await dao.getSetting(keySessionCount);
      return str != null ? (int.tryParse(str) ?? 0) : 0;
    } catch (e) {
      return 0;
    }
  }

  /// Determines whether the automatic review dialog should be presented to the user.
  Future<bool> shouldShowPrompt(AppMaintenanceDao dao, {DateTime? now}) async {
    try {
      final state = await dao.getSetting(keyUserActionState);
      if (state == stateRated || state == stateNever) {
        return false;
      }

      final sessionCount = await getSessionCount(dao);
      if (sessionCount < minSessionsBeforePrompt) {
        return false;
      }

      final lastPromptStr = await dao.getSetting(keyLastPromptEpoch);
      if (lastPromptStr != null) {
        final lastEpoch = int.tryParse(lastPromptStr);
        if (lastEpoch != null) {
          final lastPromptDate = DateTime.fromMillisecondsSinceEpoch(lastEpoch);
          final currentDate = now ?? DateTime.now();
          if (currentDate.difference(lastPromptDate) < cooldownInterval) {
            return false;
          }
        }
      }

      return true;
    } catch (e, st) {
      developer.log(
        'Error evaluating review prompt eligibility',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  /// Marks that the prompt was displayed to the user.
  Future<void> markPromptShown(AppMaintenanceDao dao, {DateTime? now}) async {
    try {
      final epoch = (now ?? DateTime.now()).millisecondsSinceEpoch;
      await dao.setSetting(keyLastPromptEpoch, epoch.toString());
    } catch (e) {
      debugPrint('Failed to mark review prompt shown: $e');
    }
  }

  /// Marks that the user gave a positive rating or reviewed the app.
  Future<void> markRated(AppMaintenanceDao dao) async {
    try {
      await dao.setSetting(keyUserActionState, stateRated);
    } catch (e) {
      debugPrint('Failed to mark rated: $e');
    }
  }

  /// Marks that the user chose "Don't ask again".
  Future<void> markNeverAskAgain(AppMaintenanceDao dao) async {
    try {
      await dao.setSetting(keyUserActionState, stateNever);
    } catch (e) {
      debugPrint('Failed to mark never ask again: $e');
    }
  }

  /// Marks that the user postponed the prompt ("Maybe Later").
  Future<void> markPostponed(AppMaintenanceDao dao, {DateTime? now}) async {
    try {
      final epoch = (now ?? DateTime.now()).millisecondsSinceEpoch;
      await dao.setSetting(keyUserActionState, statePostponed);
      await dao.setSetting(keyLastPromptEpoch, epoch.toString());
    } catch (e) {
      debugPrint('Failed to mark review postponed: $e');
    }
  }

  /// Opens Google Play Store listing (first attempting market://, fallback to https://).
  Future<bool> openPlayStoreListing({
    UrlLauncherWrapper? customLauncher,
  }) async {
    final l = customLauncher ?? launcher;
    try {
      final marketUri = Uri.parse(AppConstants.playStoreMarketUrl);
      if (await l.canLaunch(marketUri)) {
        return await l.launch(marketUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Fall through to HTTPS URL
    }

    try {
      final webUri = Uri.parse(AppConstants.playStoreUrl);
      return await l.launch(webUri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      developer.log('Failed to open Play Store URL', error: e, stackTrace: st);
      return false;
    }
  }

  /// Opens the customer support email composer with prefilled subject.
  Future<bool> openFeedbackEmail({
    UrlLauncherWrapper? customLauncher,
    String? subject,
    String? body,
  }) async {
    final l = customLauncher ?? launcher;
    final sub = subject ?? 'Impulse App Feedback & Suggestions';
    final content = body ?? '';
    final emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      queryParameters: {
        'subject': sub,
        if (content.isNotEmpty) 'body': content,
      },
    );

    try {
      return await l.launch(emailUri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      developer.log('Failed to open email client', error: e, stackTrace: st);
      return false;
    }
  }

  /// Opens WhatsApp to chat directly with support.
  Future<bool> openFeedbackWhatsApp({
    UrlLauncherWrapper? customLauncher,
    String? message,
  }) async {
    final l = customLauncher ?? launcher;
    final cleanPhone = AppConstants.supportPhone.replaceAll(
      RegExp('[^0-9]'),
      '',
    );
    final msg = message ?? 'Hello Impulse Team, I have some feedback: ';
    final waUri = Uri.parse(
      'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(msg)}',
    );

    try {
      return await l.launch(waUri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      developer.log('Failed to open WhatsApp', error: e, stackTrace: st);
      return false;
    }
  }
}
