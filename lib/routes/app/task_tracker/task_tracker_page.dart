import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/project_view.dart';
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

    final examsArray = [
      {
        "title": "Math - planimetry",
        "finalDate": DateTime.parse("2024-02-08 22:18:04Z"),
      },
      {
        "title": "Math - algebra",
        "finalDate": DateTime.parse("2024-02-09 22:18:04Z"),
      }
    ];

    final tasksArray = [
      {
        "title": "Go home",
        "finalDate": DateTime.parse("2024-02-14 22:18:04Z"),
      },
      {
        "title": "Play with niggas",
        "finalDate": DateTime.parse("2024-02-12 22:18:04Z"),
      }
    ];

    return PrimaryScaffold(
      onPressed: () {},
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
                ProjectView(
                  itemArray: array,
                ),
                TaskView(
                  title: "Exams",
                  array: examsArray,
                  color: EduPotColorTheme.examsOrange,
                ),
                TaskView(
                  title: "Tasks",
                  array: tasksArray,
                  color: EduPotColorTheme.tasksPurple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
