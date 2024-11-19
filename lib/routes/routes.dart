// routes.dart
import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/auth/address_selection_screen.dart';
import 'package:tutor_matchup/views/messages/chat_screen.dart';
import 'package:tutor_matchup/views/schedules/class_session_screen.dart';
import 'package:tutor_matchup/views/schedules/completed_schedules_screen.dart';
import 'package:tutor_matchup/views/auth/forgot_password_screen.dart';
import 'package:tutor_matchup/views/home/home_screen_wrapper.dart';
import 'package:tutor_matchup/views/schedules/missed_schedules_screen.dart';
import 'package:tutor_matchup/views/onboarding/splash_screen.dart';
import 'package:tutor_matchup/views/home/student_home_screen.dart';
import 'package:tutor_matchup/views/auth/login_screen.dart';
import 'package:tutor_matchup/views/onboarding/registeration_screen.dart';
import 'package:tutor_matchup/views/auth/student_registration_screen.dart';
import 'package:tutor_matchup/views/profile/tutor_details_screen.dart';
import 'package:tutor_matchup/views/home/tutor_home_screen.dart';
import 'package:tutor_matchup/views/auth/tutor_registration_screen.dart';
import 'package:tutor_matchup/views/schedules/upcoming_schedule_screen.dart';
import 'package:tutor_matchup/views/auth/user_guidelines_screen.dart';

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
  static const String studentHome = '/studentHome';
  static const String classSession = '/classSession';
  static const String tutorDetails = '/tutorDetails';
  static const String forgotPassword = '/forgotPassword';
  static const String searchResults = '/searchResults';
  static const String mapSelection = '/mapSelection';
  // Define editProfile as a static constant
  static const String editProfile = '/editProfile';
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
  Routes.studentHome: (context) => const StudentHomeScreen(),
  Routes.classSession: (context) => const ClassSessionScreen(),
  Routes.tutorDetails: (context) => const TutorDetailsSceens(),
  Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
  Routes.mapSelection: (context) => const AddressSelectionScreen(),
};
