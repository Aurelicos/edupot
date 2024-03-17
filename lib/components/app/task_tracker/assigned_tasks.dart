import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/multi_select_dropdown.dart';
import 'package:flutter/material.dart';

class AssignedTasks extends StatefulWidget {
  final String title;
  final void Function(String) onIdChange;
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
  String? selectedItemId;

  @override
  Widget build(BuildContext context) {
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
          items: _createDropdownItems(),
          onChange: (value) {
            setState(() {
              selectedItemId = value.isEmpty ? null : value;
            });
            widget.onIdChange(value);
          },
        )
      ],
    );
  }

  List<MultiSelectDropdownItem> _createDropdownItems() {
    final items = ['item1', 'item2', 'item3', 'item4', 'item5'];
    return items
        .asMap()
        .entries
        .map(
          (item) => MultiSelectDropdownItem(
            id: item.value,
            name: item.value,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
              child: Text(
                formatText(item.value, 14),
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
  }
}
