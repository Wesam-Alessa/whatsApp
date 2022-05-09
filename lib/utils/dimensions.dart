import 'package:flutter/material.dart';

MediaQueryData window =
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

class Dimensions {
  static double screenHeight = window.size.height;
  static double screenWidth = window.size.width;

  static double pageView320 = screenHeight / (screenHeight / 320); //2.64
  static double pageViewContainer220 =
      screenHeight / (screenHeight / 220); //3.84
  static double pageViewTextContainer120 =
      screenHeight / (screenHeight / 120); //7.03

// dynamic height padding and margin
  static double height10 = screenHeight / (screenHeight / 10); //84.4
  static double height15 = screenHeight / (screenHeight / 15); //56.27
  static double height20 = screenHeight / (screenHeight / 20); //42.2
  static double height30 = screenHeight / (screenHeight / 30); //28.13
  static double height45 = screenHeight / (screenHeight / 45); //18.76

// dynamic width padding and margin
  static double width10 = screenHeight / (screenWidth / 10); //84.4
  static double width15 = screenHeight / (screenWidth / 15); //56.27
  static double width20 = screenHeight / (screenWidth / 20); //42.2
  static double width30 = screenHeight / (screenWidth / 30); //28.13

// dynamic font size
  static double font12 = screenHeight / (screenHeight / 12); //52.75
  static double font13 = screenHeight / (screenHeight / 13); //52.75
  static double font14 = screenHeight / (screenHeight / 14); //52.75
  static double font16 = screenHeight / (screenHeight / 16); //52.75
  static double font17 = screenHeight / (screenHeight / 17);
  static double font18 = screenHeight / (screenHeight / 18);
  static double font20 = screenHeight / (screenHeight / 20); //42.2
  static double font26 = screenHeight / (screenHeight / 26); //32.46

// dynamic radius
  static double radius10 = screenHeight / (screenHeight / 10); //71
  static double radius15 = screenHeight / (screenHeight / 15); //56.27
  static double radius20 = screenHeight / (screenHeight / 20); //42.2
  static double radius25 = screenHeight / (screenHeight / 25); //35.165
  static double radius30 = screenHeight / (screenHeight / 30); //28.13

// dynamic icon size
  static double iconSize13 = screenHeight / (screenHeight / 13);
  static double iconSize16 = screenHeight / (screenHeight / 16); //52.75
  static double iconSize24 = screenHeight / (screenHeight / 24); //35.17

// list view size
  static double listViewImgSize130 = screenWidth / (screenWidth / 130); //3.25
  static double listViewTextContSize110 =
      screenWidth / (screenWidth / 110); //3.9

// popular food
  static double popularFoodImgSize350 =
      screenHeight / (screenHeight / 350); //2.41

// bottom nav bar height
  static double bottomHeightBar120 = screenHeight / (screenHeight / 120); //7.03

// splash screen dimension
  static double splashImg250 = screenHeight / (screenHeight / 250); //3.38

}
