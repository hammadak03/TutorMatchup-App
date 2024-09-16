import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

import '../routes/routes.dart';
import '../services/firebase_auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  final FirebaseAuthService authService = FirebaseAuthService();
                  await authService.signOut();
                  //TODO: add condition if user is teacher, navigate to tutor screen and vice versa

                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, Routes.login);
                } catch (e) {
                  // Handle the error, e.g., show a Snackbar
                }
              },
              child: const CustomTextWidget(
                text: 'Logout',
                fontSize: 16,
              ))
        ],
        leadingWidth: 100,
        leading: TextButton(
          child: const CustomTextWidget(
            text: 'Settings',
            fontSize: 16,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        backgroundColor: lightBlueColor,
        title: const CustomTextWidget(
          text: 'Profile',
          fontSize: 30,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: lightBlueColor,
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomTextWidget(
            text: 'Basma Memon',
            fontSize: 30,
            fontWeight: FontWeight.w500,
            textColor: blackColor,
          ),
          const CustomTextWidget(
            text: 'English Specialist',
            textColor: Colors.black54,
            fontSize: 20,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const CustomTextWidget(
                      text: 'Edit Profile',
                      fontSize: 16,
                      textColor: Color(0xFFAEAEAE),
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    color: Color(
                      0xFFAEAEAE,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const CustomTextWidget(
                  text: 'Settings',
                  fontSize: 16,
                  textColor: Color(0xFFAEAEAE),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
