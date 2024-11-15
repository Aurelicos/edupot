import 'package:edupot/components/app/calendar/day_cell.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DaysGrid extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime selectedDate;
  final bool isWeekView;
  final Function(DateTime) onDateSelected;

  const DaysGrid({
    super.key,
    required this.displayedMonth,
    required this.selectedDate,
    required this.isWeekView,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final weekDays = DateFormat.E().dateSymbols.STANDALONESHORTWEEKDAYS;

    final entryProvider = Provider.of<EntryProvider>(context);
    final projectProvider = Provider.of<ProjectProvider>(context);

    final examsDates = entryProvider.exams
        .map((exam) => DateTime(
            exam.finalDate.year, exam.finalDate.month, exam.finalDate.day))
        .toList();
    final tasksDates = entryProvider.tasks
        .map((task) => DateTime(
            task.finalDate.year, task.finalDate.month, task.finalDate.day))
        .toList();
    final projectsDates = projectProvider.projects
        .map((project) => DateTime(project.finalDate.year,
            project.finalDate.month, project.finalDate.day))
        .toList();

    final dayInfos =
        generateDayInfos(displayedMonth, examsDates, tasksDates, projectsDates);

    List<DayInfo> displayedDayInfos = dayInfos;
    if (isWeekView) {
      displayedDayInfos = getWeekDayInfos(dayInfos, selectedDate);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays
              .map((day) => Expanded(
                    child: Center(
                      child: Text(day,
                          style: EduPotDarkTextTheme.headline2(0.4)
                              .copyWith(fontSize: 13)),
                    ),
                  ))
              .toList(),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayedDayInfos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 5 / 4,
          ),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            final dayInfo = displayedDayInfos[index];
            return DayCell(
              dayInfo: dayInfo,
              selected: dayInfo.date.day == selectedDate.day &&
                  dayInfo.date.month == selectedDate.month &&
                  dayInfo.date.year == selectedDate.year,
              onDateSelected: (date) {
                onDateSelected(date);
              },
            );
          },
        ),
      ],
    );
  }

  List<DayInfo> generateDayInfos(
    DateTime displayedMonth,
    List<DateTime> examsDates,
    List<DateTime> tasksDates,
    List<DateTime> projectsDates,
  ) {
    DateTime firstDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;
    int daysToSubtract = weekdayOfFirstDay - 1;
    DateTime firstDateInGrid =
        firstDayOfMonth.subtract(Duration(days: daysToSubtract));

    List<DateTime> gridDates = List.generate(
        42, (index) => firstDateInGrid.add(Duration(days: index)));

    Set<String> examsDatesSet =
        examsDates.map((date) => DateFormat('yyyy-MM-dd').format(date)).toSet();
    Set<String> tasksDatesSet =
        tasksDates.map((date) => DateFormat('yyyy-MM-dd').format(date)).toSet();
    Set<String> projectsDatesSet = projectsDates
        .map((date) => DateFormat('yyyy-MM-dd').format(date))
        .toSet();

    return gridDates.map((date) {
      String dateStr = DateFormat('yyyy-MM-dd').format(date);
      bool isCurrentMonth = date.month == displayedMonth.month;
      bool hasExam = examsDatesSet.contains(dateStr);
      bool hasTask = tasksDatesSet.contains(dateStr);
      bool hasProject = projectsDatesSet.contains(dateStr);

      return DayInfo(
        date: date,
        isCurrentMonth: isCurrentMonth,
        hasExam: hasExam,
        hasTask: hasTask,
        hasProject: hasProject,
      );
    }).toList();
  }

  List<DayInfo> getWeekDayInfos(List<DayInfo> dayInfos, DateTime selectedDate) {
    int selectedIndex = dayInfos.indexWhere((dayInfo) =>
        dayInfo.date.day == selectedDate.day &&
        dayInfo.date.month == selectedDate.month &&
        dayInfo.date.year == selectedDate.year);

    int weekStartIndex = selectedIndex - (selectedDate.weekday - 1);
    if (weekStartIndex < 0) {
      weekStartIndex = 0;
    }

    return dayInfos.sublist(weekStartIndex, weekStartIndex + 7);
  }
}
