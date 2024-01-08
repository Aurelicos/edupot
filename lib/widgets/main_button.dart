import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  const MainButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        height: 56,
        decoration: BoxDecoration(
          gradient: EduPotColorTheme.buttonGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: EduPotDarkTextTheme.headline2(1),
          ),
        ),
      ),
    );
  }
}
