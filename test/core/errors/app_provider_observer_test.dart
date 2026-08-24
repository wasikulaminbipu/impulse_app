import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/core/errors/app_error.dart';
import 'package:impulse_dex/core/errors/app_error_handler.dart';
import 'package:impulse_dex/core/errors/app_provider_observer.dart';

void main() {
  group('AppProviderObserver Tests', () {
    test('captures providerDidFail and logs exception via AppErrorHandler', () async {
      AppException? capturedError;
      void listener(AppException error) {
        capturedError = error;
      }

      AppErrorHandler.addErrorListener(listener);

      final failingProvider = Provider<String>((ref) {
        throw Exception('Sync provider failure');
      });

      final container = ProviderContainer(
        observers: [const AppProviderObserver()],
      );

      expect(
        () => container.read(failingProvider),
        throwsA(isA<Object>()),
      );

      AppErrorHandler.removeErrorListener(listener);
      container.dispose();

      expect(capturedError, isNotNull);
      expect(capturedError!.message, contains('Sync provider failure'));
    });
  });
}
