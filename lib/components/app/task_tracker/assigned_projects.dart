import 'package:edupot/models/projects/project.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignedProjects extends StatefulWidget {
  final String title;
  final void Function(String) onIdChange;
  final String? id;
  const AssignedProjects({
    super.key,
    required this.title,
    required this.onIdChange,
    this.id,
  });

  @override
  State<AssignedProjects> createState() => _AssignedProjectsState();
}

class _AssignedProjectsState extends State<AssignedProjects> {
  String? selectedItemId;

  @override
  void initState() {
    super.initState();
    selectedItemId = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionText(text: widget.title),
        SearchDropdown(
          hexagonTitle: selectedItemId != null
              ? projectProvider.projects
                  .firstWhere((element) => element.id == selectedItemId)
                  .iconTitle
              : null,
          placeholder: "Choose project",
          gradient: EduPotColorTheme.mainItemGradient,
          dropdownButtonStyle: SearchDropdownButtonStyle(
            borderRadius: BorderRadius.circular(8),
          ),
          initialSelection: widget.id,
          hideIcon: true,
          items: _createDropdownItems(projectProvider),
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

  List<SearchDropdownItem> _createDropdownItems(ProjectProvider provider) {
    List<ProjectModel> items = provider.projects;
    return items
        .asMap()
        .entries
        .map(
          (item) => SearchDropdownItem(
            id: item.value.id!,
            name: item.value.name,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                formatText(item.value.name, 14),
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
  }
}
