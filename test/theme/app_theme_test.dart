import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/theme/app_theme.dart';

void main() {
  group('AppTheme & ThemeExtensions Unit Tests', () {
    test(
      'lightTheme and darkTheme construct with expected colors and extensions',
      () {
        final light = AppTheme.lightTheme;
        expect(light.brightness, equals(Brightness.light));
        expect(light.colorScheme.primary, isNotNull);
        expect(light.extensions.values.isNotEmpty, isTrue);

        final dark = AppTheme.darkTheme;
        expect(dark.brightness, equals(Brightness.dark));
        expect(dark.colorScheme.primary, isNotNull);
        expect(dark.extensions.values.isNotEmpty, isTrue);
      },
    );

    test('CategoryColors extension supports copyWith and lerp', () {
      const colors = CategoryColors(
        feedAdditiveColor: Colors.amber,
        vaccineColor: Colors.blue,
        poultryColor: Colors.green,
        cattleColor: Colors.brown,
        aquaColor: Colors.cyan,
        defaultCategoryColor: Colors.grey,
      );

      final modified =
          colors.copyWith(feedAdditiveColor: Colors.orange) as CategoryColors;
      expect(modified.feedAdditiveColor, equals(Colors.orange));
      expect(modified.vaccineColor, equals(Colors.blue));

      final lerped = colors.lerp(modified, 0.5);
      expect(lerped, isA<CategoryColors>());

      // Lerp with null returns self
      expect(colors.lerp(null, 0.5), equals(colors));
    });

    test('GlassThemeExtension extension supports copyWith and lerp', () {
      const glass = GlassThemeExtension(
        blurSigma: 12.0,
        backgroundColor: Colors.white,
        borderColor: Colors.black,
        topSpecularColor: Colors.white70,
      );

      final copied = glass.copyWith(blurSigma: 16.0);
      expect(copied.blurSigma, equals(16.0));
      expect(copied.backgroundColor, equals(Colors.white));

      final lerped = glass.lerp(copied, 0.5);
      expect(lerped, isA<GlassThemeExtension>());
      expect(glass.lerp(null, 0.5), equals(glass));
    });

    testWidgets('AppScrollBehavior builds overscroll indicator on Android', (
      tester,
    ) async {
      const behavior = AppScrollBehavior();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return behavior.buildOverscrollIndicator(
                  context,
                  Container(),
                  const ScrollableDetails(direction: AxisDirection.down),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(GlowingOverscrollIndicator), findsOneWidget);
    });

    testWidgets('AppScrollBehavior defaults to standard on iOS', (
      tester,
    ) async {
      const behavior = AppScrollBehavior();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return behavior.buildOverscrollIndicator(
                  context,
                  const Text('iOS Content'),
                  const ScrollableDetails(direction: AxisDirection.down),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('iOS Content'), findsOneWidget);
    });
  });
}
