import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPot',
      theme: ThemeData(
        primaryColor: EduPotColorTheme.primaryDark,
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
