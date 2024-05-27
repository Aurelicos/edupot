import 'package:edupot/models/projects/project.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/utils/common/time_format.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

class ListProject extends StatelessWidget {
  final List<ProjectModel> itemArray;
  const ListProject({super.key, required this.itemArray});

  @override
  Widget build(BuildContext context) {
    final List<LinearGradient> gradientList = [
      EduPotColorTheme.purpleCardGradient,
      EduPotColorTheme.lightGrayCardGradient,
      EduPotColorTheme.darkGrayCardGradient,
      EduPotColorTheme.mainBlueGradient(opacity: 0.55),
    ];

    return ListView.builder(
      itemCount: itemArray.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) {
        return Container(
          margin: const EdgeInsets.only(
            right: 16,
            top: 15,
          ),
          child: TextButton(
            onPressed: () =>
                Get.to(AddTaskPage(selectedCategory: 2, project: itemArray[i])),
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.transparent),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: gradientList[i % 4],
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                width: 225,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 55,
                          width: 5,
                          decoration: BoxDecoration(
                            gradient: EduPotColorTheme.orangeGradient,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 55,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formatTitle(itemArray[i].name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/clock.svg",
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              formatTime(itemArray[i].finalDate),
                              style:
                                  EduPotDarkTextTheme.headline2(0.6).copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/check.svg",
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${itemArray[i].finished} out of ${itemArray[i].tasks.length}",
                              style: EduPotDarkTextTheme.headline3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String formatTitle(String title) {
    List<String> splitted = title.split(" ");
    String finalTitle = "";
    if (splitted.length == 1 && title.length >= 15) {
      return "${title.substring(0, 12)}...";
    }
    for (int i = 0; i < splitted.length; i++) {
      if (splitted[i].length >= 15) {
        finalTitle += i == 0
            ? "${splitted[i].substring(0, 12)}... "
            : " ${splitted[i].substring(0, 12)}... ";
      } else {
        finalTitle += i == 0 ? splitted[i] : " ${splitted[i]}";
      }
    }
    return finalTitle;
  }
}
