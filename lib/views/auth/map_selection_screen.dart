import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class MapSelectionScreen extends StatefulWidget {
  const MapSelectionScreen({Key? key}) : super(key: key);

  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();

  String? _selectedLabel; // For the label buttons (Home, Work, Other)

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed data using ModalRoute
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    final String userType = arguments['userType'] ?? 'unknown';
    final String name = arguments['name'] ?? 'Guest';
    final String email = arguments['email'] ?? 'example@example.com';
    final String password = arguments['password'] ?? 'defaultPassword';

    // Specific fields based on user type
    late String institute, year, learningFormat, preferredDays, preferredTime;
    late String phoneNo, education, availability, experience, subjects;
    String? resume;

    if (userType == 'student') {
      institute = arguments['institute'] ?? '';
      year = arguments['year'] ?? '';
      learningFormat = arguments['learningFormat'] ?? '';
      preferredDays = arguments['preferredDays'] ?? '';
      preferredTime = arguments['preferredTime'] ?? '';
    } else if (userType == 'tutor') {
      phoneNo = arguments['phoneNo'] ?? '';
      education = arguments['education'] ?? '';
      availability = arguments['availability'] ?? '';
      experience = arguments['experience'] ?? '';
      subjects = arguments['subjects'] ?? '';
      resume = arguments['resume']; // This can remain null if not provided
    }

    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(text: 'Map Selection'),
        backgroundColor: lightBlueColor,
      ),
      body: Stack(
        children: [
          // Placeholder for the map (leave blank for now)
          Container(
            color: Colors.grey[300], // Placeholder for the map area
            height: MediaQuery.of(context).size.height * 0.6,
            child: const Center(
              child: Text('Map will be here'),
            ),
          ),
          // Sliding up panel
          SlidingUpPanel(
            minHeight: MediaQuery.of(context).size.height *
                0.05, // Height when collapsed
            maxHeight: MediaQuery.of(context).size.height *
                0.6, // Maximum height when expanded
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panel: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 70,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Street Name/Number
                  TextField(
                    controller: _streetNameController,
                    decoration: const InputDecoration(
                      labelText: 'Street Name/Number',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Floor
                  TextField(
                    controller: _floorController,
                    decoration: const InputDecoration(
                      labelText: 'Floor',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Street Address
                  TextField(
                    controller: _streetAddressController,
                    decoration: const InputDecoration(
                      labelText: 'Street Address',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Label (Home, Work, Other)
                  const Text('Label'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLabelButton('Home'),
                      _buildLabelButton('Work'),
                      _buildLabelButton('Other'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Gather all data
                        final mapData = {
                          'streetName': _streetNameController.text,
                          'floor': _floorController.text,
                          'streetAddress': _streetAddressController.text,
                          'label': _selectedLabel,
                          'userType': userType,
                          'name': name,
                          'email': email,
                          'password': password,
                          if (userType == 'student') ...{
                            'institute': institute,
                            'year': year,
                            'learningFormat': learningFormat,
                            'preferredDays': preferredDays,
                            'preferredTime': preferredTime,
                          } else if (userType == 'tutor') ...{
                            'phoneNo': phoneNo,
                            'education': education,
                            'availability': availability,
                            'experience': experience,
                            'subjects': subjects,
                            'resume': resume,
                          },
                        };

                        // Navigate to UserGuidelinesScreen with the new data
                        Navigator.pushNamed(
                          context,
                          Routes.userGuidelines, // Change to the actual route
                          arguments: mapData,
                        );
                      },
                      child: const Text('Proceed to Guidelines'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build label buttons (Home, Work, Other)
  Widget _buildLabelButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedLabel = label; // Set the selected label
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedLabel == label ? Colors.blue : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(label),
    );
  }
}
