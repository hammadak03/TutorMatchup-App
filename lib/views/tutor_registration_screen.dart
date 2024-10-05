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
  final TextEditingController timeController = TextEditingController();

  final TextEditingController othersEducationController =
      TextEditingController();

  String? selectedEducation;
  bool isOthersSelected = false; // Track if "Others" is selected
  File? resumeFile;
  List<String> selectedDays = [];
  bool isUploading = false;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Method to select both start and end times
  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeOfDay? pickedStartTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedStartTime != null) {
      final TimeOfDay? pickedEndTime =
          await showTimePicker(context: context, initialTime: pickedStartTime);
      if (pickedEndTime != null) {
        setState(() {
          startTime = pickedStartTime;
          endTime = pickedEndTime;
          timeController.text =
              '${pickedStartTime.format(context)} - ${pickedEndTime.format(context)}';
        });
      }
    }
  }

  final List<String> educationLevels = [
    'Matriculation',
    'Intermediate',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'MPhil',
    'PhD',
    'Teaching Certificate',
    'Professional Certifications',
    'Dars-e-Nizami',
    'Alim/Alima',
    'Others',
  ];

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
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
                }).toList(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      availabilityController.text = selectedDays.join(', ');
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
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15, // Increased padding for height consistency
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                value: selectedEducation,
                items: educationLevels.map((level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEducation = value;
                    isOthersSelected =
                        value == 'Others'; // Check if "Others" is selected
                  });
                },
              ),
            ),

            // Show custom TextField when "Others" is selected
            if (isOthersSelected)
              CustomTextField(
                controller: othersEducationController,
                hintText: 'Please specify your highest education',
              ),

            CustomTextField(
              controller: availabilityController,
              hintText: 'Availability',
              onTap: _showDaySelectionModal,
              readOnly: true,
            ),
            CustomTextField(
              controller: timeController,
              hintText: 'Preferred Time Range',
              onTap: () => _selectTimeRange(context),
              readOnly: true,
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
                    timeController.text.isNotEmpty &&
                    subjectsController.text.isNotEmpty) {
                  String? resumeUrl = await _uploadResume();
                  // Call your registration API or Firebase function here
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                }
              },
              buttonText: 'Register',
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
