import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TaskTrackerPage extends StatelessWidget {
  const TaskTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      child: Center(
        child: TextButton(
          onPressed: () {
            AuthService().signOut();
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Task Tracker',
                style: EduPotDarkTextTheme.headline1,
              ),
              SizedBox(height: 20),
              Text('Sign Out'),
            ],
          ),
        ),
      ),
    );
  }
}
