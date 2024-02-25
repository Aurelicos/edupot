import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return PrimaryScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings Page',
              style: EduPotDarkTextTheme.headline1,
            ),
            TextButton(
              onPressed: () {
                AuthService().signOut();

                userProvider.clearUser();
                if (context.mounted) {
                  context.replaceRoute(const RegisterRoute());
                }
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
