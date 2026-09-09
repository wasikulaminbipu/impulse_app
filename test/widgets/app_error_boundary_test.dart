import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/core/errors/app_error.dart';
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

    testWidgets(
      'LocalErrorFallbackCard renders message, error details, and triggers onRetry',
      (tester) async {
        var retried = false;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LocalErrorFallbackCard(
                error: 'Database connection failed',
                onRetry: () => retried = true,
              ),
            ),
          ),
        );

        expect(
          find.text('Something went wrong displaying this section'),
          findsOneWidget,
        );
        expect(find.text('Database connection failed'), findsOneWidget);

        await tester.tap(find.text('Retry'));
        await tester.pump();
        expect(retried, isTrue);
      },
    );

    test(
      'AppErrorHandler addErrorListener, removeErrorListener, and logError',
      () {
        AppException? received;
        void listener(AppException ex) => received = ex;

        AppErrorHandler.addErrorListener(listener);
        final ex = AppErrorHandler.logError(
          Exception('Sample error'),
          context: 'UnitTest',
        );
        expect(received, isNotNull);
        expect(received!.message, contains('Sample error'));
        expect(ex, isA<UnknownException>());

        received = null;
        AppErrorHandler.removeErrorListener(listener);
        AppErrorHandler.logError(FlutterError('Render overflow test'));
        expect(received, isNull);
      },
    );

    test('AppErrorHandler guard and guardAsync execute successfully or return fallback', () async {
      final result = AppErrorHandler.guard<int>(() => 42, fallback: 0);
      expect(result, equals(42));

      final failed = AppErrorHandler.guard<int>(
        () => throw Exception('Crash'),
        fallback: 99,
      );
      expect(failed, equals(99));

      final asyncResult = await AppErrorHandler.guardAsync<String>(
        () async => 'success',
        fallback: 'fail',
      );
      expect(asyncResult, equals('success'));

      final asyncFailed = await AppErrorHandler.guardAsync<String>(
        () async => throw Exception('Async crash'),
        fallback: 'fallback_val',
      );
      expect(asyncFailed, equals('fallback_val'));
    });

    testWidgets('AppErrorHandler showErrorBanner displays error feedback', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => AppErrorHandler.showErrorBanner(
                    context,
                    'Test error message',
                  ),
                  child: const Text('Show Banner'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Banner'));
      await tester.pump();
      expect(find.textContaining('Test error message'), findsOneWidget);
    });
  });
}
