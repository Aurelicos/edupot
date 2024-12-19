import 'dart:ui';

import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/routes/app/calendar/calendar_page.dart';
import 'package:edupot/routes/app/learning/learning_page.dart';
import 'package:edupot/routes/app/settings/settings_page.dart';
import 'package:edupot/routes/app/task_tracker/task_tracker_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavbarProvider>();
    return Container(
      height: 84,
      color: EduPotColorTheme.navbar,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _button(
                index: 0,
                icon: "calendar",
                label: "Calendar",
                onPressed: () async {
                  if (provider.selectedIndex != 0) {
                    provider.selectedIndex = 0;
                    Get.off(const CalendarPage(),
                        transition: Transition.noTransition);
                  }
                },
                provider: provider,
              ),
              _button(
                index: 1,
                icon: "tasks",
                label: "Tasks",
                onPressed: () {
                  if (provider.selectedIndex != 1) {
                    provider.selectedIndex = 1;
                    Get.off(const TaskTrackerPage(),
                        transition: Transition.noTransition);
                  }
                },
                provider: provider,
              ),
              _button(
                index: 2,
                icon: "study",
                label: "Learn",
                onPressed: () {
                  if (provider.selectedIndex != 2) {
                    provider.selectedIndex = 2;
                    Get.off(const LearningPage(),
                        transition: Transition.noTransition);
                  }
                },
                provider: provider,
              ),
              _button(
                index: 3,
                icon: "setting",
                label: "Settings",
                onPressed: () {
                  if (provider.selectedIndex != 3) {
                    provider.selectedIndex = 3;
                    Get.off(const SettingsPage(),
                        transition: Transition.noTransition);
                  }
                },
                provider: provider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future comingSoonDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: EduPotColorTheme.primaryDark,
        title: Text(
          'Coming Soon',
          style: EduPotDarkTextTheme.smallHeadline.copyWith(fontSize: 24),
        ),
        content: Text(
          'This feature is coming soon!',
          style: EduPotDarkTextTheme.headline2(0.6),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Close',
              style: EduPotDarkTextTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required index,
    required String icon,
    required String label,
    required void Function() onPressed,
    required NavbarProvider provider,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          overlayColor:
              WidgetStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            provider.selectedIndex == index
                ? Colors.white
                : Colors.white.withOpacity(0.45),
            BlendMode.srcIn,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 32,
                child: SvgPicture.asset(
                  'assets/icons/$icon.svg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
