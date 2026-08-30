import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/core/errors/app_error_handler.dart';
import 'package:impulse_app/widgets/app_error_boundary.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppErrorBoundary Widget Tests', () {
    testWidgets('renders child widget normally when no error occurs', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppErrorBoundary(child: Text('Normal Content')),
        ),
      );

      expect(find.text('Normal Content'), findsOneWidget);
    });

    testWidgets('GlobalErrorFallbackWidget renders error message gracefully', (
      tester,
    ) async {
      final details = FlutterErrorDetails(
        exception: Exception('Test render failure'),
      );

      await tester.pumpWidget(
        MaterialApp(home: GlobalErrorFallbackWidget(errorDetails: details)),
      );

      expect(find.text('An unexpected display error occurred'), findsOneWidget);
      expect(
        find.text('The application recovered safely and prevented a crash.'),
        findsOneWidget,
      );
    });

    testWidgets('AppErrorHandler initializes ErrorWidget.builder correctly', (
      tester,
    ) async {
      final originalBuilder = ErrorWidget.builder;
      try {
        AppErrorHandler.initialize();
        final details = FlutterErrorDetails(
          exception: Exception('Framework test exception'),
        );

        final errorWidget = ErrorWidget.builder(details);
        expect(errorWidget, isA<GlobalErrorFallbackWidget>());
      } finally {
        ErrorWidget.builder = originalBuilder;
      }
    });
  });
}
