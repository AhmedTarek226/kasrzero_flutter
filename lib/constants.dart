import 'package:flutter/material.dart';

const KLocalhost = "192.168.1.108:4000";
const KPrimaryColor = Color.fromARGB(255, 251, 176, 59);
const List<String> durationsOfUse = [
    "Up to 3 months",
    "3 to 6 months",
    "1 year",
    "2 years",
    "3 years",
    "4 years",
    "5 years and more",
  ];

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    _orange, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: const Color(0xFFFFD180), //10%
      100: const Color(0xfccf89), //20%
      200: const Color(0xfccf89), //30%
      300: const Color(0xfbb03b), //40%
      400: const Color(0xfcc775), //50%
      500: const Color(_orange), //60%
      600: const Color(0xe19e35), //70%
      700: const Color(0xFFFF9100), //80%
      800: const Color(0xaf7b29), //90%
      900: const Color(0xFFFF6D00), //100%
    },
  );
  static const int _orange = 0xFFFFAB40;
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
