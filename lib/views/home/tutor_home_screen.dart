import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

import '../../widgets/lecture_card.dart';
import '../messages/chat_screen.dart';
import '../profile/tutor_profile_screen.dart';
import '../schedules/tutor_schedule_screen.dart';

class TutorHomeScreen extends StatefulWidget {
  const TutorHomeScreen({Key? key}) : super(key: key);

  @override
  State<TutorHomeScreen> createState() => _TutorHomeScreenState();
}

class _TutorHomeScreenState extends State<TutorHomeScreen> {
  int _currentIndex = 0;

  // List of screens for the bottom navigation
  final List<Widget> _screens = [
    const HomeTab(),
    const TutorScheduleScreen(),
    const ChatScreen(),
    const TutorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: lightBlueColor,
        unselectedItemColor: coolGrayColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home tab content
class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: CustomTextWidget(
                text: 'Upcoming Lectures',
                fontWeight: FontWeight.w700,
                textColor: midnightBlueColor,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return LectureCard(
                    name: 'Class ${index + 1}',
                    availableDays: 'Monday, 16 Sept',
                    availableTime: '${index + 1}:00 - ${index + 2}:00 pm',
                    subjects: index.isEven ? 'Maths' : 'Biology',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
