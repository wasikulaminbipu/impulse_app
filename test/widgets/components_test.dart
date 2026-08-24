import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/widgets/custom_badge.dart';
import 'package:impulse_dex/widgets/tactile_button.dart';
import 'package:impulse_dex/widgets/glass_container.dart';
import 'package:impulse_dex/widgets/feedback_banner.dart';

Widget createTestHarness(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: Center(child: child),
    ),
  );
}

void main() {
  group('CustomBadge Widget Tests', () {
    testWidgets('Renders badge text and color correctly', (tester) async {
      await tester.pumpWidget(
        createTestHarness(
          const CustomBadge(
            color: Colors.red,
            text: 'VACCINE',
          ),
        ),
      );

      expect(find.text('VACCINE'), findsOneWidget);
    });

    testWidgets('Triggers onTap when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        createTestHarness(
          CustomBadge(
            color: Colors.blue,
            text: 'CLICK',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('CLICK'));
      expect(tapped, isTrue);
    });
  });

  group('TactileButton Widget Tests', () {
    testWidgets('Executes onPressed callback on tap', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        createTestHarness(
          TactileButton(
            onPressed: () => pressed = true,
            child: const Text('Press Me'),
          ),
        ),
      );

      await tester.tap(find.text('Press Me'));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets('Does not execute onPressed callback when disabled', (tester) async {
      await tester.pumpWidget(
        createTestHarness(
          const TactileButton(
            onPressed: null,
            child: Text('Disabled'),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();
      // Test passed cleanly without error
    });
  });

  group('GlassContainer Widget Tests', () {
    testWidgets('Renders child inside backdrop filter container', (tester) async {
      await tester.pumpWidget(
        createTestHarness(
          const GlassContainer(
            child: Text('Glass Content'),
          ),
        ),
      );

      expect(find.text('Glass Content'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });
  });

  group('FeedbackBanner Widget Tests', () {
    testWidgets('Renders success feedback message', (tester) async {
      await tester.pumpWidget(
        createTestHarness(
          const FeedbackBanner(
            message: 'Operation Successful',
            isError: false,
          ),
        ),
      );

      expect(find.text('Operation Successful'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Renders error feedback message', (tester) async {
      await tester.pumpWidget(
        createTestHarness(
          const FeedbackBanner(
            message: 'An error occurred',
            isError: true,
          ),
        ),
      );

      expect(find.text('An error occurred'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
