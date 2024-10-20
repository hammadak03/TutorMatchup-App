import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class TutorDetailsSceens extends StatelessWidget {
  const TutorDetailsSceens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'Tutor Details',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.92,
              decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 5),
                  const CustomTextWidget(
                    text: 'Hammad Ahmed',
                    textColor: whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 5),
                  const CustomTextWidget(
                    text: 'Lorem ipsum dolor sit amet.',
                    textColor: lightPeriwinkleColor,
                  ),
                  const SizedBox(height: 5),
                  const CustomTextWidget(
                    text: '4.8 (120 Reviews)',
                    textColor: amberColor,
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.location_pin, color: whiteColor),
                          CustomTextWidget(
                            text: 'Hyderabad',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.calendar_month, color: whiteColor),
                          CustomTextWidget(
                            text: 'Sun - Fri',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.alarm, color: whiteColor),
                          CustomTextWidget(
                            text: '9AM - 3PM',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showLectureSelection(context);
                        },
                        child: const CustomTextWidget(
                          text: 'Request',
                          textColor: lightBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //TODO: Handle onpressed message button
                        },
                        child: const CustomTextWidget(
                          text: 'Message',
                          textColor: lightBlueColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'About',
                      textColor: midnightBlueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CustomTextWidget(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      textColor: bluishGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show the bottom sheet with a list of upcoming lectures or custom request form
  void _showLectureSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomTextWidget(
                    text: 'Upcoming Lectures',
                    textColor: midnightBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Dummy data for the upcoming lectures
                ListTile(
                  title: const CustomTextWidget(
                    text: 'Lecture 1: Math Basics',
                    textColor: bluishGreyColor,
                  ),
                  subtitle: const CustomTextWidget(
                    text: 'Oct 21, 2024 - 10AM',
                    textColor: lightBlueColor,
                  ),
                  onTap: () {
                    // Handle selecting this lecture and sending request
                    Navigator.pop(context);
                    _sendRequest(context, 'Math Basics');
                  },
                ),
                ListTile(
                  title: const CustomTextWidget(
                    text: 'Lecture 2: Physics Advanced',
                    textColor: bluishGreyColor,
                  ),
                  subtitle: const CustomTextWidget(
                    text: 'Oct 22, 2024 - 1PM',
                    textColor: lightBlueColor,
                  ),
                  onTap: () {
                    // Handle selecting this lecture and sending request
                    Navigator.pop(context);
                    _sendRequest(context, 'Physics Advanced');
                  },
                ),
                // Option for custom request
                ListTile(
                  title: const CustomTextWidget(
                    text: 'Send Custom Request',
                    textColor: amberColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showCustomRequestForm(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show form for sending a custom request
  void _showCustomRequestForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController dateController = TextEditingController();
        TextEditingController timeController = TextEditingController();
        TextEditingController topicController = TextEditingController();

        return AlertDialog(
          title: const CustomTextWidget(
            text: 'Custom Request',
            textColor: midnightBlueColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: topicController,
                decoration: const InputDecoration(labelText: 'Topic'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle sending custom request here
                Navigator.pop(context);
                _sendCustomRequest(
                  context,
                  topicController.text,
                  dateController.text,
                  timeController.text,
                );
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }

  // Function to send a lecture request
  void _sendRequest(BuildContext context, String lecture) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request sent for $lecture')),
    );
  }

  // Function to send a custom lecture request
  void _sendCustomRequest(
      BuildContext context, String topic, String date, String time) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Custom request sent for $topic on $date at $time')),
    );
  }

  // Example Firebase method to fetch upcoming lectures from Firestore
  // Future<List<Lecture>> _fetchLecturesFromFirebase() async {
  //   CollectionReference tutors = FirebaseFirestore.instance.collection('tutors');
  //   DocumentSnapshot tutorDoc = await tutors.doc('tutorId').get();
  //   List lectures = tutorDoc['lectures']; // Array of lectures
  //   // Parse the lectures and return
  //   return lectures.map((lecture) => Lecture.fromFirestore(lecture)).toList();
  // }
}
