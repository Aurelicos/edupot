// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountPage(),
      );
    },
    AddTaskRoute.name: (routeData) {
      final args = routeData.argsAs<AddTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddTaskPage(
          key: args.key,
          selectedCategory: args.selectedCategory,
          modalContext: args.modalContext,
          exam: args.exam,
          task: args.task,
          project: args.project,
        ),
      );
    },
    AuthWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthWrapperPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalendarPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    NotesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotesPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    TaskTrackerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TaskTrackerPage(),
      );
    },
  };
}

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddTaskPage]
class AddTaskRoute extends PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    Key? key,
    required int selectedCategory,
    BuildContext? modalContext,
    ExamModel? exam,
    TaskModel? task,
    ProjectModel? project,
    List<PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(
            key: key,
            selectedCategory: selectedCategory,
            modalContext: modalContext,
            exam: exam,
            task: task,
            project: project,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static const PageInfo<AddTaskRouteArgs> page =
      PageInfo<AddTaskRouteArgs>(name);
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({
    this.key,
    required this.selectedCategory,
    this.modalContext,
    this.exam,
    this.task,
    this.project,
  });

  final Key? key;

  final int selectedCategory;

  final BuildContext? modalContext;

  final ExamModel? exam;

  final TaskModel? task;

  final ProjectModel? project;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key, selectedCategory: $selectedCategory, modalContext: $modalContext, exam: $exam, task: $task, project: $project}';
  }
}

/// generated route for
/// [AuthWrapperPage]
class AuthWrapperRoute extends PageRouteInfo<void> {
  const AuthWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AuthWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CalendarPage]
class CalendarRoute extends PageRouteInfo<void> {
  const CalendarRoute({List<PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotesPage]
class NotesRoute extends PageRouteInfo<void> {
  const NotesRoute({List<PageRouteInfo>? children})
      : super(
          NotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TaskTrackerPage]
class TaskTrackerRoute extends PageRouteInfo<void> {
  const TaskTrackerRoute({List<PageRouteInfo>? children})
      : super(
          TaskTrackerRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskTrackerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
