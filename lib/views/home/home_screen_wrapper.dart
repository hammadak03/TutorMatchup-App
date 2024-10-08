// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/views/messages/inbox_screen.dart';
import 'package:tutor_matchup/views/profile/profile_screen.dart';
import 'student_home_screen.dart';
import 'tutor_home_screen.dart'; // Import the Tutor Home Screen
import '../schedules/upcoming_schedule_screen.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;
  late String userType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userType = ModalRoute.of(context)!.settings.arguments
        as String; // Retrieve userType
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = userType == 'student'
        ? [
            const StudentHomeScreen(),
            const UpcomingScheduleScreen(),
            const InboxScreen(),
            const ProfileScreen(),
          ]
        : [
            const TutorHomeScreen(), // Ensure TutorHomeScreen is defined
            const UpcomingScheduleScreen(),
            const InboxScreen(),
            const ProfileScreen(),
          ];

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: whiteColor,
        selectedItemColor: lightBlueColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
