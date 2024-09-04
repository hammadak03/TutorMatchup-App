import 'package:flutter/material.dart';
import 'package:tutor_matchup/widgets/appointed_tutor_card.dart';
import '../utils/colors.dart';
import '../widgets/custom_text_widget.dart';
import 'package:tutor_matchup/routes/routes.dart';

class UpcomingScheduleScreen extends StatelessWidget {
  const UpcomingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          fontSize: 16,
        ),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView.builder(
          itemCount: 14,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: const AppointedTutorCard(
                  name: 'Engr. Sarfaraz',
                  date: 'Monday, 15 April',
                  time: '11:00 - 12:00 AM',
                  subjects: 'Mathematics',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
