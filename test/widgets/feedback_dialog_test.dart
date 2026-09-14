import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/widgets/feedback_dialog.dart';

class MockLanguageSettingEn extends LanguageSetting {
  @override
  String build() => 'en';
}

class MockLanguageSettingBn extends LanguageSetting {
  @override
  String build() => 'bn';
}

void main() {
  group('FeedbackDialog Widget Tests', () {
    testWidgets('renders initial state in English with 5 outline stars', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
          ],
          child: const MaterialApp(home: Scaffold(body: FeedbackDialog())),
        ),
      );

      expect(find.text('Enjoying Impulse?'), findsOneWidget);
      expect(
        find.text(
          'How has your experience been? Tap a star to share your rating.',
        ),
        findsOneWidget,
      );

      // Verify all 5 stars exist
      for (int i = 1; i <= 5; i++) {
        expect(find.byKey(Key('feedback_star_$i')), findsOneWidget);
      }

      // Initial state has no Play Store or Support action buttons
      expect(find.byKey(const Key('feedback_play_store_button')), findsNothing);
      expect(find.byKey(const Key('feedback_email_button')), findsNothing);

      // Verify Maybe Later and Don't ask again buttons
      expect(
        find.byKey(const Key('feedback_maybe_later_button')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('feedback_never_ask_button')),
        findsOneWidget,
      );
    });

    testWidgets('renders initial state in Bengali when language is bn', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingBn.new),
          ],
          child: const MaterialApp(home: Scaffold(body: FeedbackDialog())),
        ),
      );

      expect(find.text('ইমপালস ব্যবহার কেমন লাগছে?'), findsOneWidget);
      expect(
        find.text(
          'আপনার সামগ্রিক অভিজ্ঞতা কেমন? রেটিং দিতে স্টারে ট্যাপ করুন।',
        ),
        findsOneWidget,
      );
      expect(find.text('হয়তো পরে'), findsOneWidget);
      expect(find.text('আর দেখাবেন না'), findsOneWidget);
    });

    testWidgets(
      'selecting 4 or 5 stars routes to Google Play button and invokes callback',
      (WidgetTester tester) async {
        bool playStoreTapped = false;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: FeedbackDialog(
                  onPlayStoreTapped: () {
                    playStoreTapped = true;
                  },
                ),
              ),
            ),
          ),
        );

        // Tap 5th star
        await tester.tap(find.byKey(const Key('feedback_star_5')));
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Thank you so much! A positive review on the Play Store helps us tremendously.',
          ),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('feedback_play_store_button')),
          findsOneWidget,
        );

        // Tap Play Store button
        await tester.tap(find.byKey(const Key('feedback_play_store_button')));
        await tester.pumpAndSettle();

        expect(playStoreTapped, true);
      },
    );

    testWidgets(
      'selecting 1, 2, or 3 stars shows feedback field and Email/WhatsApp buttons',
      (WidgetTester tester) async {
        String? emailFeedback;
        String? whatsAppFeedback;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: FeedbackDialog(
                  onFeedbackEmailTapped: (val) => emailFeedback = val,
                  onFeedbackWhatsAppTapped: (val) => whatsAppFeedback = val,
                ),
              ),
            ),
          ),
        );

        // Tap 2nd star
        await tester.tap(find.byKey(const Key('feedback_star_2')));
        await tester.pumpAndSettle();

        expect(
          find.text(
            'We value your input. Let us know how we can make Impulse better for you.',
          ),
          findsOneWidget,
        );
        expect(find.byKey(const Key('feedback_text_field')), findsOneWidget);
        expect(find.byKey(const Key('feedback_email_button')), findsOneWidget);
        expect(
          find.byKey(const Key('feedback_whatsapp_button')),
          findsOneWidget,
        );

        // Enter feedback message
        await tester.enterText(
          find.byKey(const Key('feedback_text_field')),
          'Great app, but please add dark mode!',
        );

        // Tap Email button
        await tester.tap(find.byKey(const Key('feedback_email_button')));
        await tester.pumpAndSettle();
        expect(emailFeedback, 'Great app, but please add dark mode!');

        // Tap WhatsApp button test
        await tester.tap(find.byKey(const Key('feedback_whatsapp_button')));
        await tester.pumpAndSettle();
        expect(whatsAppFeedback, 'Great app, but please add dark mode!');
      },
    );

    testWidgets(
      "user initiated dialog displays Close button instead of Don't ask again",
      (WidgetTester tester) async {
        bool postponedCalled = false;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: FeedbackDialog(
                  isUserInitiated: true,
                  onPostponed: () {
                    postponedCalled = true;
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.text('Close'), findsOneWidget);
        expect(find.text("Don't ask again"), findsNothing);

        await tester.tap(find.byKey(const Key('feedback_maybe_later_button')));
        await tester.pumpAndSettle();
        expect(postponedCalled, true);
      },
    );

    testWidgets("tapping Don't ask again triggers onNeverAskAgain callback", (
      WidgetTester tester,
    ) async {
      bool neverAskCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FeedbackDialog(
                onNeverAskAgain: () {
                  neverAskCalled = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('feedback_never_ask_button')));
      await tester.pumpAndSettle();
      expect(neverAskCalled, true);
    });

    testWidgets(
      'renders without horizontal overflow on small and narrow devices',
      (WidgetTester tester) async {
        for (final width in [280.0, 320.0, 360.0]) {
          tester.view.physicalSize = Size(width, 700.0);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                languageSettingProvider.overrideWith(MockLanguageSettingBn.new),
              ],
              child: const MaterialApp(home: Scaffold(body: FeedbackDialog())),
            ),
          );
          await tester.pumpAndSettle();

          // Verify 5 stars render without error
          expect(find.byKey(const Key('feedback_star_5')), findsOneWidget);
          expect(tester.takeException(), isNull);

          // Tap 5th star (Play Store route)
          await tester.tap(find.byKey(const Key('feedback_star_5')));
          await tester.pumpAndSettle();
          expect(
            find.byKey(const Key('feedback_play_store_button')),
            findsOneWidget,
          );
          expect(tester.takeException(), isNull);

          // Tap 2nd star (Constructive feedback route with email & whatsapp)
          await tester.tap(find.byKey(const Key('feedback_star_2')));
          await tester.pumpAndSettle();
          expect(
            find.byKey(const Key('feedback_whatsapp_button')),
            findsOneWidget,
          );
          expect(
            find.byKey(const Key('feedback_email_button')),
            findsOneWidget,
          );
          expect(tester.takeException(), isNull);
        }
      },
    );
  });
}
