/// Centralized Application Configuration
///
/// This file is the single source of truth for all configurable application data.
/// Modify the values in this file to update contact channels, URLs, store links,
/// feedback routing, and prompt heuristics across the entire app.
///
/// ### 🛠️ Easy Customization Guide:
/// 1. **Direct File Edit (Permanent)**: Simply change the values below and save.
/// 2. **Build-Time Override (No code change)**: Pass `--dart-define` flags:
///    ```bash
///    flutter run --dart-define=FEEDBACK_EMAIL=your_email@gmail.com --dart-define=FEEDBACK_WHATSAPP=https://wa.me/8801...
///    ```
abstract final class AppConfig {
  // ===========================================================================
  // 1. Company & General Support Channels
  // ===========================================================================
  static const String companyName = 'Impulse Agriscience Ltd.';
  static const String defaultCompanyAddress =
      'House# 459, Road# 31, New DOHS, Mohakhali, Dhaka-1212, Bangladesh';
  static const String companyAddress = String.fromEnvironment(
    'COMPANY_ADDRESS',
    defaultValue: defaultCompanyAddress,
  );
  static const String websiteUrl = 'https://www.impulseagrisciencelimited.com';
  static const String websiteCleanUrl = 'www.impulseagrisciencelimited.com';
  static const String supportEmail = 'impulseagriscienceltd@gmail.com';
  static const String supportPhone = '+880-1629-389015';

  // ===========================================================================
  // 2. User Feedback & Rating Channels (Low Star 1, 2, 3)
  // ===========================================================================
  /// Default recipient email address for product feedback & suggestions.
  static const String defaultFeedbackEmail = 'impulsepmd@gmail.com';

  /// Default WhatsApp direct contact link or phone number for customer feedback.
  static const String defaultFeedbackWhatsApp = 'https://wa.me/8801613716307';

  /// Active feedback email address (can be overridden via `--dart-define=FEEDBACK_EMAIL=...`).
  static const String feedbackEmail = String.fromEnvironment(
    'FEEDBACK_EMAIL',
    defaultValue: defaultFeedbackEmail,
  );

  /// Active WhatsApp link or phone (can be overridden via `--dart-define=FEEDBACK_WHATSAPP=...`).
  static const String feedbackWhatsApp = String.fromEnvironment(
    'FEEDBACK_WHATSAPP',
    defaultValue: defaultFeedbackWhatsApp,
  );

  // Convenient aliases for feedback configuration
  static const String defaultEmail = defaultFeedbackEmail;
  static const String defaultWhatsApp = defaultFeedbackWhatsApp;
  static const String email = feedbackEmail;
  static const String whatsApp = feedbackWhatsApp;

  // ===========================================================================
  // 3. Legal & Compliance URLs
  // ===========================================================================
  static const String privacyPolicyUrl =
      'https://github.com/wasikulaminbipu/impulse_app/blob/main/PRIVACY_POLICY.md';
  static const String dataDeletionUrl =
      'https://www.impulseagrisciencelimited.com/delete-account';

  // ===========================================================================
  // 4. Google Play Store Links
  // ===========================================================================
  static const String playStorePackageName =
      'com.impulseagriscienceltd.impulse_app';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.impulseagriscienceltd.impulse_app';
  static const String playStoreMarketUrl =
      'market://details?id=com.impulseagriscienceltd.impulse_app';

  // ===========================================================================
  // 5. Rating Prompt Heuristics & Safeguards
  // ===========================================================================
  /// Minimum sessions before automated rating prompt can appear.
  static const int minSessionsBeforeRatingPrompt = 5;

  /// Cooldown window if user postpones rating prompt (60 days).
  static const Duration ratingPromptCooldown = Duration(days: 60);

  // ===========================================================================
  // 6. Canonical Product Category Identifiers
  // ===========================================================================
  static const String categoryFeedAdditives = 'Feed Additives';
  static const String categoryFeedAdditive = 'Feed Additive';
  static const String categoryVaccine = 'Vaccine';
  static const String categoryVaccines = 'Vaccines';
  static const String categoryPoultry = 'Poultry';
  static const String categoryCattle = 'Cattle';
  static const String categoryAqua = 'Aqua';
  static const String categoryAll = 'All';

  // ===========================================================================
  // 7. URI Builders & Helpers
  // ===========================================================================
  /// Builds a proper mailto [Uri] with optional [subject] and [body].
  static Uri buildEmailUri({String? recipient, String? subject, String? body}) {
    final to = (recipient != null && recipient.trim().isNotEmpty)
        ? recipient.trim()
        : feedbackEmail;
    final content = body?.trim() ?? '';
    return Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (content.isNotEmpty) 'body': content,
      },
    );
  }

  /// Builds a proper WhatsApp [Uri] with optional [message].
  ///
  /// Automatically parses either full URLs (e.g. `https://wa.me/8801613716307`)
  /// or raw telephone numbers (e.g. `8801613716307` or `+880-1613-716307`).
  static Uri buildWhatsAppUri({String? customTarget, String? message}) {
    final target = (customTarget != null && customTarget.trim().isNotEmpty)
        ? customTarget.trim()
        : feedbackWhatsApp;

    final digits = target.replaceAll(RegExp('[^0-9]'), '');
    final cleanPhone = digits.isNotEmpty ? digits : '8801613716307';

    final queryParams = <String, String>{};
    if (message != null && message.trim().isNotEmpty) {
      queryParams['text'] = message.trim();
    }

    return Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/$cleanPhone',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  /// Alias for [buildEmailUri].
  static Uri buildFeedbackEmailUri({
    String? recipient,
    String? subject,
    String? body,
  }) => buildEmailUri(recipient: recipient, subject: subject, body: body);

  /// Alias for [buildWhatsAppUri].
  static Uri buildFeedbackWhatsAppUri({
    String? customTarget,
    String? message,
  }) => buildWhatsAppUri(customTarget: customTarget, message: message);
}
