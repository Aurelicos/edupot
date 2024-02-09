import 'package:edupot/widgets/task_tracker/grid_project.dart';
import 'package:edupot/widgets/task_tracker/list_project.dart';
import 'package:edupot/widgets/task_tracker/project_widget.dart';
import 'package:flutter/material.dart';

class ProjectView extends StatefulWidget {
  final List<dynamic> itemArray;
  const ProjectView({super.key, required this.itemArray});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  Widget build(BuildContext context) {
    if (widget.itemArray.length <= 2) {
      return ProjectWidget(
        itemArray: widget.itemArray,
      );
    } else if (widget.itemArray.length <= 4) {
      return GridProject(
        itemArray: widget.itemArray,
      );
    } else if (widget.itemArray.length > 4) {
      return SizedBox(
        height: 175,
        child: ListProject(
          itemArray: widget.itemArray,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
