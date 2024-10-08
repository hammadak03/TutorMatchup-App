import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_matchup/widgets/appointed_tutor_card.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_text_widget.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingScheduleScreen extends StatefulWidget {
  const UpcomingScheduleScreen({super.key});

  @override
  State<UpcomingScheduleScreen> createState() => _UpcomingScheduleScreenState();
}

class _UpcomingScheduleScreenState extends State<UpcomingScheduleScreen> {
  String userRole = ''; // Initialize to empty
  bool isLoading = true;

  List<Map<String, dynamic>> schedules = []; // Dummy list for schedules

  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classSubjectController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    _getUserRole();
    _loadDummyData(); // This can be modified later to load from Firestore
  }

  void _loadDummyData() {
    // Adjust this method to load actual data from Firestore later
    schedules = List.generate(
      userRole == 'student' ? 10 : 5,
      (index) => {
        'name': userRole == 'student'
            ? 'Engr. Sarfaraz'
            : 'Class ${index + 1} - 30 students',
        'date': 'Monday, 15 April',
        'time': '11:00 - 12:00 AM',
        'subject': 'Mathematics',
      },
    );
  }

  // Method to fetch user role from Firebase
  Future<void> _getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userRole =
              userDoc['userType']; // Assume 'role' is the field in Firestore
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false; // No role found
        });
      }
    } else {
      setState(() {
        isLoading = false; // No user signed in
      });
    }
  }

  // Method to open a dialog to add new session
  void _showAddSessionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Session'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: classNameController,
                  decoration: const InputDecoration(labelText: 'Class Name'),
                ),
                TextField(
                  controller: classSubjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _selectDate, // Open Date Picker
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : DateFormat('yyyy-MM-dd').format(selectedDate!),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: _selectTime, // Open Time Picker
                  child: Text(
                    selectedTime == null
                        ? 'Select Time'
                        : selectedTime!.format(context),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewSession(); // Add new session
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Schedule'),
            ),
          ],
        );
      },
    );
  }

  // Method to select date using DatePicker
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Method to select time using TimePicker
  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Method to add new session
  Future<void> _addNewSession() async {
    setState(() {
      schedules.add({
        'name': classNameController.text,
        'date': selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : 'No date selected',
        'time': selectedTime != null
            ? selectedTime!.format(context)
            : 'No time selected',
        'subject': classSubjectController.text,
      });
    });

    // Clear text fields after adding
    classNameController.clear();
    classSubjectController.clear();
    selectedDate = null;
    selectedTime = null;

    // Show SnackBar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New session added successfully!')),
    );

    // Uncomment and modify to add to Firebase once connected
    /*
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('sessions').add({
          'tutorId': user.uid,
          'name': classNameController.text,
          'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
          'time': selectedTime!.format(context),
          'subject': classSubjectController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('New session added successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding session: $e')),
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.completedSchedules);
            },
            child: const CustomTextWidget(
              text: 'Completed',
              fontSize: 12,
              textColor: Color(0xFF8696BB),
            ),
          ),
        ],
        leadingWidth: 67,
        leading: TextButton(
          child: const CustomTextWidget(
            text: 'Missed',
            textColor: Color(0xFF8696BB),
            fontSize: 12,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.missedSchedules);
          },
        ),
        title: const CustomTextWidget(
          text: 'Upcoming Schedule',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            var schedule = schedules[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.211,
                child: AppointedTutorCard(
                  onTap: () {
                    //TODO: Pass arguments, i.e. data of class session being tapped.
                    Navigator.pushNamed(context, Routes.classSession);
                  },
                  name: schedule['name'],
                  date: schedule['date'],
                  time: schedule['time'],
                  subjects: schedule['subject'],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: userRole == 'tutor' // Show FAB only for tutors
          ? FloatingActionButton(
              onPressed: _showAddSessionDialog,
              backgroundColor: lightBlueColor,
              child: const Icon(
                Icons.add,
                color: whiteColor,
              ),
            )
          : null, // Null means no FAB for students
    );
  }
}
