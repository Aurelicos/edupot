import 'package:edupot/components/app/calendar/days_grid.dart';
import 'package:edupot/providers/day_provider.dart';
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
  bool _isWeekView = false;

  late AnimationController _controller;

  late DateTime _displayedMonth;
  int _slideDirection = 0;
  DayProvider dayProvider = DayProvider();

  @override
  void initState() {
    super.initState();
    dayProvider = Provider.of<DayProvider>(context, listen: false);

    _displayedMonth = DateTime(
        dayProvider.selectedDate.year, dayProvider.selectedDate.month, 1);
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

  void _onHorizontalSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0) {
      setState(() {
        _slideDirection = 1;
        _displayedMonth = DateTime(
          _displayedMonth.year,
          _displayedMonth.month + 1,
          1,
        );
        _isWeekView = false;
      });
    } else if (details.primaryVelocity! > 0) {
      setState(() {
        _slideDirection = -1;
        _displayedMonth = DateTime(
          _displayedMonth.year,
          _displayedMonth.month - 1,
          1,
        );
        _isWeekView = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    final projectProvider = Provider.of<ProjectProvider>(context);

    final selectedMonth = _displayedMonth.month;
    final selectedYear = _displayedMonth.year;

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
        .where((task) => _isSameDate(task.finalDate, dayProvider.selectedDate))
        .toList();

    final examsInDay = entryProvider.exams
        .where((exam) => _isSameDate(exam.finalDate, dayProvider.selectedDate))
        .toList();

    final entriesInDay = [...tasksInDay, ...examsInDay];

    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalSwipe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _slideDirection = -1;
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month - 1,
                      1,
                    );
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
                "${DateFormat('MMMM').format(_displayedMonth)}${_displayedMonth.year != DateTime.now().year ? " ${_displayedMonth.year}" : ""}",
                style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 24),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _slideDirection = 1;
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month + 1,
                      1,
                    );
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: Offset(_slideDirection.toDouble(), 0),
                  end: const Offset(0, 0),
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: DaysGrid(
                key: ValueKey(_displayedMonth.month),
                displayedMonth: _displayedMonth,
                selectedDate: dayProvider.selectedDate,
                isWeekView: _isWeekView,
                onDateSelected: (date) {
                  setState(() {
                    dayProvider.selectedDate = date;
                    _isWeekView = true;
                    _controller.forward();
                  });
                },
              ),
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
                              TaskView(
                                entry: examsInDay,
                                color: EduPotColorTheme.examsOrange,
                                returnBack: true,
                              ),
                              TaskView(
                                entry: tasksInDay,
                                color: EduPotColorTheme.tasksPurple,
                                returnBack: true,
                              ),
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
                              if (tasksCount > 0 &&
                                  examsCount > 0 &&
                                  projectsCount > 0)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Monthly Overview:',
                                    style: EduPotDarkTextTheme.headline4,
                                  ),
                                ),
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
      ),
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
