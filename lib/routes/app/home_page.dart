import 'dart:async';

import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker_page.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/onboarding/onboarding.dart';
import 'package:edupot/routes/splash_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

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
        Get.off(const RegisterPage());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NavbarProvider>(context, listen: false);
      provider.selectedIndex = 1;
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
    final projectProvider = context.read<ProjectProvider>();
    final entryProvider = context.read<EntryProvider>();

    return FutureBuilder(
      future: userProvider.handleAuth(uid: AuthService().currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!['success'] == false) {
            AuthService().signOut();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(const RegisterPage());
            });
          }
          entryProvider.fetchEntries(userProvider.user!.uid ?? "",
              forceRefresh: true);
          projectProvider.fetchProjects(userProvider.user!.uid ?? "",
              forceRefresh: true);
          if (snapshot.data!['data'] == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(const OnboardingPage());
            });
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
