import 'package:auto_route/auto_route.dart';
import 'package:edupot/routes/auth/login_screen.dart';
import 'package:edupot/routes/auth/register_screen.dart';

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
      ];
}
