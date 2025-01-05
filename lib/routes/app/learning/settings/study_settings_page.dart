import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:flutter/material.dart';

class StudySettingsPage extends StatelessWidget {
  const StudySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Text(
                'Study Settings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
