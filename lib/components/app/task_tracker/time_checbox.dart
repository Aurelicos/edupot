import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final void Function() onClick;
  final bool isSelected;
  final String content;
  const CustomCheckbox({
    super.key,
    required this.onClick,
    this.isSelected = false,
    required this.content,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      child: Container(
        width: 110,
        height: 40,
        decoration: widget.isSelected
            ? ShapeDecoration(
                gradient: EduPotColorTheme.timeSuggestGradient,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              )
            : ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: EduPotColorTheme.greyBorder,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
        child: Center(
          child: Text(
            widget.content,
            style: EduPotDarkTextTheme.headline3,
          ),
        ),
      ),
    );
  }
}
