import 'package:flutter/material.dart';
import 'package:tutor_matchup/widgets/appointed_tutor_card.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_text_widget.dart';

class MissedSchedulesScreen extends StatelessWidget {
  const MissedSchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Missed Schedules',
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
                height: MediaQuery.of(context).size.height *
                    0.22, // Set the height of each item
                child: AppointedTutorCard(
                  onTap: () {},
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
