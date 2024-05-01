import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

class TaskView extends StatelessWidget {
  final Color? color;
  final List<dynamic> entry;
  final bool isTask;
  const TaskView({
    super.key,
    this.color,
    this.isTask = false,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    entry.sort((a, b) {
      DateTime dateA =
          isTask ? (a as TaskModel).finalDate : (a as ExamModel).finalDate;
      DateTime dateB =
          isTask ? (b as TaskModel).finalDate : (b as ExamModel).finalDate;
      return dateA.compareTo(dateB);
    });
    return entry.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in entry) buildEntryItem(context, item),
            ],
          )
        : const SizedBox();
  }

  Widget buildEntryItem(BuildContext context, dynamic item) {
    String title;
    DateTime finalDate;

    if (item is ExamModel) {
      title = item.title;
      finalDate = item.finalDate;
    } else if (item is TaskModel) {
      title = item.title;
      finalDate = item.finalDate;
    } else {
      throw Exception('Unknown item type');
    }

    Map<String, dynamic> formattedDate = formatDate(finalDate, item);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 54,
      child: TextButton(
        onPressed: () {
          if (item is ExamModel) {
            Get.to(AddTaskPage(selectedCategory: 0, exam: item));
          } else if (item is TaskModel) {
            Get.to(AddTaskPage(selectedCategory: 1, task: item));
          }
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 20)),
          backgroundColor: MaterialStateProperty.all<Color>(
              EduPotColorTheme.primaryBlueDark),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
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
            Text(title, style: EduPotDarkTextTheme.headline2(1)),
            const Spacer(),
            Text(
              formattedDate["finalDate"],
              style: EduPotDarkTextTheme.headline2(1).copyWith(
                color: getColorForDays(formattedDate["daysUntil"]),
              ),
            ),
          ],
        ),
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

  Map<String, dynamic> formatDate(DateTime date, dynamic item) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    DateTime now = DateTime.now();
    DateTime normalizedNow = DateTime(now.year, now.month, now.day);

    int daysUntil = normalizedDate.difference(normalizedNow).inDays;
    String finalDate;

    if (daysUntil < 0 && item is TaskModel) {
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
