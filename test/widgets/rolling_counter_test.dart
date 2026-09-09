import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/widgets/rolling_counter.dart';

void main() {
  group('RollingCounterText Widget Tests', () {
    testWidgets('renders initial value correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RollingCounterText(
              value: '42',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
        ),
      );

      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('animates and transitions when value updates', (
      WidgetTester tester,
    ) async {
      String counterValue = '10';

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    RollingCounterText(
                      value: counterValue,
                      duration: const Duration(milliseconds: 200),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          counterValue = '25';
                        });
                      },
                      child: const Text('Increment'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);

      // Trigger update
      await tester.tap(find.text('Increment'));
      await tester.pump(); // Start transition

      // Halfway through transition
      await tester.pump(const Duration(milliseconds: 100));

      // Settle animation
      await tester.pumpAndSettle();
      expect(find.text('25'), findsOneWidget);
    });
  });
}
