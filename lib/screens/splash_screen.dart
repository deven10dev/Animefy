import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacktoon/screens/camera_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';
  final int random_number = Random().nextInt(6) + 1;

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: CameraScreen(),
      duration: 4000,
      imageSize: 200,
      imageSrc: "images/splash_image$random_number.png",
      text: "Animefy",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 50.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}
