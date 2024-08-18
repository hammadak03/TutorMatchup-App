import 'package:flutter/material.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset('assets/images/tutormatchup_logo.png'),
          const Text(
            'Start your journey now! 👋🏻',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 24),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
            onTap: () {},
            buttonText: 'Are You Student?',
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
            onTap: () {},
            buttonText: 'Are You Teacher?',
          ),
        ],
      ),
    );
  }
}
