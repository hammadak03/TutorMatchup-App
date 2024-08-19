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
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
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
          const CustomTextField(
            hintText: 'Enter Your Username',
          ),
          const CustomTextField(
            hintText: 'Email',
          ),
          CustomTextField(
            hintText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_off_outlined),
            ),
          ),
          const CustomTextField(
            hintText: 'Phone Number',
          ),
          const CustomTextField(
            hintText: 'Highest Level of Education',
          ),
          const CustomTextField(
            hintText: 'Availability',
          ),
          const CustomTextField(
            hintText: 'Previous Experience',
          ),
          const CustomTextField(
            hintText: 'Subjects Want to Teach',
          ),
          const CustomTextField(
            hintText: 'Attach Resume',
          ),
          CustomButton(
            onTap: () {},
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
    );
  }
}
