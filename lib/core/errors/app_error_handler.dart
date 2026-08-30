import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:impulse_app/core/errors/app_error.dart';
import 'package:impulse_app/widgets/app_error_boundary.dart';
import 'package:impulse_app/widgets/feedback_banner.dart';

/// Central handler for intercepting, logging, guarding, and processing application errors.
class AppErrorHandler {
  AppErrorHandler._();

  static final List<void Function(AppException error)> _errorListeners = [];

  /// Registers a listener callback triggered whenever an [AppException] is logged.
  static void addErrorListener(void Function(AppException error) listener) {
    _errorListeners.add(listener);
  }

  /// Removes a registered error listener.
  static void removeErrorListener(void Function(AppException error) listener) {
    _errorListeners.remove(listener);
  }

  /// Initializes global exception hooks for Flutter framework & root Isolate errors.
  static void initialize() {
    // Catch Flutter framework rendering & widget errors
    FlutterError.onError = (FlutterErrorDetails details) {
      logError(
        details.exception,
        stackTrace: details.stack,
        context: 'FlutterFramework',
      );
      // Call default dump to console in debug mode
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    // Catch uncaught errors in the root isolate
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      logError(
        error,
        stackTrace: stack,
        context: 'PlatformDispatcher',
      );
      // Return true to mark exception as handled so app engine does not crash
      return true;
    };

    // Replace Flutter red screen of death with custom error widget builder
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return GlobalErrorFallbackWidget(
        errorDetails: details,
      );
    };
  }

  /// Safely converts any exception into an [AppException] and logs it.
  static AppException logError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    final AppException appException;

    if (error is AppException) {
      appException = error;
    } else if (error is FlutterError) {
      appException = RenderException(
        error.message,
        originalError: error,
        stackTrace: stackTrace,
      );
    } else {
      appException = UnknownException(
        error.toString(),
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    final contextInfo = context != null ? ' [$context]' : '';
    debugPrint('🚨 APP ERROR$contextInfo: ${appException.message}');
    if (stackTrace != null && kDebugMode) {
      debugPrint(stackTrace.toString());
    }

    for (final listener in List.of(_errorListeners)) {
      try {
        listener(appException);
      } catch (e) {
        debugPrint('Error in error listener: $e');
      }
    }

    return appException;
  }

  /// Safely executes a synchronous operation [action], returning [fallback] (or null) if an exception occurs.
  static T? guard<T>(
    T Function() action, {
    T? fallback,
    String? context,
  }) {
    try {
      return action();
    } catch (e, st) {
      logError(e, stackTrace: st, context: context ?? 'AppErrorHandler.guard');
      return fallback;
    }
  }

  /// Safely executes an asynchronous operation [action], returning [fallback] (or null) if an exception occurs.
  static Future<T?> guardAsync<T>(
    Future<T> Function() action, {
    T? fallback,
    String? context,
  }) async {
    try {
      return await action();
    } catch (e, st) {
      logError(e, stackTrace: st, context: context ?? 'AppErrorHandler.guardAsync');
      return fallback;
    }
  }

  /// Presents a floating error banner to the user using [FeedbackBanner].
  static void showErrorBanner(BuildContext context, Object error) {
    final appError = error is AppException ? error : logError(error);
    FeedbackBanner.showError(context, appError.message);
  }
}
