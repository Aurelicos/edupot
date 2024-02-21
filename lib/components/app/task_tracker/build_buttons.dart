import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/hexagon.dart';
import 'package:edupot/widgets/task_tracker/task_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildButtons(int index, void Function(int) onChange) {
  return TaskDropdown<int>(
    onChange: onChange,
    gradient: EduPotColorTheme.mainItemGradient,
    index: index,
    dropdownButtonStyle: createDropdownButtonStyle(),
    dropdownStyle: createDropdownStyle(),
    items: createDropdownItems(),
  );
}

TaskDropdownButtonStyle createDropdownButtonStyle() {
  return TaskDropdownButtonStyle(
    height: 56,
    width: double.infinity,
    elevation: 1,
    gradient: EduPotColorTheme.mainItemGradient,
    borderRadius: BorderRadius.circular(7),
  );
}

TaskDropdownStyle createDropdownStyle() {
  return TaskDropdownStyle(
    elevation: 1,
    padding: const EdgeInsets.all(5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
  );
}

List<TaskDropdownItem<int>> createDropdownItems() {
  const tasks = ['📝 Exam', '💻 Task', '🗂️ Project'];
  return tasks
      .asMap()
      .entries
      .map((item) => TaskDropdownItem<int>(
            gradient: EduPotColorTheme.mainItemGradient,
            value: item.key + 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                item.value,
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ))
      .toList();
}

Widget buildHeadline(String title, BuildContext context,
    {bool isProject = false, String hexagonText = "MP", required Color color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          isProject
              ? Row(
                  children: [
                    Hexagon(
                      title: hexagonText,
                      height: 42,
                      width: 42,
                      fontSize: 18,
                    ),
                    const SizedBox(width: 10)
                  ],
                )
              : const SizedBox(),
          Text(
            formatText(
                title,
                context,
                EduPotDarkTextTheme.headline1.copyWith(fontSize: 32),
                MediaQuery.of(context).size.width * 0.75 -
                    (isProject ? 42 : 0)),
            style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 32),
          ),
        ],
      ),
      SvgPicture.asset(
        "assets/icons/circle_big.svg",
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    ],
  );
}

String formatText(
  String input,
  BuildContext context,
  TextStyle textStyle,
  double maxWidth,
) {
  TextPainter painter = TextPainter(
    textDirection: TextDirection.ltr,
    text: TextSpan(text: input, style: textStyle),
  );

  painter.layout();

  if (painter.width > maxWidth) {
    for (int i = input.length; i > 0; i--) {
      painter.text =
          TextSpan(text: "${input.substring(0, i)}...", style: textStyle);
      painter.layout();

      if (painter.width <= maxWidth) {
        return "${input.substring(0, i)}...";
      }
    }
  }

  return input;
}

int findTruncationIndex(String input, TextStyle textStyle, double maxWidth) {
  for (int i = input.length; i > 0; i--) {
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: "${input.substring(0, i)}...", style: textStyle),
    );
    painter.layout();
    if (painter.width <= maxWidth) {
      return i;
    }
  }
  return input.length;
}
