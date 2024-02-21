import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
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
        ChangeNotifierProvider.value(value: EntryProvider())
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
