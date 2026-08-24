import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:impulse_dex/core/errors/app_error_handler.dart';
import 'package:impulse_dex/core/errors/app_provider_observer.dart';
import 'package:impulse_dex/widgets/app_error_boundary.dart';
import 'package:impulse_dex/theme/app_theme.dart';
import 'package:impulse_dex/screens/main_screen.dart';

import 'package:flutter/services.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  AppErrorHandler.initialize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const ProviderScope(
      observers: [AppProviderObserver()],
      child: AppErrorBoundary(
        child: ImpulseProductsApp(),
      ),
    ),
  );
}

class ImpulseProductsApp extends StatelessWidget {
  const ImpulseProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impulse Dex',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      scrollBehavior: const AppScrollBehavior(),
      home: const AppErrorBoundary(child: MainScreen()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
    );
  }
}

