import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/task_modal.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/project_view.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TaskTrackerPage extends StatefulWidget {
  const TaskTrackerPage({super.key});

  @override
  State<TaskTrackerPage> createState() => _TaskTrackerPageState();
}

class _TaskTrackerPageState extends State<TaskTrackerPage> {
  bool _isLoading = true;
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      final entryProvider = context.read<EntryProvider>();
      Future.delayed(const Duration(seconds: 2), () {
        entryProvider
            .fetchExams(userProvider.user!.uid ?? "")
            .then((bool value) {
          setState(() {
            _isLoading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> exams = Provider.of<EntryProvider>(context).exams;
    return PrimaryScaffold(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: EduPotColorTheme.primaryDark,
          builder: (BuildContext context) {
            return TaskModal(
              onPressed: (int index) =>
                  context.pushRoute(AddTaskRoute(selectedCategory: index)),
            );
          },
        );
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
                _isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : TaskView(
                        title: "Exams",
                        entry: exams,
                        color: EduPotColorTheme.examsOrange,
                      ),
                // TaskView(
                //   title: "Tasks",
                //   entry: tasksArray,
                //   color: EduPotColorTheme.tasksPurple,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
