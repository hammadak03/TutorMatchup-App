import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomTextWidget({
    this.fontSize,
    this.textColor,
    this.fontWeight,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: textColor ?? whiteColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
