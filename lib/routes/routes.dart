// routes.dart
import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/login_screen.dart';
import 'package:tutor_matchup/views/welcome_screen.dart';

class Routes {
  static const String welcome = '/';
  static const String login = '/login';
}

final Map<String, WidgetBuilder> appRoutes = {
  Routes.welcome: (context) => const WelcomeScreen(),
  Routes.login: (context) => const LoginScreen(),
};
