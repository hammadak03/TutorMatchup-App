import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/login_screen.dart';
// import 'routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TutorMatchup',
      debugShowCheckedModeBanner: false,
      // initialRoute: Routes.welcome,
      // routes: appRoutes,
      home: LoginScreen(),
    );
  }
}
