import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class ClassSessionScreen extends StatelessWidget {
  const ClassSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTutor = true;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Class Session',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: lightBlueColor,
            height: MediaQuery.of(context).size.height * 0.20,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Icon(
                    Icons.person,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Hammad Ahmed',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextWidget(
                      text: 'Maths',
                      fontSize: 13,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: whiteColor,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.70,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomTextWidget(
                      text: 'Class Time',
                      textColor: midnightBlueColor,
                      fontSize: 17,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomTextWidget(
                      text: '11:00 PM, September 06, 2024',
                      textColor: midnightBlueColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CircleAvatar(
                      backgroundColor: lightBlueColor,
                      radius: 110,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                              text: '00:00:00',
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomTextWidget(
                              text: 'Hrs    Min    Sec',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomTextWidget(
                      text: 'While you\'re in class;',
                      textColor: midnightBlueColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message,
                            color: lightBlueColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomTextWidget(
                            text: 'Leave any questions',
                            textColor: lightBlueColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder,
                            color: lightBlueColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomTextWidget(
                            text: 'Share class materials',
                            textColor: lightBlueColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
