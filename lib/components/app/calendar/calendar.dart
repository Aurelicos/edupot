import 'package:edupot/components/app/calendar/days_grid.dart';
import 'package:edupot/utils/calendar/date_generator.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<List<List<int>>> dates = generateDate(_selectedDate);

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
        DaysGrid(
          dates: dates,
          selectedDate: _selectedDate,
        ),
      ],
    );
  }
}
