import 'package:auto_route/auto_route.dart';
import 'package:edupot/routes/auth/login_screen.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/routes/onboarding/onboarding.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
          initial: true,
        )
      ];
}
