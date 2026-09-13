import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/widgets/update_prompt_sheet.dart';

void main() {
  group('UpdatePromptSheet Widget Tests', () {
    testWidgets('renders English copy when language is en', (tester) async {
      bool updateClicked = false;
      bool remindLaterClicked = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(
              () => _FakeLanguageSetting('en'),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: UpdatePromptSheet(
                availableVersionCode: 10,
                stalenessDays: 3,
                onUpdateNow: () => updateClicked = true,
                onRemindLater: () => remindLaterClicked = true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check English texts
      expect(find.text('New Version Available!'), findsOneWidget);
      expect(find.text('Update Now'), findsOneWidget);
      expect(find.text('Remind Me Later'), findsOneWidget);
      expect(
        find.text('Latest medicine formulations & dosages'),
        findsOneWidget,
      );

      // Tap Update Now
      await tester.tap(find.text('Update Now'));
      await tester.pump();
      expect(updateClicked, isTrue);

      // Tap Remind Later
      await tester.tap(find.text('Remind Me Later'));
      await tester.pump();
      expect(remindLaterClicked, isTrue);
    });

    testWidgets('renders Bengali copy when language is bn', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(
              () => _FakeLanguageSetting('bn'),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: UpdatePromptSheet(
                availableVersionCode: 10,
                stalenessDays: 3,
                onUpdateNow: () {},
                onRemindLater: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check Bengali texts
      expect(find.text('নতুন সংস্করণ উপলব্ধ!'), findsOneWidget);
      expect(find.text('এখনই আপডেট করুন'), findsOneWidget);
      expect(find.text('পরে মনে করিয়ে দিন'), findsOneWidget);
      expect(find.text('সর্বশেষ ওষুধ ও ডোজ নির্দেশনা'), findsOneWidget);
    });
  });
}

class _FakeLanguageSetting extends LanguageSetting {
  final String _initial;
  _FakeLanguageSetting(this._initial);

  @override
  String build() => _initial;
}
