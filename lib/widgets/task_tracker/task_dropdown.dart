import 'package:flutter/material.dart';

class TaskDropdown extends StatefulWidget {
  final List<String> items;
  const TaskDropdown({super.key, required this.items});

  @override
  State<TaskDropdown> createState() => _TaskDropdownState();
}

class _TaskDropdownState extends State<TaskDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.isNotEmpty ? widget.items.first : '';
  }

  void _showDropdownUnderButton(BuildContext context, GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);

    final buttonSize = renderBox?.size;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        offset!,
        offset + Offset(buttonSize!.width, buttonSize.height),
      ),
      Offset.zero & overlay!.size,
    );

    showMenu(
      context: context,
      position: position,
      items: widget.items.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedValue = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _buttonKey = GlobalKey();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          key: _buttonKey,
          onPressed: () => _showDropdownUnderButton(context, _buttonKey),
          child: Text(selectedValue),
        ),
      ],
    );
  }
}
