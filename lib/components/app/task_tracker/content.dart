import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_button.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/task_tracker/search_dropdown.dart';
import 'package:flutter/material.dart';

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
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DescriptionText(text: "Assigned to project"),
                  SearchDropdown(
                    itemList: const ['Exam', 'Task', 'Project'],
                    gradient: EduPotColorTheme.mainItemGradient,
                    dropdownButtonStyle: SearchDropdownButtonStyle(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hideIcon: true,
                    items: _createDropdownItems(),
                    onChange: (value) {},
                  )
                ],
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

  List<SearchDropdownItem> _createDropdownItems() {
    const items = ['Exam', 'Task', 'Project'];
    return items
        .asMap()
        .entries
        .map(
          (item) => SearchDropdownItem(
            id: item.value,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                item.value,
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
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
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DescriptionText(text: "Assigned tasks"),
                  InputButton(
                    onPressed: () {},
                    asset: "assets/icons/search.svg",
                    text: "Task 1",
                  ),
                ],
              ),
            ),
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
  final String title;
  final String timeText;
  final String dateText;

  final void Function()? onAttachment;
  final void Function()? onProject;
  final void Function()? onDate;
  final void Function()? onTime;

  const TaskContent({
    required this.title,
    required this.timeText,
    required this.dateText,
    this.onAttachment,
    this.onProject,
    this.onDate,
    this.onTime,
  });
}

class ProjectContent {
  final void Function(String input) onTextChanged;
  final String timeText;
  final String dateText;

  final void Function()? onDate;
  final void Function()? onTime;
  final void Function()? onAttachment;

  const ProjectContent({
    required this.onTextChanged,
    required this.timeText,
    required this.dateText,
    this.onDate,
    this.onTime,
    this.onAttachment,
  });
}
