import 'package:edupot/widgets/task_tracker/grid_project.dart';
import 'package:edupot/widgets/task_tracker/list_project.dart';
import 'package:edupot/widgets/task_tracker/project_widget.dart';
import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  final List<Map<String, dynamic>> itemArray;
  const TaskView({super.key, required this.itemArray});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    if (widget.itemArray.length <= 2) {
      return ProjectWidget(itemArray: widget.itemArray);
    } else if (widget.itemArray.length <= 4) {
      return GridProject(
        itemArray: widget.itemArray,
      );
    } else if (widget.itemArray.length > 4) {
      return const ListProject();
    } else {
      return const SizedBox();
    }
  }
}
