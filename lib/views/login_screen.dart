// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import '../services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const CustomTextWidget(
              text: 'Hi, Welcome Back! 👋',
              textColor: blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              controller: emailController,
              hintText: 'example@gmail.com',
              labelText: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: 'Enter Your Password',
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberMeCheckbox(onChanged: (value) {}),
                TextButton(
                  onPressed: () {},
                  child: const CustomTextWidget(
                    text: 'Forgot Password?',
                    textColor: lightCoralColor,
                    fontSize: 15,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        final FirebaseAuthService authService =
                            FirebaseAuthService();
                        await authService.login(
                            emailController.text, passwordController.text);
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        DocumentSnapshot userDoc = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(userId)
                            .get();
                        String userType = userDoc['userType'];
                        // After successful login
                        if (userType == 'student') {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.homeWrapper,
                            arguments: 'student',
                          );
                        } else if (userType == 'tutor') {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.homeWrapper,
                            arguments: 'tutor',
                          );
                        } else {
                          // Handle the case if the userType is missing or invalid
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Unknown user type')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                          ),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    buttonText: 'Sign In',
                  ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  indent: 40,
                  endIndent: 20,
                )),
                Text("Or With"),
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () {},
              buttonText: 'Login With Facebook',
              textSize: 18,
              image: 'assets/images/facebook_logo.png',
            ),
            CustomButton(
              onTap: () {},
              buttonText: 'Login With Google',
              backgroundColor: whiteColor,
              buttonTextColor: Colors.black54,
              buttonBorderColor: Colors.black54,
              textSize: 18,
              image: 'assets/images/google_logo.png',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextWidget(
                  text: 'If you Don\'t have an account',
                  textColor: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registeration);
                  },
                  child: const CustomTextWidget(
                    text: 'Sign-up',
                    textColor: lightBlueColor,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const CustomTextWidget(
              text: 'User Guidelines',
              textColor: lightBlueColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }
}

class RememberMeCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const RememberMeCheckbox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: blackColor,
          activeColor: Colors.transparent,
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
            widget.onChanged(_isChecked);
          },
        ),
        const CustomTextWidget(
          text: 'Remember Me',
          textColor: blackColor,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
