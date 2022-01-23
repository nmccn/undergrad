import 'package:flutter/material.dart';
import 'package:sif_book/navigation/oop_approach/chapter_menu.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'navigation/chapters.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      // navigateRoute: const Chapters(),
      navigateRoute: const Chapters(),
      duration: 3500,
      imageSize: 500,
      // imageSrc: 'assets/images/workbook_Cover.JPG',
      imageSrc: 'assets/images/Splash.png',
      // If we prefer a custom message + animation (must import 'globals.dart')
      // textType: TextType.ColorizeAnimationText,
      // textStyle: TextStyle(fontSize: 30.0),
      // text: "SIF Language School",
      // colors:
      //   [sifBlue, sifGreen, sifOrange],
      backgroundColor: Colors.white,
      pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
    );
  }
}
