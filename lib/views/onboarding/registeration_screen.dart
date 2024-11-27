import 'package:flutter/material.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/routes/routes.dart';

class RegisterationScreen extends StatelessWidget {
  const RegisterationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView( // Wrap Column with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox( // Wrap Image.asset with SizedBox
                width: 300, // Set desired width
                height: 300, // Set desired height
                child: Image.asset('assets/images/tutormatchup_logo.png'),
              ),
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
                onTap: () {
                  Navigator.pushNamed(context, Routes.studentRegisteration);
                },
                buttonText: 'Are You Student?',
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, Routes.tutorRegisteration);
                },
                buttonText: 'Are You Teacher?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}