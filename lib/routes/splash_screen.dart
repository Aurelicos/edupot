import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      body: Center(
        child: Image(image: AssetImage('assets/images/icon.png')),
      ),
    );
  }
}
