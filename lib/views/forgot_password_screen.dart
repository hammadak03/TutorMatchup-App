// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tutor_matchup/services/firebase_auth_services.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/tutormatchup_logo.png'),
              const CustomTextWidget(
                text: 'Forgot Password?',
                textColor: midnightBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter your Email, we will send you password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: coolGrayColor,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Your Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () async {
                  final FirebaseAuthService authService = FirebaseAuthService();
                  String email = emailController.text.trim();

                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomTextWidget(
                          text: 'Please enter an email address.',
                        ),
                      ),
                    );
                    return;
                  }

                  try {
                    await authService.resetPassword(email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CustomTextWidget(
                          text: 'Password reset email sent.',
                        ),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                      ),
                    );
                  }
                },
                buttonText: 'Send Email',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
