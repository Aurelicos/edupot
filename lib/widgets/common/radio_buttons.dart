import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  final int count;
  final void Function(int) onChanged;
  final List<String> options;
  const RadioButtons(
      {super.key,
      required this.count,
      required this.onChanged,
      required this.options});

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.count, (i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedValue = i;
            });
            widget.onChanged(i);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedValue == i
                    ? EduPotColorTheme.projectBlue
                    : Colors.transparent,
              ),
              gradient: EduPotColorTheme.mainItemGradient,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Radio<int>(
                  value: i,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                    widget.onChanged(value ?? 0);
                  },
                  activeColor: EduPotColorTheme.projectBlue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.options[i],
                    style: EduPotDarkTextTheme.headline2(1),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
