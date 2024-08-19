import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? textSize;
  final String? image;

  const CustomButton({
    this.backgroundColor,
    this.image,
    this.buttonTextColor,
    this.buttonBorderColor,
    this.textSize,
    required this.onTap,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.14,
              decoration: BoxDecoration(
                border:
                    Border.all(color: buttonBorderColor ?? Colors.transparent),
                color: backgroundColor ?? lightBlueColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: CustomTextWidget(
                  text: buttonText,
                  fontWeight: FontWeight.w500,
                  fontSize: textSize ?? 20,
                  textColor: buttonTextColor,
                ),
              ),
            ),
            if (image != null)
              Positioned(
                left: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage(image!), // Use ! to ensure it's not null
                ),
              ),
          ],
        ),
      ),
    );
  }
}
