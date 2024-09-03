import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/views/inbox_screen.dart';
import 'package:tutor_matchup/views/profile_screen.dart';
import 'student_home_screen.dart';
import 'upcoming_schedule_screen.dart';

class StudentHomeWrapper extends StatefulWidget {
  const StudentHomeWrapper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentHomeWrapperState createState() => _StudentHomeWrapperState();
}

class _StudentHomeWrapperState extends State<StudentHomeWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const StudentHomeScreen(),
    const UpcomingScheduleScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: whiteColor,
        selectedItemColor: lightBlueColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
