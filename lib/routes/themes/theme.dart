import 'package:flutter/material.dart';

class EduPotColorTheme {
  static const primaryDark = Color(0xFF171930);
  static const facebookPrimary = Color(0xFF3B5998);

  static const mainItemGradient = LinearGradient(
    begin: Alignment(1.00, 0.00),
    end: Alignment(-1, 0),
    colors: [Color(0x72242547), Color(0xFF242547)],
  );

  static const buttonGradient = LinearGradient(
    begin: Alignment(0.76, -0.66),
    end: Alignment(-0.76, 0.66),
    colors: [Color(0xFF266ED7), Color(0xFF4D8AEB)],
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
