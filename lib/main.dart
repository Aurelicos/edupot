import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPot',
      theme: ThemeData(
        primaryColor: EduPotColorTheme.primaryDark,
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
