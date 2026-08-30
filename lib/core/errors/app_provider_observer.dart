import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/core/errors/app_error_handler.dart';

/// ProviderObserver that monitors Riverpod state changes and logs provider exceptions.
base class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    AppErrorHandler.logError(
      error,
      stackTrace: stackTrace,
      context: 'RiverpodProvider:${context.provider.name ?? context.provider.runtimeType}',
    );
    super.providerDidFail(context, error, stackTrace);
  }
}
