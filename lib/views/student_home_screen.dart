import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        icon: Icon(Icons.notifications_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Ahmed',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomTextWidget(
                              text: 'Biology-Maths',
                              fontSize: 14,
                              textColor: Color(0xFFCBE1FF),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.22,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: whiteColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.white38,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: whiteColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomTextWidget(text: 'Monday-Tuesday')
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.history_toggle_off_outlined,
                              color: whiteColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomTextWidget(text: '5:00 - 6:00 PM')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
