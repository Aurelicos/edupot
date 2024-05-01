import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimaryScaffold(
      child: Center(
        child: Text(
          'Notes Page',
          style: EduPotDarkTextTheme.headline1,
        ),
      ),
    );
  }
}
