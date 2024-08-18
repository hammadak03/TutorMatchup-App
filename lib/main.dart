import 'package:flutter/material.dart';
import 'package:tutor_matchup/views/welcome_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TutorMatchup',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
