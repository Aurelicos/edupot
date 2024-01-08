import 'package:auto_route/auto_route.dart';
import 'package:edupot/routes/auth/login_screen.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/onboarding/onboarding.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RegisterRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
        ),
        AutoRoute(
          page: TaskTrackerRoute.page,
        )
      ];
}
