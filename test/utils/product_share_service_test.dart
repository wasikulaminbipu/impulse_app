import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/utils/product_share_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProductShareService Tests', () {
    testWidgets('Throws Exception when repaint boundary key is unattached', (
      tester,
    ) async {
      final key = GlobalKey();

      expect(
        () => ProductShareService.shareProductCard(
          repaintBoundaryKey: key,
          shareTitle: 'Test Share Title',
        ),
        throwsA(isA<Exception>()),
      );
    });

    testWidgets('RepaintBoundary widget renders with key without error', (
      tester,
    ) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RepaintBoundary(
              key: key,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: Text('Shareable Content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(key.currentContext, isNotNull);
      expect(key.currentContext?.findRenderObject(), isNotNull);
    });
  });
}
