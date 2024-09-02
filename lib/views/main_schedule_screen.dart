import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'student_home_screen.dart';
import 'upcoming_schedule_screen.dart';
import 'missed_schedules_screen.dart';

class MainScheduleScreen extends StatefulWidget {
  const MainScheduleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScheduleScreenState createState() => _MainScheduleScreenState();
}

class _MainScheduleScreenState extends State<MainScheduleScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const StudentHomeScreen(),
    const UpcomingScheduleScreen(),
    const MissedSchedulesScreen(), // Placeholder for the missed schedule screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: lightBlueColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
