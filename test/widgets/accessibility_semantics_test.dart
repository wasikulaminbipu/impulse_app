import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/widgets/favorite_button.dart';
import 'package:impulse_app/widgets/tactile_button.dart';

void main() {
  group('Accessibility & Semantics Tests', () {
    testWidgets(
      'TactileButton meets minimum 48x48 touch target and button semantics',
      (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: TactileButton(
                  onPressed: () => tapped = true,
                  child: const Text('Tap Me'),
                ),
              ),
            ),
          ),
        );

        final buttonFinder = find.byType(TactileButton);
        expect(buttonFinder, findsOneWidget);

        // Verify touch target size meets minimum 48x48 dp
        final size = tester.getSize(buttonFinder);
        expect(size.width, greaterThanOrEqualTo(48.0));
        expect(size.height, greaterThanOrEqualTo(48.0));

        // Verify semantics
        expect(
          tester.getSemantics(buttonFinder),
          matchesSemantics(
            isButton: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
            label: 'Tap Me',
          ),
        );

        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();
        expect(tapped, isTrue);
      },
    );

    testWidgets('Disabled TactileButton reflects disabled semantics', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: TactileButton(onPressed: null, child: Text('Disabled')),
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(TactileButton);
      expect(
        tester.getSemantics(buttonFinder),
        matchesSemantics(
          isButton: true,
          hasEnabledState: true,
          label: 'Disabled',
        ),
      );
    });

    testWidgets(
      'FavoriteButton provides accessible tooltip and icon semantics',
      (tester) async {
        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: Center(
                  child: FavoriteButton(refId: 101, type: FavoriteType.product),
                ),
              ),
            ),
          ),
        );

        final favButtonFinder = find.byType(FavoriteButton);
        expect(favButtonFinder, findsOneWidget);

        final iconButtonFinder = find.byType(IconButton);
        expect(iconButtonFinder, findsOneWidget);

        final iconButton = tester.widget<IconButton>(iconButtonFinder);
        expect(iconButton.tooltip, isNotNull);
        expect(iconButton.tooltip, contains('favorites'));
      },
    );
  });
}
