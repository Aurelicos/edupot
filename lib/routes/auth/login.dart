import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/inputField.dart';

class LoginScreen extends StatelessWidget {
  final String title;
  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: EduPotDarkTextTheme.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome to EduPot - Your Learning Companion",
              style: EduPotDarkTextTheme.headline2(0.6),
            ),
            const SizedBox(height: 46),
            const InputField(
              headline: 'Email',
              placeholder: 'johndoe@example.com',
            ),
          ],
        ),
      ),
    );
  }
}
