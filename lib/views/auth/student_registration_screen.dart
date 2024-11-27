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
  int _currentStep = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController learningFormatController =
  TextEditingController();
  final TextEditingController preferredDaysController = TextEditingController();
  final TextEditingController preferredTimeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

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
    'HSC-2',
    'FSC-1',
    'FSC-2',
  ];
  final List<String> learningFormats = ['In-Person', 'Online', 'Hybrid'];
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  List<String> provinces = [];
  List<String> cities = [];
  List<String> regions = [];

  // Variables to store user selections
  String? selectedGrade;
  String? selectedLearningFormat;
  List<String> selectedDays = [];
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load JSON data for provinces, cities, and regions
  Future<void> _loadData() async {
      final regionsData = await DefaultAssetBundle.of(context)
          .loadString('assets/pakistan_regions.json');
      final citiesData = await DefaultAssetBundle.of(context)
          .loadString('assets/pakistan_cities.json');

      setState(() {
        final decodedData = json.decode(regionsData);
        provinces = List<String>.from(decodedData['provinces']);
        regions = List<String>.from(json.decode(regionsData)['regions']);
        cities = List<String>.from(json.decode(citiesData)['cities']);
      });
  }

  // Select time using the time picker
  Future<void> _selectTime(BuildContext context) async {
    final pickedTime =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        preferredTimeController.text = pickedTime.format(context);
      });
    }
  }

  // Dropdown for Grade/Year selection
  void _showDropdown(List<String> items, TextEditingController controller) {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (context) => ListView(
        children: items.map((item) {
          return ListTile(
            title: CustomTextWidget(
              text: item,
              textColor: blackColor,
            ),
            onTap: () {
              setState(() {
                controller.text = item;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  // // Method to select a time using the time picker
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime =
  //   await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //   if (pickedTime != null) {
  //     setState(() {
  //       selectedTime = pickedTime;
  //       preferredTimeController.text = pickedTime.format(context);
  //     });
  //   }
  // }

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
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: ()
    {
      if (_currentStep < 2) {
        setState(() {
          _currentStep++;
        });
      } else {
        // Final step action
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            yearController.text.isNotEmpty &&
            learningFormatController.text.isNotEmpty &&
            preferredDaysController.text.isNotEmpty &&
            preferredTimeController.text.isNotEmpty) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.studentHome,
                (route) => false,
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
              'province': provinceController.text,
              'city': cityController.text,
              'region': regionController.text,
            },
          );
        } else {
          // Handle empty fields, show a message
        }
      }
      },
    onStepCancel : (){
        if (_currentStep > 0){
          setState(() {
            _currentStep--;
          });
    }
    },
    steps: [
      Step(
    title: const Text('Basic Info'),
    content: Column(
    children: [
      CustomTextField(hintText: 'Name', controller: nameController,),
    CustomTextField(hintText: 'Email', controller: emailController,),
    CustomTextField(
    hintText: 'Password',
    controller: passwordController,
    suffixIcon: IconButton(
    icon: const Icon(Icons.visibility_off),
    onPressed: (){},
      ),
    )
    ],
    ),
    ),
    Step(
    title: const Text('Academic Details'),
    content: Column(
      children: [
      CustomTextField(
    hintText: 'School/College/University',
    controller: instituteController,
    ),
    CustomTextField(
    hintText: 'Grade/Year',
    controller: yearController,
    onTap: ()=> _showDropdown(grades, yearController),
    readOnly: true,
    ),
    CustomTextField(
    hintText: 'Learning Format',
    controller: learningFormatController,
    onTap: ()=> _showDropdown(learningFormats, learningFormatController),
    readOnly: true,
    )
      ],
    )
    )
    ,
      Step(
        title: const Text('Loction Details'),
        content: Column(
          children: [
            CustomTextField(
                hintText: 'Province',
              controller: provinceController,
              onTap: () => _showDropdown(provinces, provinceController),
              suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                onPressed: () => _showDropdown(provinces, provinceController),
              ),
              readOnly: false,
            ),
            CustomTextField(
              hintText: 'City',
              controller: cityController,
              onTap: () => _showDropdown(cities, cityController),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () => _showDropdown(cities, cityController),
              ),
              readOnly: false,
            ),
            CustomTextField(
              hintText: 'Region',
              controller: regionController,
              onTap: () => _showDropdown(regions, regionController),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () => _showDropdown(regions, regionController),
              ),
              readOnly: false,
            ),
          ],
        )
    )

    ]
      ),
    );
  }
}