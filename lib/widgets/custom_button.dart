import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const CustomButton(
      {required this.onTap, required this.buttonText, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.13,
          decoration: BoxDecoration(
            color: lightBlueColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: whiteColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
