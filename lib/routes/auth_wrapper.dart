import 'package:edupot/routes/app/home_page.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/splash_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:flutter/material.dart';

class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasData) {
          return const HomePage();
        }

        return const RegisterPage();
      },
    );
  }
}
