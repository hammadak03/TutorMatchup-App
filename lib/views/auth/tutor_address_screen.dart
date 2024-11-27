import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';

class TutorAddressScreen extends StatefulWidget {
  final Map<String, dynamic> tutorDetails;

  const TutorAddressScreen({Key? key, required this.tutorDetails}) : super(key: key);

  @override
  State<TutorAddressScreen> createState() => _TutorAddressScreenState();
}

class _TutorAddressScreenState extends State<TutorAddressScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Optionally populate address fields if tutorDetails contain existing address data.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Tutor Address",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CustomTextField(controller: addressController, hintText: "Address"),
              CustomTextField(controller: cityController, hintText: "City"),
              CustomTextField(controller: stateController, hintText: "State"),
              CustomTextField(controller: countryController, hintText: "Country"),
              CustomTextField(controller: zipCodeController, hintText: "Zip Code"),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: "Submit",
                onTap: () {
                  // Capture address data and send it to the backend or proceed further.
                  final addressDetails = {
                    "address": addressController.text,
                    "city": cityController.text,
                    "state": stateController.text,
                    "country": countryController.text,
                    "zipCode": zipCodeController.text,
                  };

                  // Combine with tutorDetails for further usage.
                  final completeTutorDetails = {
                    ...widget.tutorDetails,
                    ...addressDetails,
                  };

                  // Navigate to the next screen or submit the data.
                  print("Complete Tutor Details: $completeTutorDetails");
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
