import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/lecture_request_card.dart';
import 'package:tutor_matchup/widgets/upcomming_lecture_card.dart';

class TutorHomeScreen extends StatefulWidget {
  const TutorHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TutorHomeScreenState createState() => _TutorHomeScreenState();
}

class _TutorHomeScreenState extends State<TutorHomeScreen> {
  double upcomingClasses = 0.5; // Default height factor for upcoming tutors

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                ],
              ),
            ), //appba4/intro
            const SizedBox(height: 10),
            // Upcoming Tutors ListView
            Expanded(
              flex: (upcomingClasses * 100)
                  .toInt(), // Dynamically adjust based on panel slide
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: UpcommingLectureCard(
                      name: 'Class ${index + 1}',
                      availableDays: 'Monday, 16 Sept',
                      availableTime: '${index + 1}:00 - ${index + 2}:00 pm',
                      subjects: (index % 2 == 0) ? 'Maths' : 'Biology',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: CustomTextWidget(
                  text: 'Lecture Requests',
                  fontWeight: FontWeight.w700,
                  textColor: midnightBlueColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Near Tutors ListView
            Expanded(
              flex: (100 - (upcomingClasses * 100))
                  .toInt(), // Reverse of Upcoming Tutors
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: LectureRequestCard(
                      name: 'Student ${index + 1}',
                      year: '3rd Year',
                      grade: 'CGPA 3.25',
                      institute: index % 2 == 0
                          ? 'Mehran University'
                          : 'Sindh University',
                    ),
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

class QuickAccessButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;

  const QuickAccessButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
        CustomTextWidget(
          text: text,
          textColor: blackColor,
          fontSize: 14,
        ),
      ],
    );
  }
}
