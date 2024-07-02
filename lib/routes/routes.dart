import 'package:flutter/material.dart';
import 'package:morningstar/features/Auth/login.dart';
import 'package:morningstar/features/Auth/splash.dart';

class Routes {
  MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
            builder: (context) => const Login());
      default:
        return MaterialPageRoute(
          builder: (context) => const Splash());
    }
  }
}