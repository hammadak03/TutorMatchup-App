import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class TutorDetailsSceens extends StatelessWidget {
  const TutorDetailsSceens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'Tutor Details',
          textColor: lightBlueColor,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top:
                20, // Adjust as needed to control the vertical position of the container
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.92,
              decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextWidget(
                    text: 'Hammad Ahmed',
                    textColor: whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextWidget(
                    text: 'Lorem ipsum dolor sit amet.',
                    textColor: lightPeriwinkleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextWidget(
                    text: '4.8 (120 Reviews)',
                    textColor: amberColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: whiteColor,
                          ),
                          CustomTextWidget(
                            text: 'Hyderabad',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: whiteColor,
                          ),
                          CustomTextWidget(
                            text: 'Sun - Fri',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: whiteColor,
                          ),
                          CustomTextWidget(
                            text: '9AM - 3PM',
                            fontSize: 10,
                            textColor: whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //TODO: Handle request to tutor
                        },
                        child: const CustomTextWidget(
                          text: 'Request',
                          textColor: lightBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //TODO: Handle onpressed message button
                        },
                        child: const CustomTextWidget(
                          text: 'Message',
                          textColor: lightBlueColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Makes the column as small as possible
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'About',
                      textColor: midnightBlueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8), // Spacing between title and text
                    CustomTextWidget(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      textColor: bluishGreyColor,
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
