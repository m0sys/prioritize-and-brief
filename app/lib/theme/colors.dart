import 'package:flutter/material.dart';

class ThemeColors {
  // static const Color primaryColor = Color(0xFF095c1a);

  // Main Color Swatches: Primary Color + Accent Color

  static const Map<int, Color> primary = {
    50: Color.fromRGBO(9, 92, 26, 0.1),
    100: Color.fromRGBO(9, 92, 26, 0.2),
    200: Color.fromRGBO(9, 92, 26, 0.3),
    300: Color.fromRGBO(9, 92, 26, 0.4),
    400: Color.fromRGBO(9, 92, 26, 0.5),
    500: Color.fromRGBO(9, 92, 26, 0.6),
    600: Color.fromRGBO(9, 92, 26, 0.7),
    700: Color.fromRGBO(9, 92, 26, 0.8),
    800: Color.fromRGBO(9, 92, 26, 0.9),
    900: Color.fromRGBO(9, 92, 26, 1),
  };

  static const Map<int, Color> primary2 = {
    50: Color.fromRGBO(27, 94, 31, 0.1),
    100: Color.fromRGBO(9, 92, 26, 0.2),
    200: Color.fromRGBO(27, 94, 31, 0.3),
    300: Color.fromRGBO(27, 94, 31, 0.4),
    400: Color.fromRGBO(27, 94, 31, 0.5),
    500: Color.fromRGBO(27, 94, 31, 0.6),
    600: Color.fromRGBO(27, 94, 31, 0.7),
    700: Color.fromRGBO(27, 94, 31, 0.8),
    800: Color.fromRGBO(27, 94, 31, 0.9),
    900: Color.fromRGBO(27, 94, 31, 1),
  };

  static const Map<int, Color> accent = {
    50: Color.fromRGBO(0, 85, 255, 0.1),
    100: Color.fromRGBO(0, 85, 255, 0.2),
    200: Color.fromRGBO(0, 85, 255, 0.3),
    300: Color.fromRGBO(0, 85, 255, 0.4),
    400: Color.fromRGBO(0, 85, 255, 0.5),
    500: Color.fromRGBO(0, 85, 255, 0.6),
    600: Color.fromRGBO(0, 85, 255, 0.7),
    700: Color.fromRGBO(0, 85, 255, 0.8),
    800: Color.fromRGBO(0, 85, 255, 0.9),
    900: Color.fromRGBO(0, 85, 255, 1),
  };

  static const Map<int, Color> accent2 = {
    50: Color.fromRGBO(0, 105, 92, 0.1),
    100: Color.fromRGBO(0, 105, 92, 0.2),
    200: Color.fromRGBO(0, 105, 92, 0.3),
    300: Color.fromRGBO(0, 105, 92, 0.4),
    400: Color.fromRGBO(0, 105, 92, 0.5),
    500: Color.fromRGBO(0, 105, 92, 0.6),
    600: Color.fromRGBO(0, 105, 92, 0.7),
    700: Color.fromRGBO(0, 105, 92, 0.8),
    800: Color.fromRGBO(0, 105, 92, 0.9),
    900: Color.fromRGBO(0, 105, 92, 1),
  };

  static const MaterialColor primarySwatch =
      MaterialColor(0xFF1b5e1f, primary2);
  static const MaterialColor secondarySwatch =
      MaterialColor(0xFFffc400, accent2);

  // Typography Color
  static const onPrimary = Color(0xFFFFFFFF);
  static const onSecondary = Color(0xFF000000);
  static const onError = Color(0xFFFFFFFF);
}

// Colors
const pMainPurple700 = const Color(0xFFF4C0DD2);
const pMainPurple800 = const Color(0xFFF3803CD);

const aMainGreen900 = const Color(0xFFF094306);

const mainBackgroundWhite = Colors.white;
