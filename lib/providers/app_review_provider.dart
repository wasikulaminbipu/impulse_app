import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_update_provider.dart';
import 'package:impulse_app/services/app_review_service.dart';
import 'package:impulse_app/widgets/feedback_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_review_provider.g.dart';

@Riverpod(keepAlive: true)
AppReviewService appReviewService(Ref ref) {
  return const AppReviewService();
}

@Riverpod(keepAlive: true)
class AppReviewNotifier extends _$AppReviewNotifier {
  @override
  void build() {
    // Stateless notifier managing review prompt side-effects
  }

  /// Records an app session and evaluates whether to display the review dialog.
  /// Strictly non-intrusive: does not prompt if an update is available or required.
  Future<void> recordSessionAndCheckPrompt({
    required BuildContext context,
  }) async {
    try {
      final dao = await ref.read(appMaintenanceDaoProvider.future);
      final service = ref.read(appReviewServiceProvider);

      await service.recordSession(dao);

      // Check if update prompt is currently pending or active
      final updateState = ref.read(appUpdateProvider);
      if (updateState.hasUpdate) {
        return;
      }

      final shouldPrompt = await service.shouldShowPrompt(dao);
      if (!shouldPrompt) return;

      // Ensure the widget tree is still mounted before showing the dialog
      if (!context.mounted) return;

      await service.markPromptShown(dao);

      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => const FeedbackDialog(),
      );
    } catch (e, st) {
      developer.log(
        'Error in recordSessionAndCheckPrompt',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Direct user-initiated request to open the Play Store review page.
  Future<bool> openPlayStore() async {
    try {
      final dao = await ref.read(appMaintenanceDaoProvider.future);
      final service = ref.read(appReviewServiceProvider);
      await service.markRated(dao);
      return await service.openPlayStoreListing();
    } catch (e, st) {
      developer.log('Failed to open Play Store', error: e, stackTrace: st);
      return false;
    }
  }

  /// Handles user email feedback route.
  Future<bool> sendFeedbackEmail({
    String? feedback,
    String? recipientEmail,
  }) async {
    final service = ref.read(appReviewServiceProvider);
    return await service.openFeedbackEmail(
      recipientEmail: recipientEmail,
      subject: 'Impulse App Feedback & User Experience',
      body: feedback,
    );
  }

  /// Handles user WhatsApp feedback route.
  Future<bool> sendFeedbackWhatsApp({
    String? feedback,
    String? whatsAppTarget,
  }) async {
    final service = ref.read(appReviewServiceProvider);
    return await service.openFeedbackWhatsApp(
      whatsAppTarget: whatsAppTarget,
      message: feedback != null && feedback.isNotEmpty
          ? 'Hello Impulse Team, here is my feedback: $feedback'
          : null,
    );
  }

  /// Marks the prompt as postponed (Maybe Later, 60 day cooldown).
  Future<void> markPostponed() async {
    try {
      final dao = await ref.read(appMaintenanceDaoProvider.future);
      final service = ref.read(appReviewServiceProvider);
      await service.markPostponed(dao);
    } catch (e) {
      debugPrint('Failed to mark review postponed: $e');
    }
  }

  /// Marks the prompt as permanently declined (Don't ask again).
  Future<void> markNeverAskAgain() async {
    try {
      final dao = await ref.read(appMaintenanceDaoProvider.future);
      final service = ref.read(appReviewServiceProvider);
      await service.markNeverAskAgain(dao);
    } catch (e) {
      debugPrint('Failed to mark review never ask again: $e');
    }
  }

  /// Marks that the user completed a positive rating.
  Future<void> markRated() async {
    try {
      final dao = await ref.read(appMaintenanceDaoProvider.future);
      final service = ref.read(appReviewServiceProvider);
      await service.markRated(dao);
    } catch (e) {
      debugPrint('Failed to mark rated: $e');
    }
  }
}
