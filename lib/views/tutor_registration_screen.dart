import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class TutorRegistrationScreen extends StatelessWidget {
  const TutorRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneNoController = TextEditingController();
    final TextEditingController educationController = TextEditingController();
    final TextEditingController availabilityController =
        TextEditingController();
    final TextEditingController experienceController = TextEditingController();
    final TextEditingController subjectsController = TextEditingController();
    final TextEditingController resumeController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const CustomTextWidget(
              text: 'Tutor Registration',
              textColor: blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter Your Name',
            ),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined),
              ),
            ),
            CustomTextField(
              controller: phoneNoController,
              hintText: 'Phone Number',
            ),
            CustomTextField(
              controller: educationController,
              hintText: 'Highest Level of Education',
            ),
            CustomTextField(
              controller: availabilityController,
              hintText: 'Availability',
            ),
            CustomTextField(
              controller: experienceController,
              hintText: 'Previous Experience',
            ),
            CustomTextField(
              controller: subjectsController,
              hintText: 'Subjects Want to Teach',
            ),
            CustomTextField(
              controller: resumeController,
              hintText: 'Attach Resume',
            ),
            CustomButton(
              onTap: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    phoneNoController.text.isNotEmpty &&
                    educationController.text.isNotEmpty &&
                    availabilityController.text.isNotEmpty &&
                    experienceController.text.isNotEmpty &&
                    subjectsController.text.isNotEmpty &&
                    resumeController.text.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    Routes.userGuidelines,
                    arguments: {
                      'userType': 'tutor',
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'phoneNo': phoneNoController.text,
                      'education': educationController.text,
                      'availability': availabilityController.text,
                      'experience': experienceController.text,
                      'subjects': subjectsController.text,
                      'resume': resumeController.text,
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
                  text: 'By clicking "Create Account" you agree to our ',
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
