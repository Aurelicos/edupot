import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TaskTrackerPage extends StatelessWidget {
  const TaskTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: EduPotColorTheme.primaryGradient,
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            context.pushRoute(const RegisterRoute());
          },
          child: const Text('Register Page'),
        ),
      ),
    );
  }
}
