import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:impulse_dex/widgets/highlight_text.dart';

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

    testWidgets('HighlightText renders without error when text or query is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HighlightText(text: null, query: 'test'),
                HighlightText(text: 'Sample Text', query: null),
                HighlightText(text: null, query: null),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Sample Text'), findsOneWidget);
    });
  });
}
