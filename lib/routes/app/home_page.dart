import 'dart:async';

import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker_page.dart';
import 'package:edupot/routes/splash_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User?>? _authStateChangesSubscription;

  @override
  void initState() {
    super.initState();
    _authStateChangesSubscription =
        AuthService().authStateChanges.listen((User? user) {
      if (user == null && mounted) {
        context.replaceRoute(const RegisterRoute());
      }
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

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
            return const TaskTrackerPage();
          }
          return const SplashScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
