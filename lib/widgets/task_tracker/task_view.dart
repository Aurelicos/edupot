import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskView extends StatelessWidget {
  final String title;
  final List<dynamic> array;
  final Color? color;
  const TaskView({
    super.key,
    this.color,
    required this.title,
    required this.array,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> sortedArray = List.from(array)
      ..sort((a, b) => a["finalDate"].compareTo(b["finalDate"]));

    return sortedArray.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                title,
                style: EduPotDarkTextTheme.headline4,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: sortedArray.length,
                itemBuilder: (_, i) {
                  var formattedDate = formatDate(sortedArray[i]["finalDate"]);
                  Color dateColor = getColorForDays(formattedDate["daysUntil"]);
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: EduPotColorTheme.primaryBlueDark,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/circle.svg",
                          color: color,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          sortedArray[i]["title"],
                          style: EduPotDarkTextTheme.headline2(1),
                        ),
                        const Spacer(),
                        Text(
                          formattedDate["finalDate"],
                          style: EduPotDarkTextTheme.headline2(1).copyWith(
                            color: dateColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
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
