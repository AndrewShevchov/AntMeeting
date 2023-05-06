import 'package:stream/screens/login_screen.dart';
import 'package:stream/screens/signup_screen.dart';
import 'package:stream/utils/colors.dart';
import 'package:stream/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          primaryColorGradient,
          primaryColorGradient2,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          secondaryColor,
          secondaryColor2,
        ],
        duration: Duration(seconds: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Expanded(
                  flex: 1,
                  child: const Text(
                    "AntMeeting",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    text: 'Авторизоваться'),
              ),
              CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  text: 'Регистрация'),
            ],
          ),
        ),
      ),
    );
  }
}
