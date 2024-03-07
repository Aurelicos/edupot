import 'package:edupot/components/app/task_tracker/assigned_projects.dart';
import 'package:edupot/components/app/task_tracker/assigned_tasks.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_button.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Content {
  Widget getContent(
    int index, {
    required ExamContent examContent,
    required TaskContent taskContent,
    required ProjectContent projectContent,
  }) {
    switch (index) {
      case 0:
        return _contentOne(examContent);
      case 1:
        return _contentTwo(taskContent);
      case 2:
        return contentThree(projectContent);
      default:
        return const SizedBox();
    }
  }

  Widget _contentOne(ExamContent examContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DescriptionText(text: "Details"),
        Row(
          children: [
            Expanded(
              child: InputButton(
                onPressed: examContent.onDate,
                asset: "assets/icons/calendar.svg",
                text: examContent.dateText,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: InputButton(
                onPressed: examContent.onTime,
                asset: "assets/icons/clock_simple.svg",
                text: examContent.timeText,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const DescriptionText(text: "Attachment"),
        InputButton(
          onPressed: examContent.onAttachment,
          asset: "assets/icons/upload.svg",
          asset2: "assets/icons/github.svg",
          text: "Attach or Import notes",
        ),
      ],
    );
  }

  Widget _contentTwo(TaskContent content) {
    final projectProvider = Provider.of<ProjectProvider>(content.context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DescriptionText(text: "Attachment"),
                  InputButton(
                    onPressed: content.onAttachment,
                    asset: "assets/icons/upload.svg",
                    text: "Attachment",
                  ),
                ],
              ),
            ),
            if (projectProvider.projects.isNotEmpty)
              const SizedBox(
                width: 15,
              ),
            if (projectProvider.projects.isNotEmpty)
              Expanded(
                child: AssignedProjects(
                  title: "Assigned to project",
                  onIdChange: (value) => content.onProject(value),
                  id: content.docId,
                ),
              )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const DescriptionText(text: "Details"),
        Row(
          children: [
            Expanded(
                child: InputButton(
              onPressed: content.onDate,
              asset: "assets/icons/calendar.svg",
              text: content.dateText,
            )),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: InputButton(
              onPressed: content.onTime,
              asset: "assets/icons/clock_simple.svg",
              text: content.timeText,
            )),
          ],
        ),
      ],
    );
  }

  Widget contentThree(ProjectContent content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: InputField(
                headline: "Two letter title",
                placeholder: "",
                maxLength: 2,
                textChanged: content.onTextChanged,
                initialValue: content.iconTitle,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        AssignedTasks(
          title: "Assigned task",
          onIdChange: (value) => (),
        ),
        const SizedBox(
          height: 5,
        ),
        const DescriptionText(text: "Details"),
        Row(
          children: [
            Expanded(
                child: InputButton(
              onPressed: content.onDate,
              asset: "assets/icons/calendar.svg",
              text: content.dateText,
            )),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: InputButton(
              onPressed: content.onTime,
              asset: "assets/icons/clock_simple.svg",
              text: content.timeText,
            )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const DescriptionText(text: "Attachment"),
        InputButton(
          onPressed: content.onAttachment,
          asset: "assets/icons/upload.svg",
          asset2: "assets/icons/github.svg",
          text: "Attach or Import notes",
        ),
      ],
    );
  }
}

class ExamContent {
  final void Function()? onDate;
  final void Function()? onTime;
  final void Function()? onAttachment;

  final String timeText;
  final String dateText;

  const ExamContent({
    this.onDate,
    this.onTime,
    this.onAttachment,
    required this.timeText,
    required this.dateText,
  });
}

class TaskContent {
  final String timeText;
  final String dateText;
  final BuildContext context;
  final String? docId;

  final void Function()? onAttachment;
  final void Function(String) onProject;
  final void Function()? onDate;
  final void Function()? onTime;

  const TaskContent({
    required this.timeText,
    required this.dateText,
    required this.context,
    required this.onProject,
    this.docId,
    this.onAttachment,
    this.onDate,
    this.onTime,
  });
}

class ProjectContent {
  final void Function(String input) onTextChanged;
  final String timeText;
  final String dateText;
  final String iconTitle;

  final void Function()? onDate;
  final void Function()? onTime;
  final void Function()? onAttachment;

  const ProjectContent({
    required this.onTextChanged,
    required this.timeText,
    required this.dateText,
    required this.iconTitle,
    this.onDate,
    this.onTime,
    this.onAttachment,
  });
}
