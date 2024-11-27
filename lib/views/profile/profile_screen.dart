import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

import '../../routes/routes.dart';
import '../../services/firebase_auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  get userData => null;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? _userName;
  String? _userImageUrl;
  String? _userSpecialization;

  // Getter to access userData from ModalRoute arguments
  Map<String, dynamic> get userData {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, dynamic>) {
      return arguments;
    } else {
      // Handle the case where arguments are not a Map
      // You might want to throw an error or return an empty map
      return {}; // Returning an empty map for now
    }
  }


  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }
  
  
  void _initializeUserData() {
    setState(() {
      _userName = widget.userData['name'] as String?;
      _userImageUrl = widget.userData['imageUrl'] as String?;
      _userSpecialization = widget.userData['userType'] == 'student'
          ? widget.userData['grade'] as String? // Example: grade for students
          : widget.userData['specialization'] as String?; // Example: specialization for tutors
    });
  }

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
            height: MediaQuery.of(context).size.height * 0.27,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: _userImageUrl != null
                      ? NetworkImage(_userImageUrl!)
                      : const NetworkImage(
                      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg'),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextWidget(
            text: _userName ?? 'User', // Display user name or "User" if null
            fontSize: 30,
            fontWeight: FontWeight.w500,
            textColor: blackColor,
          ),
          CustomTextWidget(
            text: _userSpecialization ?? 'Specialization',
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
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.editProfile); // Navigate to edit screen
                    },
                    child: const CustomTextWidget(
                      text: 'Edit Profile',
                      fontSize: 16,
                      textColor: Color(0xFFAEAEAE),
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    color: Color(0xFFAEAEAE),
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
