import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/common/bounce_physics.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/main_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingsItems = [
      {
        'asset': 'assets/icons/user.svg',
        'title': 'My Account',
        'description': 'Edit your account details.',
        'onPressed': () => context.router.push(const AccountRoute()),
      },
      {
        'asset': 'assets/icons/shield.svg',
        'title': 'Privacy',
        'description': 'Adjust your privacy settings.'
      },
      {
        'asset': 'assets/icons/bell.svg',
        'title': 'Notifications',
        'description': 'Notification preferences.'
      }
    ];

    final List<Map<String, dynamic>> applicationItems = [
      {
        'asset': 'assets/icons/calendar.svg',
        'title': 'Calendar',
        'description': 'Manage calendar settings.',
        'gradient': EduPotColorTheme.purplePinkGradient
      },
      {
        'asset': 'assets/icons/tasks.svg',
        'title': 'Task Tracker',
        'description': 'Configure task tracker.',
        'gradient': EduPotColorTheme.mainBlueGradient()
      },
      {
        'asset': 'assets/icons/graph.svg',
        'title': 'Data Averaging',
        'description': 'Adjust data for marks data.',
        'gradient': EduPotColorTheme.orangeGradient
      },
      {
        'asset': 'assets/icons/note.svg',
        'title': 'Notes',
        'description': 'Your notes preferences.',
        'gradient': EduPotColorTheme.greenGradient
      }
    ];

    return PrimaryScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const OneBouncePhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _header(context),
                const SizedBox(height: 20),
                _buildSection(context, "My settings", settingsItems),
                const SizedBox(height: 20),
                _buildSection(context, "Applications", applicationItems),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.035),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Settings', style: EduPotDarkTextTheme.headline1),
            Image.asset("assets/images/user.png", scale: 3.25),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(title, style: EduPotDarkTextTheme.smallHeadline),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: EduPotColorTheme.mainItemGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => Column(
                children: [
                  MainCard(
                    items[index]['asset'],
                    title: items[index]['title'],
                    description: items[index]['description'],
                    gradient: items[index]['gradient'] ??
                        EduPotColorTheme.lightGrayCardGradient,
                    onPressed: () {
                      if (items[index]['onPressed'] != null) {
                        items[index]['onPressed']();
                      }
                    },
                  ),
                  if (index != items.length - 1)
                    Divider(
                        color: Colors.white.withOpacity(0.1),
                        thickness: 1,
                        height: 1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
