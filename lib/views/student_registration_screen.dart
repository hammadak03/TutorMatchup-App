import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class StudentRegistrationScreen extends StatelessWidget {
  const StudentRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController instituteController = TextEditingController();
    final TextEditingController yearController = TextEditingController();
    final TextEditingController learningFormatController =
        TextEditingController();
    final TextEditingController preferredDaysController =
        TextEditingController();
    final TextEditingController preferredTimeController =
        TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const CustomTextWidget(
              text: 'Student Registration',
              textColor: blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              hintText: 'Enter Your Name',
              controller: nameController,
            ),
            CustomTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined),
              ),
            ),
            CustomTextField(
              controller: instituteController,
              hintText: 'School/College/University',
            ),
            CustomTextField(
              controller: yearController,
              hintText: 'Grade/Year',
            ),
            CustomTextField(
              controller: learningFormatController,
              hintText: 'Learning Format',
            ),
            CustomTextField(
              controller: preferredDaysController,
              hintText: 'Preferred Days',
            ),
            CustomTextField(
              controller: preferredTimeController,
              hintText: 'Preferred Time',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    instituteController.text.isNotEmpty &&
                    yearController.text.isNotEmpty &&
                    learningFormatController.text.isNotEmpty &&
                    preferredDaysController.text.isNotEmpty &&
                    preferredTimeController.text.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    Routes.userGuidelines,
                    arguments: {
                      'userType': 'student',
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'institute': instituteController.text,
                      'year': yearController.text,
                      'learningFormat': learningFormatController.text,
                      'preferredDays': preferredDaysController.text,
                      'preferredTime': preferredTimeController.text,
                    },
                  );
                } else {
                  // Handle empty fields, show a message
                }
              },
              buttonText: 'Create Account',
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
              },
              child: const CustomTextWidget(
                text: 'Already have account?',
                textColor: blackColor,
                fontSize: 18,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text.rich(
                TextSpan(
                  text: 'By clicking \"Create Account" you agree to our ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'terms ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: 'and ',
                    ),
                    TextSpan(
                      text: 'privacy policy.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
