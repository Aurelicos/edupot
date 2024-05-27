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
  static const projectBlue = Color(0xFF4886E8);
  static const greyBorder = Color(0xFFA5AFC4);
  static const lightGray = Color(0xFF363956);
  static const lightGray2 = Color(0xFF464967);

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
    colors: [Color(0x99A5AFC4), Color(0x996D7B98)],
  );

  static const purpleCardGradient = LinearGradient(
    transform: GradientRotation(pi / 2),
    colors: [Color(0x66654EA3), Color(0x66EAAFC8)],
  );

  static const darkGrayCardGradient = LinearGradient(
    transform: GradientRotation(pi / 2),
    colors: [
      Color(0x66000000),
      Color(0x18FFFFFF),
    ],
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment(0.76, -0.66),
    end: Alignment(-0.76, 0.66),
    colors: [
      Color(0xFFFFC92C),
      Color(0xFFFD9371),
    ],
  );

  static const darkGradient = LinearGradient(
    colors: [
      Color(0xFF313346),
      Color(0XFF54566E),
    ],
  );

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFF1E203B),
      Color(0xFF171930),
      Color(0xFF1E203B),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static const timeGradient = LinearGradient(
    colors: [
      Color(0xff272943),
      Color(0x02272943),
      Color(0xff272943),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 0.5, 1],
  );

  static const timeSuggestGradient = LinearGradient(
    begin: Alignment(-0.68, -0.74),
    end: Alignment(0.68, 0.74),
    colors: [Color(0x66A5AFC4), Color(0x666D7B98)],
  );

  static const purplePinkGradient = LinearGradient(
    begin: Alignment(0.67, -0.75),
    end: Alignment(-0.67, 0.75),
    colors: [Color(0xFF5B34FF), Color(0xFFFF5303)],
  );

  static const greenGradient = LinearGradient(
    begin: Alignment(0.76, -0.65),
    end: Alignment(-0.76, 0.65),
    colors: [Color(0xFF89FF2C), Color(0xFF4362B0)],
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

  static const TextStyle smallHeadline = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle correctText({Color color = Colors.white}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
