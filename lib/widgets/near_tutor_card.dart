import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'custom_text_widget.dart';

class NearTutorCard extends StatelessWidget {
  final String name;
  final String subjects;
  final String location;
  final String reviews;
  final String opensAt;
  final VoidCallback onPressed;
  const NearTutorCard(
      {required this.name,
      required this.reviews,
      required this.location,
      required this.onPressed,
      required this.opensAt,
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
                          textColor: midnightBlueColor,
                        ),
                        CustomTextWidget(
                          text: subjects,
                          fontSize: 14,
                          textColor: lightPeriwinkleColor,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: coolGrayColor,
                      ),
                      CustomTextWidget(
                        text: location,
                        textColor: coolGrayColor,
                        fontSize: 14,
                      ),
                      IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: coolGrayColor,
                        ),
                      ),
                    ],
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
                      Icons.alarm,
                      color: amberColor,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: reviews,
                      textColor: amberColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      color: lightBlueColor,
                    ),
                    const SizedBox(width: 5),
                    CustomTextWidget(
                      text: opensAt,
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
