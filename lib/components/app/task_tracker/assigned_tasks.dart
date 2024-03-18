import 'package:edupot/models/entries/task.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/multi_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignedTasks extends StatefulWidget {
  final String title;
  final void Function(List<Item>) onIdChange;
  final String? id;
  const AssignedTasks({
    super.key,
    required this.title,
    required this.onIdChange,
    this.id,
  });

  @override
  State<AssignedTasks> createState() => _AssignedTasksState();
}

class _AssignedTasksState extends State<AssignedTasks> {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionText(text: widget.title),
        MultiSelectDropdown(
          placeholder: "Select Tasks",
          gradient: EduPotColorTheme.mainItemGradient,
          dropdownButtonStyle: MultiSelectDropdownButtonStyle(
            borderRadius: BorderRadius.circular(8),
          ),
          initialSelection: widget.id,
          hideIcon: true,
          items: _createDropdownItems(entryProvider),
          onChange: (value) {
            widget.onIdChange(value);
          },
        )
      ],
    );
  }

  List<MultiSelectDropdownItem> _createDropdownItems(EntryProvider provider) {
    List<TaskModel> items = provider.tasks;
    return items
        .asMap()
        .entries
        .map(
          (item) => MultiSelectDropdownItem(
            id: item.value.id!,
            name: item.value.title,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
              child: Text(
                formatText(item.value.title, 14),
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
  }
}
