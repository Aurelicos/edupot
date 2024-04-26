import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/widgets/task_tracker/grid_project.dart';
import 'package:edupot/widgets/task_tracker/list_project.dart';
import 'package:edupot/widgets/task_tracker/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context, listen: true);
    final finishedTasks =
        entryProvider.tasks.where((element) => element.done == true).toList();

    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
        final itemArray = projectProvider.projects;
        if (itemArray.length <= 2 && itemArray.isNotEmpty) {
          return ProjectWidget(
            itemArray: itemArray,
            finishedTasks: finishedTasks,
          );
        } else if (itemArray.length <= 4) {
          return GridProject(
            itemArray: itemArray,
            finishedTasks: finishedTasks,
          );
        } else if (itemArray.length > 4) {
          return SizedBox(
            height: 175,
            child: ListProject(
              itemArray: itemArray,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
