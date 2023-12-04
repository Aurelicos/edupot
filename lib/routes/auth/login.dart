import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final String title;
  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Some Text :',
            ),
            Text(
              title,
              style: EduPotTextTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
