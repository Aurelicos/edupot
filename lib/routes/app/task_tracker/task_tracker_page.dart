import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/project_view.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class TaskTrackerPage extends StatefulWidget {
  const TaskTrackerPage({super.key});

  @override
  State<TaskTrackerPage> createState() => _TaskTrackerPageState();
}

class _TaskTrackerPageState extends State<TaskTrackerPage> {
  List array = [
    {
      "title": "Muster Projekt Beispiel",
      "description": "Description 1",
      "finalDate": DateTime.parse("2022-01-22 22:18:04Z"),
      "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
      "finished": 3,
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
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      onPressed: () {
        setState(() {
          array.add({
            "title": "New Project Example",
            "description": "Description for the new project",
            "finalDate": DateTime.parse("2023-01-22 22:18:04Z"),
            "tasks": ["Task 1", "Task 2"],
            "finished": 1,
            "iconTitle": "NP"
          });
        });
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.045,
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
