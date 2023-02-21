import 'package:flutter/material.dart';

class MainColors {
  static MaterialColor primary_mat = MaterialColor(0xFFea593c, {
    50: Color(0xFFfdecee),
    100: Color(0xFFfcd0d2),
    200: Color(0xFFe9a09c),
    300: Color(0xFFdd7d76),
    400: Color(0xFFe66354),
    500: Color(0xFFea593c),
    600: Color(0xFFdb503a),
    700: Color(0xFFc94734),
    800: Color(0xFFbc412e),
    900: Color(0xFFac3925),
  });
  static MaterialColor secondary_mat = MaterialColor(0xFF3ccdea, {
    50: Color(0xFFdff6fc),
    100: Color(0xFFafeaf7),
    200: Color(0xFF7adcf1),
    300: Color(0xFF3ccdea),
    400: Color(0xFF00c3e4),
    500: Color(0xFF00b8dd),
    600: Color(0xFF00a8c9),
    700: Color(0xFF0094af),
    800: Color(0xFF008096),
    900: Color(0xFF005e69),
  });

  static Color backgroundColor = secondary_mat.shade50;
  static Color active = secondary_mat.shade200;
  static Color icon = secondary_mat.shade200;
  static Color black = Colors.black;
  static Color grey = Colors.grey.shade700;
  static Color light_grey = Colors.grey;
  static Color white = Colors.white;

  static Color new_primary = primary_mat.shade400;
  static Color new_primary_variant = primary_mat.shade600;

  static Color new_secondary = secondary_mat.shade300;
  static Color new_seconday_variant = secondary_mat.shade900;

  /// primary benzer renk 1
  static Color similar_color = Color(0xFF3ceab0);

  /// primary benzer renk 2
  static Color similar_color2 = Color(0xFF3c76ea);

  static Color triadic_1 = Color(0xFF593cea);
  static Color triadic_2 = Color(0xFFea3ccd);

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
