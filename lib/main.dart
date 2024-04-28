import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/services/notification_service.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().initialize();

  final flutterLocalNotificationsPlugin =
      NotificationService.flutterLocalNotificationsPlugin;

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: "idk",
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      1, 'title', 'body', platformChannelSpecifics);

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: NavbarProvider()),
        ChangeNotifierProvider.value(value: SelectionProvider()),
        ChangeNotifierProvider.value(value: EntryProvider()),
        ChangeNotifierProvider.value(value: ProjectProvider()),
      ],
      child: MaterialApp.router(
        title: 'EduPot',
        theme: ThemeData(
          primaryColor: EduPotColorTheme.primaryDark,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
