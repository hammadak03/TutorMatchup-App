import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/near_tutor_card.dart';
import 'package:tutor_matchup/widgets/upcomming_lecture_card.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
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
                        textColor: Color(0xFF8696BB),
                      ),
                      CustomTextWidget(
                        text: 'Hi Sana Ali',
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: UpcommingLectureCard(
                        name: 'Ahmed',
                        availableDays: 'Monday-Tuesday',
                        availableTime: '5:00 - 6:00 pm',
                        subjects: 'Biology - Maths'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
              hintText: 'Search tutor or Subjects',
              prefixIcon: Icon(Icons.search),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickAccessButton(
                  icon: const Icon(Icons.note_alt_outlined),
                  text: 'Assignment',
                  onPressed: () {},
                ),
                QuickAccessButton(
                  icon: const Icon(Icons.person_add_alt_1),
                  text: 'Tutors',
                  onPressed: () {},
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: NearTutorCard(
                        name: 'Mamtaz Pawnar',
                        reviews: '4.8 (120 Reviews)',
                        location: '1.8 Km',
                        opensAt: 'Open at 4:00pm',
                        subjects: 'Physics Specialist'),
                  );
                },
              ),
            )
          ],
        ),
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
