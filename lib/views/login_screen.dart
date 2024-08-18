import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomTextWidget(
            text: 'Hi, Welcome Back! 👋',
            textColor: blackColor,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: emailController,
            hintText: 'example@gmail.com',
            labelText: 'Email',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: blackColor,
                    activeColor: Colors.transparent,
                    value: true,
                    onChanged: (value) {},
                  ),
                  const CustomTextWidget(
                    text: 'Remember Me',
                    textColor: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
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
          CustomButton(onTap: () {}, buttonText: 'Sign Up'),
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
                onPressed: () {},
                child: const CustomTextWidget(
                  text: 'Sign-up',
                  textColor: lightBlueColor,
                  fontSize: 16,
                ),
              )
            ],
          ),
          CustomTextWidget(
            text: 'User Guidelines',
            textColor: lightBlueColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}
