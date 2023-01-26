import 'package:flutter/material.dart';

class MainColors {
  static Color primary_w900 = Color.fromARGB(255, 235, 208, 181);
  static Color primary_w500 = Color.fromARGB(255, 244, 226, 209);
  static Color primary_w100 = Color.fromARGB(255, 255, 249, 244);
  static Color active = Color.fromARGB(255, 250, 197, 145);
  static Color icon = Color.fromARGB(255, 249, 198, 147);
  static Color black = Color.fromARGB(255, 27, 29, 37);
  static Color grey = Colors.grey.shade700;
  static Color light_grey = Colors.grey;
  static Color green = Color.fromARGB(255, 72, 241, 154);
  static Color white = Colors.white;

  static MaterialColor getMatColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
