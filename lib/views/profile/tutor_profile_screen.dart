import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/utils/colors.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({Key? key}) : super(key: key);

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController expertiseController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save tutor profile to Firestore
  Future<void> _confirmProfessionalism() async {
    if (nameController.text.isEmpty ||
        qualificationController.text.isEmpty ||
        experienceController.text.isEmpty ||
        expertiseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all details!')),
      );
      return;
    }

    final tutorProfile = {
      "name": nameController.text,
      "qualification": qualificationController.text,
      "experience": experienceController.text,
      "expertise": expertiseController.text,
      "status": "Pending Confirmation", // Default status
      "createdAt": FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('tutors').add(tutorProfile);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile submitted for confirmation!')),
      );

      // Clear fields after submission
      nameController.clear();
      qualificationController.clear();
      experienceController.clear();
      expertiseController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Tutor Profile",
          style: TextStyle(color: midnightBlueColor),
        ),
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Your Tutor Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              hintText: "Full Name",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: qualificationController,
              hintText: "Qualification (e.g., Master's in Math)",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: experienceController,
              hintText: "Years of Experience",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: expertiseController,
              hintText: "Expertise (e.g., Algebra, Physics)",
            ),
            const SizedBox(height: 30),
            CustomButton(
              buttonText: "Confirm Professionalism",
              onTap: _confirmProfessionalism,
            ),
          ],
        ),
      ),
    );
  }
}
