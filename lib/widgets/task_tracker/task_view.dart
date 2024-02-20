import 'package:edupot/models/exam.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskView extends StatelessWidget {
  final String title;
  final Color? color;
  final List<dynamic> entry;
  const TaskView({
    super.key,
    this.color,
    required this.entry,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    entry.sort((a, b) => a.finalDate.compareTo(b.finalDate));
    return entry.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(title, style: EduPotDarkTextTheme.headline4),
              ...entry.map((entry) => buildEntryItem(context, entry)),
            ],
          )
        : const SizedBox();
  }

  Widget buildEntryItem(BuildContext context, ExamModel exam) {
    Map<String, dynamic> formattedDate = formatDate(exam.finalDate);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: EduPotColorTheme.primaryBlueDark,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/circle.svg",
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          ),
          const SizedBox(width: 15),
          Text(exam.title, style: EduPotDarkTextTheme.headline2(1)),
          const Spacer(),
          Text(
            formattedDate["finalDate"],
            style: EduPotDarkTextTheme.headline2(1).copyWith(
              color: getColorForDays(formattedDate["daysUntil"]),
            ),
          ),
        ],
      ),
    );
  }

  Color getColorForDays(int daysUntil) {
    const int maxDays = 7;
    Color startColor = Colors.red;
    Color endColor = Colors.white;

    if (daysUntil < 0) {
      return Colors.yellow;
    } else if (daysUntil >= 0 && daysUntil <= maxDays) {
      double ratio = daysUntil / maxDays;
      return Color.lerp(startColor, endColor, ratio)!;
    } else {
      return endColor;
    }
  }

  Map<String, dynamic> formatDate(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    DateTime now = DateTime.now();
    DateTime normalizedNow = DateTime(now.year, now.month, now.day);

    int daysUntil = normalizedDate.difference(normalizedNow).inDays;
    String finalDate;

    if (daysUntil < 0) {
      finalDate = "Overdue";
    } else if (daysUntil == 0) {
      finalDate = "Today";
    } else if (daysUntil == 1) {
      finalDate = "1 day";
    } else if (daysUntil > 1 && daysUntil < 7) {
      finalDate = "$daysUntil days";
    } else {
      finalDate = "${date.day}.${date.month}.";
    }

    return {"finalDate": finalDate, "daysUntil": daysUntil};
  }
}
