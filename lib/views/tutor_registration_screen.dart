import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class TutorRegistrationScreen extends StatefulWidget {
  const TutorRegistrationScreen({super.key});

  @override
  _TutorRegistrationScreenState createState() =>
      _TutorRegistrationScreenState();
}

class _TutorRegistrationScreenState extends State<TutorRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController subjectsController = TextEditingController();

  String? selectedEducation;
  File? resumeFile;
  bool isUploading = false;

  final List<String> educationLevels = [
    'BE',
    'MSc',
    'PhD',
    'Other',
  ];

  // Function to upload resume
  Future<String?> _uploadResume() async {
    if (resumeFile == null) return null;

    setState(() {
      isUploading = true;
    });

    try {
      String fileName =
          'resumes/${DateTime.now().millisecondsSinceEpoch.toString()}';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(resumeFile!);

      await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        isUploading = false;
      });

      return downloadUrl;
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      return null;
    }
  }

  // Function to pick a file (PDF or image)
  Future<void> _pickResumeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        resumeFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CustomTextWidget(
              text: 'Tutor Registration',
              textColor: blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(
              height: 5,
            ),

            // Dropdown for Highest Level of Education
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Highest Level of Education',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                value: selectedEducation,
                items: educationLevels
                    .map((level) => DropdownMenuItem<String>(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEducation = value;
                  });
                },
              ),
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
            const SizedBox(
              height: 5,
            ),
            // Attach Resume (file picker)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: _pickResumeFile,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          resumeFile != null
                              ? 'Resume Selected'
                              : 'Attach Resume (PDF/Image)',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            CustomButton(
              onTap: () async {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    phoneNoController.text.isNotEmpty &&
                    selectedEducation != null &&
                    availabilityController.text.isNotEmpty &&
                    experienceController.text.isNotEmpty &&
                    subjectsController.text.isNotEmpty) {
                  String? resumeUrl = await _uploadResume();

                  Navigator.pushNamed(
                    context,
                    Routes.userGuidelines,
                    arguments: {
                      'userType': 'tutor',
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'phoneNo': phoneNoController.text,
                      'education': selectedEducation,
                      'availability': availabilityController.text,
                      'experience': experienceController.text,
                      'subjects': subjectsController.text,
                      'resumeUrl': resumeUrl,
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
