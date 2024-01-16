import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/splash_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return FutureBuilder(
      future: userProvider.handleAuth(uid: AuthService().currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!['success'] == false) {
            AuthService().signOut();
            context.replaceRoute(const RegisterRoute());
          }
          if (snapshot.data!['data'] == false) {
            context.replaceRoute(const OnboardingRoute());
          } else {
            return Container(
              decoration: const BoxDecoration(
                gradient: EduPotColorTheme.primaryGradient,
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    AuthService().signOut();
                  },
                  child: const Text('Sign Out'),
                ),
              ),
            );
          }
          return const SplashScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
