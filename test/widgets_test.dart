import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Unit Tests', () {
    testWidgets('Basic MaterialApp render test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Impulse DEX Test'),
            ),
          ),
        ),
      );

      expect(find.text('Impulse DEX Test'), findsOneWidget);
    });
  });
}
