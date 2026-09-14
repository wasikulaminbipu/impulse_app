import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/constants/app_keys.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_version_provider.dart';
import 'package:impulse_app/providers/navigation_provider.dart';
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
        expect(find.text('v${AppConstants.appVersion}'), findsOneWidget);
        expect(find.text('Products Directory'), findsOneWidget);
        expect(find.text('Manufacturers'), findsOneWidget);
        expect(find.text('Contact Details'), findsOneWidget);
        // "Distributors" and "Sales Representatives" should not exist
        expect(find.text('Sales Representatives'), findsNothing);
        expect(find.text('Distributors'), findsNothing);
        expect(find.text('About Us'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
        await tester.scrollUntilVisible(find.text('Rate & Feedback'), 50);
        expect(find.text('Rate & Feedback'), findsOneWidget);
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
      expect(find.text('যোগাযোগের বিবরণ'), findsOneWidget);
      // "ডিস্ট্রিবিউটর" and "প্রতিনিধি কন্টাক্টস" should not exist
      expect(find.text('প্রতিনিধি কন্টাক্টস'), findsNothing);
      expect(find.text('ডিস্ট্রিবিউটর'), findsNothing);
      expect(find.text('আমাদের সম্পর্কে'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('রেটিং ও মতামত'), 50);
      expect(find.text('রেটিং ও মতামত'), findsOneWidget);
    });

    testWidgets(
      'tapping Products, Manufacturers, and Contact Details navigates and updates mainNavIndexProvider',
      (WidgetTester tester) async {
        late WidgetRef capturedRef;
        int? tappedIndex;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              home: Consumer(
                builder: (context, ref, child) {
                  capturedRef = ref;
                  return Scaffold(
                    drawer: AppDrawer(
                      onTabSelected: (index) {
                        tappedIndex = index;
                      },
                    ),
                    body: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: const Text('Open Drawer'),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // Test tapping Manufacturers (tab 1)
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Manufacturers'));
        await tester.pumpAndSettle();

        expect(capturedRef.read(mainNavIndexProvider), equals(1));
        expect(tappedIndex, equals(1));

        // Test tapping Contact Details (tab 2)
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Contact Details'));
        await tester.pumpAndSettle();

        expect(capturedRef.read(mainNavIndexProvider), equals(2));
        expect(tappedIndex, equals(2));

        // Test tapping Products Directory (tab 0)
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Products Directory'));
        await tester.pumpAndSettle();

        expect(capturedRef.read(mainNavIndexProvider), equals(0));
        expect(tappedIndex, equals(0));
      },
    );

    testWidgets('renders dynamically fetched app version from provider', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            appVersionDisplayProvider.overrideWithValue('2.4.9'),
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

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('v2.4.9'), findsOneWidget);
    });

    testWidgets(
      'tapping Check for Updates triggers update check flow and shows feedback',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              languageSettingProvider.overrideWith(MockLanguageSettingEn.new),
            ],
            child: MaterialApp(
              scaffoldMessengerKey: AppKeys.rootScaffoldMessengerKey,
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

        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();

        await tester.scrollUntilVisible(find.text('Check for Updates'), 100);
        await tester.ensureVisible(find.text('Check for Updates'));
        await tester.pumpAndSettle();

        expect(find.text('Check for Updates'), findsOneWidget);

        await tester.tap(find.text('Check for Updates'), warnIfMissed: false);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Checking for updates...'), findsOneWidget);

        await tester.pumpAndSettle();
      },
    );
  });
}
