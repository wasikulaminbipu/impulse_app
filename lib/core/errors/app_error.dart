import 'package:flutter/foundation.dart';

/// Base exception class for all domain and application errors in Impulse.
@immutable
abstract class AppException implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  const AppException(
    this.message, {
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => '$runtimeType: $message';
}

/// Errors related to local database operations (Drift / SQLite).
class DatabaseException extends AppException {
  const DatabaseException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Errors occurring during UI rendering or widget tree lifecycle.
class RenderException extends AppException {
  const RenderException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Errors arising from network or external I/O requests.
class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Errors arising from invalid user operations or invalid data states.
class ValidationException extends AppException {
  const ValidationException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Fallback exception type for unexpected uncaught errors.
class UnknownException extends AppException {
  const UnknownException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}
