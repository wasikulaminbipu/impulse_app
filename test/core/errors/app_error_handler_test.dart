import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/core/errors/app_error.dart';
import 'package:impulse_app/core/errors/app_error_handler.dart';

void main() {
  group('AppException Tests', () {
    test('AppException subclasses format toString correctly', () {
      const dbException = DatabaseException('Database failed');
      expect(dbException.toString(), equals('DatabaseException: Database failed'));
      expect(dbException.message, equals('Database failed'));

      const netException = NetworkException('No internet');
      expect(netException.toString(), equals('NetworkException: No internet'));

      const renderException = RenderException('Layout overflow');
      expect(renderException.toString(), equals('RenderException: Layout overflow'));

      const valException = ValidationException('Invalid ID');
      expect(valException.toString(), equals('ValidationException: Invalid ID'));

      const unknownException = UnknownException('Unexpected error');
      expect(unknownException.toString(), equals('UnknownException: Unexpected error'));
    });

    test('AppException stores originalError and stackTrace', () {
      final original = Exception('Original cause');
      final stack = StackTrace.current;
      final appEx = DatabaseException('DB error', originalError: original, stackTrace: stack);

      expect(appEx.originalError, equals(original));
      expect(appEx.stackTrace, equals(stack));
    });
  });

  group('AppErrorHandler Tests', () {
    test('logError converts generic error to UnknownException', () {
      AppException? captured;
      void listener(AppException e) {
        captured = e;
      }

      AppErrorHandler.addErrorListener(listener);
      final logged = AppErrorHandler.logError('Test error message');
      AppErrorHandler.removeErrorListener(listener);

      expect(logged, isA<UnknownException>());
      expect(logged.message, contains('Test error message'));
      expect(captured, equals(logged));
    });

    test('logError converts FlutterError to RenderException', () {
      final flutterError = FlutterError('Widget layout failure');
      final logged = AppErrorHandler.logError(flutterError, context: 'TestContext');

      expect(logged, isA<RenderException>());
      expect(logged.message, contains('Widget layout failure'));
    });

    test('logError retains AppException without wrapping', () {
      const original = DatabaseException('Existing DB Error');
      final logged = AppErrorHandler.logError(original);
      expect(logged, equals(original));
    });

    test('removeErrorListener prevents further listener calls', () {
      int callCount = 0;
      void listener(AppException e) {
        callCount++;
      }

      AppErrorHandler.addErrorListener(listener);
      AppErrorHandler.logError('First error');
      expect(callCount, equals(1));

      AppErrorHandler.removeErrorListener(listener);
      AppErrorHandler.logError('Second error');
      expect(callCount, equals(1));
    });

    test('guard handles sync exceptions and returns fallback', () {
      final result = AppErrorHandler.guard<int>(
        () => throw Exception('Calculation error'),
        fallback: 42,
      );
      expect(result, equals(42));
    });

    test('guard returns value on success', () {
      final result = AppErrorHandler.guard<int>(
        () => 100,
        fallback: 0,
      );
      expect(result, equals(100));
    });

    test('guardAsync handles async exceptions and returns fallback', () async {
      final result = await AppErrorHandler.guardAsync<String>(
        () async => throw Exception('Async fetch error'),
        fallback: 'default_value',
      );
      expect(result, equals('default_value'));
    });

    test('guardAsync returns value on async success', () async {
      final result = await AppErrorHandler.guardAsync<String>(
        () async => 'success_data',
        fallback: 'fallback_data',
      );
      expect(result, equals('success_data'));
    });
  });
}
