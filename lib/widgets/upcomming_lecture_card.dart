import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';

import 'custom_text_widget.dart';

class UpcommingLectureCard extends StatelessWidget {
  final String name;
  final String subjects;
  final String availableDays;
  final String availableTime;
  final VoidCallback onTap;
  const UpcommingLectureCard(
      {required this.name,
      required this.onTap,
      required this.availableDays,
      required this.availableTime,
      required this.subjects,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          textColor: whiteColor,
                        ),
                        CustomTextWidget(
                          text: subjects,
                          fontSize: 14,
                          textColor: const Color(0xFFCBE1FF),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: whiteColor,
                      size: 40,
                    ),
                  ),
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
                      color: whiteColor,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: availableDays,
                      textColor: whiteColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      color: whiteColor,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: availableTime,
                      textColor: whiteColor,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
