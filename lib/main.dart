import 'package:edupot/providers/day_provider.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/providers/step_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/auth_wrapper.dart';
import 'package:edupot/controllers/dependency_injection.dart';
import 'package:edupot/services/notification_service.dart';
import 'package:edupot/services/shared_preferences_service.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferencesService.init();

  tz.initializeTimeZones();

  await NotificationService().initialize();

  DependencyInjection.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: NavbarProvider()),
        ChangeNotifierProvider.value(value: SelectionProvider()),
        ChangeNotifierProvider.value(value: EntryProvider()),
        ChangeNotifierProvider.value(value: ProjectProvider()),
        ChangeNotifierProvider.value(value: DayProvider()),
        ChangeNotifierProvider.value(value: QuizProvider()),
        ChangeNotifierProvider.value(value: StepProvider()),
      ],
      child: GetMaterialApp(
        title: 'EduPot',
        home: const AuthWrapperPage(),
        theme: ThemeData(
          primaryColor: EduPotColorTheme.primaryDark,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
