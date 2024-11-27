import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/views/messages/inbox_screen.dart';
import 'package:tutor_matchup/views/profile/profile_screen.dart';
import 'package:tutor_matchup/views/schedules/upcoming_schedule_screen.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/near_tutor_card.dart';
import 'package:tutor_matchup/widgets/upcomming_lecture_card.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _currentIndex = 0;
  String _studentName = 'User';

  final List<Widget> _screens = [
    const StudentHomeScreen(),
    const UpcomingScheduleScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];

  @override
  void didChangeDependies(){
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _studentName = args?['name'] as String? ?? 'User';
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                      text: 'Hello ',
                    fontSize: 16,
                    textColor: Color((0xFF8696BB)),
          ),
          CustomTextWidget(
              text: 'Hi $_studentName',
            fontWeight: FontWeight.w700,
            textColor: blackColor,
            fontSize: 20,
          ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.notifications_outlined),
    ),
    IconButton(
    onPressed: (){},
    icon: const Icon(Icons.menu),
    ),
                ],
              ),
            ],
          ),
        ),
        // Greeting Section
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
              itemCount: 4,
                itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: UpcommingLectureCard(
                      name: 'Ahmed',
                      availableDays: 'Monday-Tuesday',
                      availableTime: '5:00 - 6:00 pm',
                      subjects: 'Biology - Maths',
                    onTap: (){
                      Navigator.pushNamed(context, Routes.classSession);
                    },
                  ),
                );
                },
            ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
            hintText: 'Search tutor or subjects',
          prefixIcon: const Icon(Icons.search),
          onTap: (){
              Navigator.pushNamed(context, Routes.searchResults);
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuickAccessButton(
                onPressed: (){},
                icon: const Icon((Icons.note_alt_outlined)),
                text: 'Assignment',
            ),
            QuickAccessButton(
                onPressed: (){},
                icon: const Icon(Icons.person_add_alt_1),
                text: 'Tutors',
            ),
            QuickAccessButton(
              icon: const Icon(Icons.menu_book_outlined),
              text: 'Subjects',
              onPressed: () {},
            ),
            QuickAccessButton(
              icon: const Icon(Icons.house_rounded),
              text: 'Hybrid',
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: CustomTextWidget(
                text: 'Near Tutors',
              fontWeight: FontWeight.w700,
              textColor: midnightBlueColor,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
            child: ListView.builder(
                itemCount: 6,
              itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: NearTutorCard(name: 'Mamtaz Pawnar',
                      reviews: '4.8 (120 Reviews)',
                      location: '1.8 Km',
                      opensAt: 'Open at 4:00pm',
                      subjects: 'Physics Specialist',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.tutorDetails);
                      },
                    ),
                  );
              },
            ),
        ),
      ]
    );
  }

  Widget _buildUpcomingScheduleScreen(){
    return Center(
      child: Text(
        'Upcoming Schedule Screen',
        style: TextStyle(fontSize: 18, color: blackColor),
      ),
    );
  }

  Widget _buildInboxScreen(){
    return Center(
      child: Text(
        'Inbox Screen',
        style: TextStyle(fontSize: 18, color: blackColor),
      ),
    );
  }

  Widget _buildProfileScreen(){
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 18, color: blackColor),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: _screens[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          _currentIndex = index;
        },
    type: BottomNavigationBarType.fixed,
    selectedItemColor: midnightBlueColor,
    unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.inbox),
          label: 'Inbox',
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

class QuickAccessButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String text;
  const QuickAccessButton(
      {required this.onPressed,
      required this.icon,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          color: lightBlueColor,
          onPressed: onPressed,
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextWidget(
          text: text,
          textColor: coolGrayColor,
        )
      ],
    );
  }
}
