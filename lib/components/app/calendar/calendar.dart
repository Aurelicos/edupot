import 'package:edupot/components/app/calendar/days_grid.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  bool _isWeekView = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    final projectProvider = Provider.of<ProjectProvider>(context);

    final selectedMonth = _selectedDate.month;
    final selectedYear = _selectedDate.year;

    final tasksInMonth = entryProvider.tasks
        .where((task) =>
            task.finalDate.month == selectedMonth &&
            task.finalDate.year == selectedYear)
        .toList();

    final examsInMonth = entryProvider.exams
        .where((exam) =>
            exam.finalDate.month == selectedMonth &&
            exam.finalDate.year == selectedYear)
        .toList();

    final projectsInMonth = projectProvider.projects
        .where((project) =>
            project.finalDate.month == selectedMonth &&
            project.finalDate.year == selectedYear)
        .toList();

    final tasksCount = tasksInMonth.length;
    final examsCount = examsInMonth.length;
    final projectsCount = projectsInMonth.length;

    final fullCount = tasksCount + examsCount + projectsCount;

    final tasksInDay = entryProvider.tasks
        .where((task) => _isSameDate(task.finalDate, _selectedDate))
        .toList();

    final examsInDay = entryProvider.exams
        .where((exam) => _isSameDate(exam.finalDate, _selectedDate))
        .toList();

    final entriesInDay = [...tasksInDay, ...examsInDay];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year,
                      _selectedDate.month - 1, _selectedDate.day);
                  _isWeekView = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                padding: const EdgeInsets.all(10),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              "${DateFormat('MMMM').format(_selectedDate)}${_selectedDate.year != DateTime.now().year ? " ${_selectedDate.year}" : ""}",
              style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year,
                      _selectedDate.month + 1, _selectedDate.day);
                  _isWeekView = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 3),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: DaysGrid(
            selectedDate: _selectedDate,
            isWeekView: _isWeekView,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
                _isWeekView = true;
                _controller.forward();
              });
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) {
              if (details.delta.dy > 0) {
                setState(() {
                  _isWeekView = false;
                  _controller.reverse();
                });
              } else if (details.delta.dy < 0) {
                setState(() {
                  _isWeekView = true;
                  _controller.forward();
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              child: _isWeekView
                  ? entriesInDay.isNotEmpty
                      ? Column(
                          children: [
                            TaskView(entry: examsInDay),
                            TaskView(entry: tasksInDay),
                          ],
                        )
                      : Center(
                          child: Text(
                            'No entries on this day.',
                            style: EduPotDarkTextTheme.headline2(1),
                          ),
                        )
                  : fullCount > 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tasksCount > 0)
                              point(tasksCount, "task",
                                  EduPotColorTheme.tasksPurple),
                            if (examsCount > 0)
                              point(examsCount, "exam",
                                  EduPotColorTheme.examsOrange),
                            if (projectsCount > 0)
                              point(projectsCount, "project",
                                  EduPotColorTheme.projectBlue),
                          ],
                        )
                      : const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }

  Widget point(int count, String singular, Color color) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/circle.svg",
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text(
          '$count ${count == 1 ? singular : '${singular}s'}',
          style: EduPotDarkTextTheme.headline2(1),
        ),
      ],
    );
  }
}
