import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';

import 'custom_text_widget.dart';

class AppointedTutorCard extends StatelessWidget {
  final String name;
  final String subjects;
  final String date;
  final String time;
  const AppointedTutorCard(
      {required this.name,
      required this.date,
      required this.time,
      required this.subjects,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: name,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFF0D1B34),
                        ),
                        CustomTextWidget(
                          text: subjects,
                          fontSize: 14,
                          textColor: const Color(0xFF8696BB),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
              color: Colors.white38,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: Color(0xFF8696BB),
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: date,
                      fontSize: 12,
                      textColor: const Color(0xFF8696BB),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      color: Color(0xFF8696BB),
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: time,
                      fontSize: 12,
                      textColor: const Color(0xFF8696BB),
                    ),
                  ],
                )
              ],
            ),
            CustomButton(
              onTap: () {},
              buttonText: 'Details',
              backgroundColor: whiteColor,
              buttonTextColor: lightBlueColor,
              textSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
