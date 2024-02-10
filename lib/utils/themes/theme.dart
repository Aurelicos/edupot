import 'package:flutter/material.dart';
import 'dart:math';

class EduPotColorTheme {
  static const primaryDark = Color(0xFF171930);
  static const primaryLightDark = Color(0xFF272943);
  static const facebookPrimary = Color(0xFF3B5998);
  static const navbar = Color(0xFF0D0F22);
  static const floatingButtonColor = Color(0xFF6D7B98);
  static const primaryBlueDark = Color(0xFF1E203B);
  static const examsOrange = Color(0xFFF18C27);
  static const tasksPurple = Color(0xFFBB476C);

  static const mainItemGradient = LinearGradient(
    begin: Alignment(1.00, 0.00),
    end: Alignment(-1, 0),
    colors: [Color(0x72242547), Color(0xFF242547)],
  );

  static LinearGradient mainBlueGradient({double opacity = 1}) {
    return LinearGradient(
      begin: const Alignment(0.76, -0.66),
      end: const Alignment(-0.76, 0.66),
      colors: [
        Color.fromRGBO(38, 110, 215, opacity),
        Color.fromRGBO(77, 138, 235, opacity)
      ],
    );
  }

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

  static const darkGrayCardGradient = LinearGradient(
    transform: GradientRotation(pi / 2),
    colors: [
      Color.fromRGBO(0, 0, 0, 0.4),
      Color.fromRGBO(255, 255, 255, 0.1),
    ],
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment(0.76, -0.66),
    end: Alignment(-0.76, 0.66),
    colors: [
      Color.fromRGBO(255, 201, 44, 1),
      Color.fromRGBO(253, 147, 113, 1),
    ],
  );

  static const darkGradient = LinearGradient(
    colors: [
      Color(0xFF313346),
      Color(0XFF54566E),
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

  static const TextStyle headline3 = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
