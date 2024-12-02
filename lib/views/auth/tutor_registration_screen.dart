import 'dart:convert';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:tutor_matchup/routes/routes.dart'; // Assuming this manages routing in your app
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:flutter/services.dart' show rootBundle;

class TutorRegistrationScreen extends StatefulWidget {
  const TutorRegistrationScreen({super.key});
//
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

  List<String> subjects = [];
  Set<String> selectedSubject = {};
  bool showOtherField = false;
  TextEditingController otherSubjectController = TextEditingController();

  String? selectedEducation;
  bool isOthersSelected = false;
  File? resumeFile;
  List<String> selectedDays = [];
  bool isUploading = false;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    final String response = await rootBundle.loadString('assets/subjects.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      subjects = data.cast<String>();
    });
  }

  Future<void> addNewSubject(String newSubject) async {
    // 1. Load existing subjects
    final String response = await rootBundle.loadString('assets/subjects.json');
    final List<dynamic> data = json.decode(response);

    // 2. Add the new subject
    if (!data.contains(newSubject)) {
      data.add(newSubject);
    }

    // 3. Convert back to JSON and write to file
    final String updatedJson = json.encode(data);
    // You'll need to handle writing to the file here.
    // This usually involves platform-specific code or using a package
    // like path_provider to get the app's documents directory.
    // Example using path_provider:
    // final directory = await getApplicationDocumentsDirectory();
    // final file = File('${directory.path}/subjects.json');
    // await file.writeAsString(updatedJson);

    // 4. Update the subjects list in the UI
    setState(() {
      subjects = data.cast<String>();
      selectedSubject.add(newSubject); // Select the new subject
      showOtherField = false; // Hide the "Other" field
      otherSubjectController.clear(); // Clear the "Other" field
    });
  }

  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      final TimeOfDay? pickedEndTime = await showTimePicker(
        context: context,
        initialTime: pickedStartTime,
      );
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

  Future<void> _pickResumeFile() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
    // );

    // if (result != null) {
    //   setState(() {
    //     resumeFile = File(result.files.single.path!);
    //   });
    // }
  }

  Future<void> _registerAndNavigate() async {
    // Ensure form is filled
    if (nameController.text.isNotEmpty
        // emailController.text.isNotEmpty &&
        // passwordController.text.isNotEmpty &&
        // phoneNoController.text.isNotEmpty
    ) {
      // Upload resume
      String? resumeUrl = await _uploadResume();

      // Check if resumeUrl is null
      // if (resumeUrl == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Failed to upload resume.')),
      //   );
      //   return; // Exit the function if the resume upload fails
      // }

      // Navigate to the User Guidelines page with form data
      Navigator.pushNamed(
        context,
        Routes.tutorAddress,
        arguments: {
          'userType': 'tutor', // Add userType
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text, // Pass the password
          'phoneNo': phoneNoController.text,
          'education': selectedEducation == 'Others'
              ? othersEducationController.text
              : selectedEducation,
          'availability': availabilityController.text,
          'experience': experienceController.text,
          'subjects': subjectsController.text,
          'resume': resumeUrl, // Rename to 'resume' for consistency
        },
      );
    } else {
      // Show a more specific error message for the missing required fields
      String errorMessage = '';
      if (nameController.text.isEmpty) {
        errorMessage += 'Name is required.\n';
      }
      if (emailController.text.isEmpty) {
        errorMessage += 'Email is required.\n';
      }
      if (passwordController.text.isEmpty) {
        errorMessage += 'Password is required.\n';
      }
      if (selectedSubject.isEmpty) {
        errorMessage += 'Please select at least one subject.\n';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
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
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Highest Level of Education',
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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
                          isOthersSelected = value == 'Others';
                        });
                      },
                    ),
                ),
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
                Text('Subjects want to teach:'),
                Wrap(
                    spacing: 8.0,
                    children: subjects.map((subject) {
                      return ChoiceChip(
                        label: Text(subject),
                        selected: selectedSubject.contains(subject),                      onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedSubject.add(subject);
                              if (subject == "Other") {
                                showOtherField = true;
                              }
                            } else {
                              selectedSubject.remove(subject);
                              if (subject == "Other") {
                                showOtherField = false;
                              }
                            }

                          });
                        },
                      );
                    }).toList(),
                  ),
                if (showOtherField)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: otherSubjectController,
                          decoration: const InputDecoration(
                            labelText: 'Please specify other subject',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (otherSubjectController.text.isNotEmpty) {
                            addNewSubject(otherSubjectController.text);
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                const SizedBox(height: 5),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: InkWell(
                //     onTap: _pickResumeFile,
                //     child: Container(
                //       padding:
                //       const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(8.0),
                //       ),
                //       child: Row(
                //         children: [
                //           const Icon(Icons.attach_file, color: Colors.grey),
                //           const SizedBox(width: 10),
                //           Expanded(
                //             child: Text(
                //               resumeFile != null
                //                   ? 'Resume Selected'
                //                   : 'Attach Resume (PDF/Image)',
                //               style: const TextStyle(color: Colors.grey),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                CustomButton(
                  buttonText: isUploading ? 'Uploading Resume...' : 'Next',
                  // onTap: isUploading ? null : _registerAndNavigate,
                  onTap: isUploading
                      ? () {}
                      : () async {
                    await _registerAndNavigate();
                  },
                ),
                const SizedBox(height: 20),
              ],),),
        ));
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
                }),
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
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }
}
