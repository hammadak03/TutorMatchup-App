import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController learningFormatController =
      TextEditingController();
  final TextEditingController preferredDaysController = TextEditingController();
  final TextEditingController preferredTimeController = TextEditingController();

  // Options for dropdowns and checkboxes
  final List<String> grades = [
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
    'Grade 6',
    'Grade 7',
    'Grade 8',
    'SSC-1',
    'SSC-2',
    'HSC-1',
    'HSC-2'
  ];
  final List<String> learningFormats = ['In-Person', 'Online', 'Hybrid'];
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  // Variables to store user selections
  String? selectedGrade;
  String? selectedLearningFormat;
  List<String> selectedDays = [];
  TimeOfDay? selectedTime;

  // Method to select a time using the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        preferredTimeController.text = pickedTime.format(context);
      });
    }
  }

  // Dropdown for Grade/Year selection
  void _showGradeDropdown() {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (context) => ListView(
        children: grades.map((grade) {
          return ListTile(
            title: CustomTextWidget(
              text: grade,
              textColor: blackColor,
            ),
            onTap: () {
              setState(() {
                selectedGrade = grade;
                yearController.text = grade;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  // Dropdown for Learning Format selection
  void _showLearningFormatDropdown() {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (context) => ListView(
        children: learningFormats.map((format) {
          return ListTile(
            title: CustomTextWidget(
              text: format,
              textColor: blackColor,
            ),
            onTap: () {
              setState(() {
                selectedLearningFormat = format;
                learningFormatController.text = format;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  // Modal for Preferred Days selection (multiple selection)
  void _showDaySelectionModal() {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomTextWidget(
                    text: 'Select Preferred Days',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: blackColor,
                  ),
                ),
                ...days.map((day) {
                  bool isSelected = selectedDays.contains(day);
                  return CheckboxListTile(
                    title: CustomTextWidget(
                      text: day,
                      textColor: blackColor,
                    ),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setStateModal(() {
                        if (value == true) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    },
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      preferredDaysController.text = selectedDays.join(', ');
                    });
                    Navigator.pop(context);
                  },
                  child: const CustomTextWidget(
                    text: 'Confirm',
                    textColor: lightBlueColor,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

            // Grade/Year field with dropdown
            CustomTextField(
              controller: yearController,
              hintText: 'Grade/Year',
              onTap: _showGradeDropdown,
              readOnly: true,
            ),

            // Learning Format field with dropdown
            CustomTextField(
              controller: learningFormatController,
              hintText: 'Learning Format',
              onTap: _showLearningFormatDropdown,
              readOnly: true,
            ),

            // Preferred Days field with multiple selection modal
            CustomTextField(
              controller: preferredDaysController,
              hintText: 'Preferred Days',
              onTap: _showDaySelectionModal,
              readOnly: true,
            ),

            // Preferred Time field with clock
            CustomTextField(
              controller: preferredTimeController,
              hintText: 'Preferred Time',
              onTap: () => _selectTime(context),
              readOnly: true,
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
