import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class TutorHomeScreen extends StatelessWidget {
  const TutorHomeScreen({super.key});

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
      body: const Placeholder(),
    );
  }
}
