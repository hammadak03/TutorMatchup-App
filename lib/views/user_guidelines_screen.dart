// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

import '../services/firebase_auth_services.dart';

class UserGuidelinesScreen extends StatelessWidget {
  const UserGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed data
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String userType = arguments['userType']!;

    // Common fields for both user types
    final String name = arguments['name']!;
    final String email = arguments['email']!;
    final String password = arguments['password']!;

    // Specific fields based on user type
    late String institute, year, learningFormat, preferredDays, preferredTime;
    late String phoneNo, education, availability, experience, subjects, resume;

    if (userType == 'student') {
      institute = arguments['institute']!;
      year = arguments['year']!;
      learningFormat = arguments['learningFormat']!;
      preferredDays = arguments['preferredDays']!;
      preferredTime = arguments['preferredTime']!;
    } else if (userType == 'tutor') {
      phoneNo = arguments['phoneNo']!;
      education = arguments['education']!;
      availability = arguments['availability']!;
      experience = arguments['experience']!;
      subjects = arguments['subjects']!;
      resume = arguments['resume']!;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: CustomTextWidget(
                text: 'User Guidelines',
                textColor: blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '1.Online guides for tutors and students:',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            const CustomTextWidget(
              text:
                  'Access comprehensive resources for effective tutoring. Empower yourself with tools and tips for successful learning. Enhance your tutoring skills and optimize your learning experience.',
              textColor: bluishGreyColor,
              fontSize: 21,
            ),
            const SizedBox(height: 20),
            const Text(
              '2.Terms and Policies:',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            const CustomTextWidget(
              text:
                  'Familiarize yourself with our rules and regulations. Understand the guidelines to ensure fair and responsible usage. By accepting our terms, you agree to abide by our policies.',
              textColor: bluishGreyColor,
              fontSize: 21,
            ),
            const SizedBox(height: 20),
            Center(
              child: AgreeButtonWithCheckbox(
                onCheckboxChanged: (value) {},
                onButtonTap: () async {
                  try {
                    final FirebaseAuthService authService =
                        FirebaseAuthService();

                    // Call the unified signUp method
                    await authService.signUp(
                      email: email,
                      password: password,
                      name: name,
                      userType: userType,
                      institute: userType == 'student' ? institute : '',
                      year: userType == 'student' ? year : '',
                      learningFormat:
                          userType == 'student' ? learningFormat : '',
                      preferredDays: userType == 'student' ? preferredDays : '',
                      preferredTime: userType == 'student' ? preferredTime : '',
                      phoneNo: userType == 'tutor' ? phoneNo : '',
                      education: userType == 'tutor' ? education : '',
                      availability: userType == 'tutor' ? availability : '',
                      experience: userType == 'tutor' ? experience : '',
                      subjects: userType == 'tutor' ? subjects : '',
                      resume: userType == 'tutor' ? resume : '',
                    );

                    // Navigate based on userType
                    if (userType == 'student') {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homeWrapper,
                        arguments: 'student',
                      );
                    } else if (userType == 'tutor') {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homeWrapper,
                        arguments: 'tutor',
                      );
                    } else {
                      // Handle the case if the userType is missing or invalid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unknown user type')),
                      );
                    }
                  } catch (e) {
                    // Handle the error, e.g., show a Snackbar
                  }
                },
                text: 'Agree Terms & Conditions?',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgreeButtonWithCheckbox extends StatefulWidget {
  final bool initialCheckboxValue;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onButtonTap;
  final String text;

  const AgreeButtonWithCheckbox({
    super.key,
    this.initialCheckboxValue = false,
    required this.onCheckboxChanged,
    required this.onButtonTap,
    required this.text,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AgreeButtonWithCheckboxState createState() =>
      _AgreeButtonWithCheckboxState();
}

class _AgreeButtonWithCheckboxState extends State<AgreeButtonWithCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialCheckboxValue;
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomTextWidget(
            text: 'Alert',
            textColor: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          content: const CustomTextWidget(
            text: 'You must agree with our Terms & Policies to continue.',
            textColor: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            TextButton(
              child: const CustomTextWidget(
                text: 'OK',
                textColor: lightBlueColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_isChecked) {
          widget.onButtonTap();
        } else {
          _showAlertDialog(context);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: lightBlueColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isChecked = !_isChecked;
                  widget.onCheckboxChanged(_isChecked);
                });
              },
              child: Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value ?? false;
                    widget.onCheckboxChanged(_isChecked);
                  });
                },
                activeColor: Colors.transparent, // Transparent fill color
                checkColor: Colors.black, // Black check mark color
              ),
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
