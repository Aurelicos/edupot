import 'package:auto_route/auto_route.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Image(image: AssetImage('assets/images/icon.png')),
            ),
          );
        }
        if (snapshot.hasData) {
          return const TaskTrackerPage();
        }

        return const RegisterPage();
      },
    );
  }
}
