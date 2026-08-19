import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:impulse_dex/theme/app_theme.dart';
import 'package:impulse_dex/screens/main_screen.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: ImpulseProductsApp()));
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
      home: const MainScreen(),
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
