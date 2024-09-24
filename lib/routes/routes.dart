// routes.dart
import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/chat_screen.dart';
import 'package:tutor_matchup/views/class_session_screen.dart';
import 'package:tutor_matchup/views/completed_schedules_screen.dart';
import 'package:tutor_matchup/views/home_screen_wrapper.dart';
import 'package:tutor_matchup/views/missed_schedules_screen.dart';
import 'package:tutor_matchup/views/splash_screen.dart';
import 'package:tutor_matchup/views/student_home_screen.dart';
import 'package:tutor_matchup/views/login_screen.dart';
import 'package:tutor_matchup/views/registeration_screen.dart';
import 'package:tutor_matchup/views/student_registration_screen.dart';
import 'package:tutor_matchup/views/tutor_details_screen.dart';
import 'package:tutor_matchup/views/tutor_home_screen.dart';
import 'package:tutor_matchup/views/tutor_registration_screen.dart';
import 'package:tutor_matchup/views/upcoming_schedule_screen.dart';
import 'package:tutor_matchup/views/user_guidelines_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String registeration = '/registeration';
  static const String tutorRegisteration = '/tutorRegisteration';
  static const String studentRegisteration = '/studentRegisteration';
  static const String userGuidelines = '/userGuidelines';
  static const String home = '/home';
  static const String upcommingSchedules = '/upcommingSchedules';
  static const String missedSchedules = '/missedSchedules';
  static const String completedSchedules = '/completedSchedules';
  static const String chat = '/chat';
  static const String homeWrapper = '/homeWrapper';
  static const String tutorHome = '/tutorHome';
  static const String classSession = '/classSession';
  static const String tutorDetails = '/tutorDetails';
}

final Map<String, WidgetBuilder> appRoutes = {
  Routes.splash: (context) => const SplashScreen(),
  Routes.login: (context) => const LoginScreen(),
  Routes.registeration: (context) => const RegisterationScreen(),
  Routes.tutorRegisteration: (context) => const TutorRegistrationScreen(),
  Routes.studentRegisteration: (context) => const StudentRegistrationScreen(),
  Routes.userGuidelines: (context) => const UserGuidelinesScreen(),
  Routes.home: (context) => const StudentHomeScreen(),
  Routes.completedSchedules: (context) => const CompletedSchedulesScreen(),
  Routes.upcommingSchedules: (context) => const UpcomingScheduleScreen(),
  Routes.missedSchedules: (context) => const MissedSchedulesScreen(),
  Routes.chat: (context) => const ChatScreen(),
  Routes.homeWrapper: (context) => const HomeWrapper(),
  Routes.tutorHome: (context) => const TutorHomeScreen(),
  Routes.classSession: (context) => const ClassSessionScreen(),
  Routes.tutorDetails: (context) => const TutorDetailsSceens(),
};
