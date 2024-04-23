import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/main_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = [
      {
        'asset': 'assets/icons/user.svg',
        'title': 'My Account',
        'description': 'Edit your account details.',
        'onPressed': () => context.router.push(const AccountRoute()),
      },
      {
        'asset': 'assets/icons/shield.svg',
        'title': 'Privacy',
        'description': 'Adjust your privacy settings.',
      },
      {
        'asset': 'assets/icons/bell.svg',
        'title': 'Notifications',
        'description': 'Notification preferences.',
      }
    ];
    final List<dynamic> items2 = [
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Settings',
                      style: EduPotDarkTextTheme.headline1,
                    ),
                    Image.asset(
                      "assets/images/user.png",
                      scale: 3.25,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "My settings",
                    style: EduPotDarkTextTheme.smallHeadline,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: EduPotColorTheme.mainItemGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: List.generate(
                      3,
                      (index) => Column(
                        children: [
                          MainCard(
                            items[index]['asset'],
                            title: items[index]['title'],
                            description: items[index]['description'],
                            gradient: EduPotColorTheme.lightGrayCardGradient,
                            onPressed: () {
                              if (items[index]['onPressed'] != null) {
                                items[index]['onPressed']();
                              }
                            },
                          ),
                          if (index != 2)
                            Divider(
                              color: Colors.white.withOpacity(0.1),
                              thickness: 1,
                              height: 1,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Applications",
                    style: EduPotDarkTextTheme.smallHeadline,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: EduPotColorTheme.mainItemGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: List.generate(
                      4,
                      (index) => Column(
                        children: [
                          MainCard(
                            items2[index]['asset'],
                            title: items2[index]['title'],
                            description: items2[index]['description'],
                            gradient: items2[index]['gradient'],
                            onPressed: () {},
                          ),
                          if (index != 3)
                            Divider(
                              color: Colors.white.withOpacity(0.1),
                              thickness: 1,
                              height: 1,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
