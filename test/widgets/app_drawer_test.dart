import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/widgets/app_drawer.dart';

class MockLanguageSettingEn extends LanguageSetting {
  @override
  String build() => 'en';
}

class MockLanguageSettingBn extends LanguageSetting {
  @override
  String build() => 'bn';
}

void main() {
  group('AppDrawer Widget Tests', () {
    testWidgets(
      'renders drawer header, navigation tiles, and language toggle in English',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              home: Scaffold(
                drawer: const AppDrawer(),
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const Text('Open Drawer'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        // Open drawer
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();

        expect(find.text('Impulse'), findsOneWidget);
        expect(find.text('Products Directory'), findsOneWidget);
        expect(find.text('Manufacturers'), findsOneWidget);
        expect(find.text('Sales Representatives'), findsOneWidget);
        expect(find.text('About Us'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
      },
    );

    testWidgets('renders Bengali translations in drawer when language is bn', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingBn.new),
          ],
          child: MaterialApp(
            home: Scaffold(
              drawer: const AppDrawer(currentTabIndex: 1),
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    child: const Text('Open Drawer'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('প্রোডাক্টস ক্যাটালগ'), findsOneWidget);
      expect(find.text('ম্যানুফ্যাকচারার'), findsOneWidget);
      expect(find.text('প্রতিনিধি কন্টাক্টস'), findsOneWidget);
      expect(find.text('আমাদের সম্পর্কে'), findsOneWidget);
    });
  });
}
