import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class DayCell extends StatelessWidget {
  final DayInfo dayInfo;
  final Function(DateTime) onDateSelected;
  final bool selected;

  const DayCell({
    super.key,
    required this.dayInfo,
    required this.onDateSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = dayInfo.date.day == DateTime.now().day &&
        dayInfo.date.month == DateTime.now().month &&
        dayInfo.date.year == DateTime.now().year;

    List<Color> entryColors = [];
    if (dayInfo.hasExam) {
      entryColors.add(EduPotColorTheme.examsOrange);
    }
    if (dayInfo.hasTask) {
      entryColors.add(EduPotColorTheme.tasksPurple);
    }
    if (dayInfo.hasProject) {
      entryColors.add(EduPotColorTheme.projectBlue);
    }
    if (entryColors.isEmpty) {
      entryColors.add(Colors.transparent);
    }

    return TextButton(
      onPressed: () {
        onDateSelected(dayInfo.date);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        minimumSize: Size(MediaQuery.of(context).size.width / 7, 0),
        backgroundColor: selected
            ? const Color.fromARGB(106, 68, 137, 255)
            : dayInfo.isCurrentMonth && isToday
                ? Colors.white12
                : Colors.transparent,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayInfo.date.day.toString(),
              style: EduPotDarkTextTheme.headline2(
                  dayInfo.isCurrentMonth ? 1 : 0.4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < entryColors.length; i++)
                  Container(
                    width: 4,
                    height: 4,
                    margin: EdgeInsets.only(left: i > 0 ? 4 : 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: entryColors[i],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DayInfo {
  final DateTime date;
  final bool isCurrentMonth;
  final bool hasExam;
  final bool hasTask;
  final bool hasProject;

  DayInfo({
    required this.date,
    required this.isCurrentMonth,
    required this.hasExam,
    required this.hasTask,
    required this.hasProject,
  });
}
