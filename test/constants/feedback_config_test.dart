import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/feedback_config.dart';

void main() {
  group('FeedbackConfig Unit Tests', () {
    test('default email and whatsapp match customer requirements', () {
      expect(FeedbackConfig.defaultEmail, 'impulsepmd@gmail.com');
      expect(FeedbackConfig.defaultWhatsApp, 'https://wa.me/8801613716307');
      expect(FeedbackConfig.email, 'impulsepmd@gmail.com');
      expect(FeedbackConfig.whatsApp, 'https://wa.me/8801613716307');
    });

    test('buildEmailUri creates valid mailto Uri with defaults', () {
      final uri = FeedbackConfig.buildEmailUri(
        subject: 'Feedback Subject',
        body: 'Here is my thoughts',
      );
      expect(uri.scheme, 'mailto');
      expect(uri.path, 'impulsepmd@gmail.com');
      expect(uri.queryParameters['subject'], 'Feedback Subject');
      expect(uri.queryParameters['body'], 'Here is my thoughts');
    });

    test('buildEmailUri respects custom recipient override', () {
      final uri = FeedbackConfig.buildEmailUri(
        recipient: 'custom@domain.com',
        subject: 'Hello',
      );
      expect(uri.scheme, 'mailto');
      expect(uri.path, 'custom@domain.com');
      expect(uri.queryParameters['subject'], 'Hello');
    });

    test('buildWhatsAppUri creates valid wa.me Uri with defaults', () {
      final uri = FeedbackConfig.buildWhatsAppUri(
        message: 'Hello Impulse Team',
      );
      expect(uri.scheme, 'https');
      expect(uri.host, 'wa.me');
      expect(uri.path, '/8801613716307');
      expect(uri.queryParameters['text'], 'Hello Impulse Team');
    });

    test('buildWhatsAppUri handles raw phone number overrides', () {
      final uri = FeedbackConfig.buildWhatsAppUri(
        customTarget: '+880-1700-123456',
        message: 'Testing phone numbers',
      );
      expect(uri.scheme, 'https');
      expect(uri.host, 'wa.me');
      expect(uri.path, '/8801700123456');
      expect(uri.queryParameters['text'], 'Testing phone numbers');
    });

    test('buildWhatsAppUri handles complete URL overrides', () {
      final uri = FeedbackConfig.buildWhatsAppUri(
        customTarget: 'https://wa.me/8801999888777',
      );
      expect(uri.scheme, 'https');
      expect(uri.host, 'wa.me');
      expect(uri.path, '/8801999888777');
      expect(uri.queryParameters['text'], isNull);
    });
  });
}
