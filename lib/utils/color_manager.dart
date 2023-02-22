import 'package:flutter/material.dart';

class ColorManager {
  static const Color background = Color(0xFF2f2519);
  static const Color surface = Color(0xFF413422);
  static const Color primary = Color(0xFFeda05a);
  static const Color primaryVariant = Color(0xFFce6d38);
  static const Color secondary = Color(0xFFd45123);
  static const Color secondaryVariant = Color(0xFFba461d);
  static const Color onBackground = primary;
  static const Color onSurface = primary;
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;

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