import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/appointed_tutor_card.dart';
import '../../widgets/custom_text_widget.dart';

class CompletedSchedulesScreen extends StatefulWidget {
  const CompletedSchedulesScreen({super.key});

  @override
  State<CompletedSchedulesScreen> createState() => _CompletedSchedulesScreenState();
}

class _CompletedSchedulesScreenState extends State<CompletedSchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Completed Schedules',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('schedules')
              .where('studentId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('status', isEqualTo: 'completed')
              .where('dateTime', isLessThan: DateTime.now()) // Filter by past date
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final schedules = snapshot.data!.docs;
              return ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final scheduleData =
                  schedules[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: AppointedTutorCard(
                        onTap: () {},
                        name: scheduleData['tutorName'] ?? 'Unknown Tutor',
                        date: scheduleData['date'] ?? 'Unknown Date',
                        time: scheduleData['time'] ?? 'Unknown Time',
                        subjects: scheduleData['subjects'] ?? 'Unknown Subjects',
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
