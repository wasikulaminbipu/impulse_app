import 'package:flutter/material.dart';

/// Central global keys for root navigator and scaffold messenger access across layers.
abstract final class AppKeys {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
