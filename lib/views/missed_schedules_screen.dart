import 'package:flutter/material.dart';
import 'package:tutor_matchup/widgets/appointed_tutor_card.dart';
import '../utils/colors.dart';
import '../widgets/custom_text_widget.dart';

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
                    0.2, // Set the height of each item
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        currentIndex: 0,
        onTap: (value) {},
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: lightBlueColor),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
