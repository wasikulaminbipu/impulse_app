import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/screens/about_us_screen.dart';

class MockLanguageSettingEn extends LanguageSetting {
  @override
  String build() => 'en';
}

class MockLanguageSettingBn extends LanguageSetting {
  @override
  String build() => 'bn';
}

void main() {
  group('AboutUsScreen Widget Tests', () {
    testWidgets(
      'renders app header, company mission, bento grid, and contact links in English',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: const MaterialApp(home: AboutUsScreen()),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('About Us'), findsOneWidget);
        expect(find.text('Impulse'), findsOneWidget);
        expect(find.text('v1.0.0 (Build 1)'), findsOneWidget);
        expect(find.text('Our Companies'), findsOneWidget);
        expect(find.text('Adyan Agro'), findsOneWidget);
        expect(find.text('Impulse Agri'), findsOneWidget);
        expect(find.text('JP Pharma'), findsOneWidget);
        expect(find.text('About Company'), findsOneWidget);
        expect(find.text('Our Mission'), findsOneWidget);
        expect(find.text('Our Journey'), findsOneWidget);
        expect(find.text('Key Capabilities'), findsOneWidget);
        expect(find.text('Contact & Support'), findsOneWidget);
        expect(find.text('Official Website'), findsOneWidget);
        expect(find.text('Customer Support Email'), findsOneWidget);
        expect(find.text('impulseagriscienceltd@gmail.com'), findsOneWidget);
        expect(find.text('+880-1629-389015'), findsOneWidget);
      },
    );

    testWidgets('renders bilingual Bengali translations when language is bn', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingBn.new),
          ],
          child: const MaterialApp(home: AboutUsScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('আমাদের সম্পর্কে'), findsOneWidget);
      expect(find.text('সহযোগী প্রতিষ্ঠানসমূহ'), findsOneWidget);
      expect(find.text('আদিয়ান এগ্রো'), findsOneWidget);
      expect(find.text('ইম্পালস এগ্রি'), findsOneWidget);
      expect(find.text('জেপি ফার্মা'), findsOneWidget);
      expect(find.text('কোম্পানি পরিচিতি'), findsOneWidget);
      expect(find.text('আমাদের লক্ষ্য ও উদ্দেশ্য'), findsOneWidget);
      expect(find.text('আমাদের পথচলা'), findsOneWidget);
      expect(find.text('মূল সুবিধাসমূহ'), findsOneWidget);
      expect(find.text('যোগাযোগ ও সাপোর্ট'), findsOneWidget);
      expect(find.text('ওয়েবসাইট ভিজিট করুন'), findsOneWidget);
    });
  });
}
