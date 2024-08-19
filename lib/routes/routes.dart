// routes.dart
import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/login_screen.dart';
import 'package:tutor_matchup/views/registeration_screen.dart';
import 'package:tutor_matchup/views/tutor_registration_screen.dart';

class Routes {
  static const String login = '/';
  static const String registeration = '/registeration';
  static const String tutorRegisteration = '/tutorRegisteration';
}

final Map<String, WidgetBuilder> appRoutes = {
  Routes.login: (context) => const LoginScreen(),
  Routes.registeration: (context) => const RegisterationScreen(),
  Routes.tutorRegisteration: (context) => const TutorRegistrationScreen(),
};
