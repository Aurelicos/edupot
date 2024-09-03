import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaysGrid extends StatelessWidget {
  final List<List<List<int>>> dates;
  final DateTime selectedDate;
  const DaysGrid({super.key, required this.dates, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays =
        DateFormat.E().dateSymbols.STANDALONESHORTWEEKDAYS;

    final firstLine = dates[1][0].length < 7 && dates[0].isNotEmpty
        ? dates[0][dates[0].length - 1] + dates[1][0]
        : dates[1][0];

    final lastLine = dates[1][dates[1].length - 1].length < 7 &&
            dates.length > 2 &&
            dates[2].isNotEmpty
        ? dates[1][dates[1].length - 1] + dates[2][0]
        : dates[1][dates[1].length - 1];

    final lastMonthLength =
        dates[0].isNotEmpty ? dates[0][dates[0].length - 1].length : 0;
    int nextMonthLength =
        dates.length > 2 && dates[2].isNotEmpty ? dates[2][0].length : 0;

    final List<List<int>> days = [
      firstLine,
      ...dates[1].sublist(1, dates[1].length - 1),
      lastLine
    ];

    final List<int> flatDays = days.expand((week) => week).toList();

    if (flatDays.length < 42 && dates.length > 2 && dates[2].length > 1) {
      final int daysToAdd = 42 - flatDays.length;
      final List<int> extraDays = List.generate(
          daysToAdd, (index) => dates[2][1][index % dates[2][1].length]);
      nextMonthLength += daysToAdd;
      flatDays.addAll(extraDays);
    }

    return Column(
      children: [
        const SizedBox(height: 20),
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
          shrinkWrap: true,
          itemCount: 42,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 5 / 4,
          ),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            final int day = flatDays[index];
            final bool isCurrentMonth =
                index >= lastMonthLength && index < (42 - nextMonthLength);

            return Container(
              width: MediaQuery.of(context).size.width / 7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isCurrentMonth &&
                        DateTime.now().day == day &&
                        DateTime.now().year == selectedDate.year &&
                        DateTime.now().month == selectedDate.month
                    ? Colors.white12
                    : Colors.transparent,
              ),
              child: Text(
                day.toString(),
                style: EduPotDarkTextTheme.headline2(isCurrentMonth ? 1 : 0.4),
              ),
            );
          },
        ),
      ],
    );
  }
}
