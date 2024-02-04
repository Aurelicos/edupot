import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class TaskTrackerPage extends StatelessWidget {
  const TaskTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final array = [
      {
        "title": "Muster Projekt Beispiel",
        "description": "Description 1",
        "finalDate": DateTime.parse("2022-01-22 22:18:04Z"),
        "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
        "finished": 3,
        "iconTitle": "SP"
      },
      {
        "title": "Task 2",
        "description": "Description 2",
        "finalDate": DateTime.now(),
        "tasks": ["Task 1", "Task 2", "Task 3", "Task 4"],
        "finished": 2,
        "iconTitle": "UI"
      },
      {
        "title": "Task 3",
        "description": "Description 3",
        "finalDate": DateTime.now(),
        "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
        "finished": 4,
        "iconTitle": "SP"
      },
      {
        "title": "Task 3",
        "description": "Description 3",
        "finalDate": DateTime.now(),
        "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
        "finished": 4,
        "iconTitle": "SP"
      },
      {
        "title": "Task 3",
        "description": "Description 3",
        "finalDate": DateTime.now(),
        "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
        "finished": 4,
        "iconTitle": "SP"
      },
    ];

    return PrimaryScaffold(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.085,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Task Tracker',
                      style: EduPotDarkTextTheme.headline1,
                    ),
                    SizedBox(
                      width: 45,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TaskView(
                    itemArray: array,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
