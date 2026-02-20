import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fintrix/screen/address_screen.dart';
import 'package:fintrix/screen/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: LottieBuilder.asset("assets/lottie/hello_animation.json"),
          ),
        ],
      ),
      nextScreen: FirstScreen(),
      splashIconSize: 200,
      backgroundColor: Colors.blue.shade50,
    );
  }
}
