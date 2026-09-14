import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/constants/feedback_config.dart';

void main() {
  group('AppConfig Unit Tests', () {
    test('verifies company support contact configurations', () {
      expect(AppConfig.websiteUrl, 'https://www.impulseagrisciencelimited.com');
      expect(AppConfig.supportEmail, 'impulseagriscienceltd@gmail.com');
      expect(AppConfig.supportPhone, '+880-1629-389015');
    });

    test('verifies rating feedback contact configurations', () {
      expect(AppConfig.defaultFeedbackEmail, 'impulsepmd@gmail.com');
      expect(AppConfig.defaultFeedbackWhatsApp, 'https://wa.me/8801613716307');
      expect(AppConfig.feedbackEmail, 'impulsepmd@gmail.com');
      expect(AppConfig.feedbackWhatsApp, 'https://wa.me/8801613716307');
    });

    test('verifies legal and Play Store URLs', () {
      expect(
        AppConfig.privacyPolicyUrl,
        'https://github.com/wasikulaminbipu/impulse_app/blob/main/PRIVACY_POLICY.md',
      );
      expect(
        AppConfig.dataDeletionUrl,
        'https://www.impulseagrisciencelimited.com/delete-account',
      );
      expect(
        AppConfig.playStoreUrl,
        'https://play.google.com/store/apps/details?id=com.impulseagriscienceltd.impulse_app',
      );
      expect(
        AppConfig.playStoreMarketUrl,
        'market://details?id=com.impulseagriscienceltd.impulse_app',
      );
    });

    test('verifies rating prompt heuristics', () {
      expect(AppConfig.minSessionsBeforeRatingPrompt, 5);
      expect(AppConfig.ratingPromptCooldown, const Duration(days: 60));
    });

    test('verifies product category identifiers', () {
      expect(AppConfig.categoryFeedAdditives, 'Feed Additives');
      expect(AppConfig.categoryFeedAdditive, 'Feed Additive');
      expect(AppConfig.categoryVaccine, 'Vaccine');
      expect(AppConfig.categoryVaccines, 'Vaccines');
      expect(AppConfig.categoryPoultry, 'Poultry');
      expect(AppConfig.categoryCattle, 'Cattle');
      expect(AppConfig.categoryAqua, 'Aqua');
      expect(AppConfig.categoryAll, 'All');
    });

    test('backward compatibility aliases match AppConfig exactly', () {
      expect(AppConstants.feedbackEmail, AppConfig.feedbackEmail);
      expect(AppConstants.feedbackWhatsApp, AppConfig.feedbackWhatsApp);
      expect(FeedbackConfig.email, AppConfig.feedbackEmail);
      expect(FeedbackConfig.whatsApp, AppConfig.feedbackWhatsApp);
    });

    test('buildEmailUri creates valid mailto Uri', () {
      final uri = AppConfig.buildEmailUri(
        subject: 'General Feedback',
        body: 'Here is my review',
      );
      expect(uri.scheme, 'mailto');
      expect(uri.path, 'impulsepmd@gmail.com');
      expect(uri.queryParameters['subject'], 'General Feedback');
      expect(uri.queryParameters['body'], 'Here is my review');
    });

    test('buildWhatsAppUri creates valid wa.me Uri with clean phone', () {
      final uri = AppConfig.buildWhatsAppUri(message: 'Hello Support Team!');
      expect(uri.scheme, 'https');
      expect(uri.host, 'wa.me');
      expect(uri.path, '/8801613716307');
      expect(uri.queryParameters['text'], 'Hello Support Team!');
    });
  });
}
