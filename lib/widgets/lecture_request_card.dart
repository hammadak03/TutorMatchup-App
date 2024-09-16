import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'custom_text_widget.dart';

class LectureRequestCard extends StatelessWidget {
  final String name;
  final String institute;
  final String year;
  final String grade;
  const LectureRequestCard(
      {required this.name,
      required this.year,
      required this.grade,
      required this.institute,
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
                          text: institute,
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Color(0xFFCBE1FF),
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
                      Icons.school,
                      color: Color(0xFFFEB052),
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: year,
                      textColor: const Color(0xFFFEB052),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: lightBlueColor,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: grade,
                      textColor: lightBlueColor,
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
