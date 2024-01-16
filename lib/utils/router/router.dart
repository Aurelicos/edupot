import 'package:auto_route/auto_route.dart';
import 'package:edupot/routes/app/calendar/calendar_page.dart';
import 'package:edupot/routes/app/notes/notes_page.dart';
import 'package:edupot/routes/app/settings/settings_page.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker_page.dart';
import 'package:edupot/routes/auth/login_screen.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/auth_wrapper.dart';
import 'package:edupot/routes/onboarding/onboarding.dart';
import 'package:edupot/routes/app/home_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthWrapperRoute.page,
          initial: true,
        ),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: HomeRoute.page),
        CustomRoute(
          page: SettingsRoute.page,
          transitionsBuilder: null,
        ),
        CustomRoute(
          page: NotesRoute.page,
          transitionsBuilder: null,
        ),
        CustomRoute(
          page: CalendarRoute.page,
          transitionsBuilder: null,
        ),
        CustomRoute(
          page: TaskTrackerRoute.page,
          transitionsBuilder: null,
        )
      ];
}
