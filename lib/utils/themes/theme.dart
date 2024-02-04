import 'package:flutter/material.dart';
import 'dart:math';

class EduPotColorTheme {
  static const primaryDark = Color(0xFF171930);
  static const facebookPrimary = Color(0xFF3B5998);
  static const navbar = Color(0xFF0D0F22);

  static const mainItemGradient = LinearGradient(
    begin: Alignment(1.00, 0.00),
    end: Alignment(-1, 0),
    colors: [Color(0x72242547), Color(0xFF242547)],
  );

  static const mainBlueGradient = LinearGradient(
    begin: Alignment(0.76, -0.66),
    end: Alignment(-0.76, 0.66),
    colors: [Color(0xFF266ED7), Color(0xFF4D8AEB)],
  );

  static const onboardingGradient = LinearGradient(
    begin: Alignment(-0.66, 0.75),
    end: Alignment(0.66, -0.75),
    colors: [Color(0xFF171930), Color(0xFF1D1F3E)],
  );

  static const primaryGradient = LinearGradient(
    begin: Alignment(-0.21, -0.98),
    end: Alignment(0.21, 0.98),
    colors: [Color(0xFF171930), Color(0xFF171930)],
  );

  static const lightGrayCardGradient = LinearGradient(
    transform: GradientRotation(pi / 2),
    colors: [
      Color.fromRGBO(165, 175, 196, 0.6),
      Color.fromRGBO(109, 123, 152, 0.6)
    ],
  );

  static const purpleCardGradient = LinearGradient(
    transform: GradientRotation(pi / 2),
    colors: [
      Color.fromRGBO(101, 78, 163, 0.4),
      Color.fromRGBO(234, 175, 200, 0.4)
    ],
  );
}

class EduPotDarkTextTheme {
  static const TextStyle headline1 = TextStyle(
    fontFamily: "Inter",
    fontSize: 38,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle headline2(double opacity) {
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(opacity),
    );
  }
}
