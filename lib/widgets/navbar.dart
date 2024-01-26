import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:edupot/providers/navbar_provider.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                    context.replaceRoute(const CalendarRoute());
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
                    context.replaceRoute(const TaskTrackerRoute());
                  }
                },
                provider: provider,
              ),
              _button(
                index: 2,
                icon: "notes",
                label: "Notes",
                onPressed: () {
                  if (provider.selectedIndex != 2) {
                    provider.selectedIndex = 2;
                    context.replaceRoute(const NotesRoute());
                  }
                },
                provider: provider,
              ),
              _button(
                index: 3,
                icon: "settings",
                label: "Settings",
                onPressed: () {
                  if (provider.selectedIndex != 3) {
                    provider.selectedIndex = 3;
                    context.replaceRoute(const SettingsRoute());
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
              MaterialStateColor.resolveWith((states) => Colors.transparent),
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