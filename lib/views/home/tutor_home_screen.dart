import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/lecture_request_card.dart';
import 'package:tutor_matchup/widgets/upcomming_lecture_card.dart';

class TutorHomeScreen extends StatefulWidget {
  const TutorHomeScreen({Key? key}) : super(key: key);

  @override
  _TutorHomeScreenState createState() => _TutorHomeScreenState();
}

class _TutorHomeScreenState extends State<TutorHomeScreen> {
  final double upcomingClassesRatio = 0.5; // Adjust the ratio as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Tutor Home',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
            Expanded(
              flex: (upcomingClassesRatio * 100).toInt(),
              child: _buildUpcomingLectures(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: CustomTextWidget(
                text: 'Lecture Requests',
                fontWeight: FontWeight.w700,
                textColor: midnightBlueColor,
                fontSize: 16,
              ),
            ),
            Expanded(
              flex: (100 - (upcomingClassesRatio * 100)).toInt(),
              child: _buildLectureRequests(),
            ),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Hello, ',
                fontSize: 16,
                textColor: coolGrayColor,
              ),
              CustomTextWidget(
                text: 'Hi Hammad',
                fontWeight: FontWeight.w700,
                textColor: blackColor,
                fontSize: 20,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {}, // Add notification logic
                icon: const Icon(Icons.notifications_outlined),
              ),
              IconButton(
                onPressed: () {}, // Add menu logic
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Upcoming Lectures Section
  Widget _buildUpcomingLectures() {
    return ListView.separated(
      itemCount: 4,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        return UpcommingLectureCard(
          onTap: () {
            Navigator.pushNamed(context, Routes.classSession);
          },
          name: 'Class ${index + 1}',
          availableDays: 'Monday, 16 Sept',
          availableTime: '${index + 1}:00 - ${index + 2}:00 pm',
          subjects: index.isEven ? 'Maths' : 'Biology',
        );
      },
    );
  }

  // Lecture Requests Section
  Widget _buildLectureRequests() {
    return ListView.separated(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        return LectureRequestCard(
          name: 'Student ${index + 1}',
          year: '3rd Year',
          grade: 'CGPA 3.25',
          institute: index.isEven ? 'Mehran University' : 'Sindh University',
        );
      },
    );
  }
}
