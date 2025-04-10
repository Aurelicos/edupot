import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/utils/common/time_format.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/hexagon.dart';
import 'package:edupot/utils/common/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

class ProjectWidget extends StatelessWidget {
  final List<ProjectModel> itemArray;
  final List<TaskModel> finishedTasks;
  const ProjectWidget(
      {super.key, required this.itemArray, this.finishedTasks = const []});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          for (int index = 0; index < itemArray.length; index++)
            Container(
              margin: index > 0 ? const EdgeInsets.only(top: 20) : null,
              child: TextButton(
                onPressed: () => Get.to(AddEntryPage(
                  selectedCategory: 2,
                  project: itemArray[index],
                )),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.transparent),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: index > 0
                        ? EduPotColorTheme.purpleCardGradient
                        : EduPotColorTheme.lightGrayCardGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Hexagon(
                              title: itemArray[index].iconTitle,
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              itemArray[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.2),
                                height: 32,
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
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
                              formatTime(itemArray[index].finalDate),
                              style: EduPotDarkTextTheme.headline2(0.6),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset(
                              "assets/icons/check.svg",
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${itemArray[index].tasks.length} Tasks",
                              style: EduPotDarkTextTheme.headline2(0.6),
                            ),
                          ],
                        ),
                        indicator(
                          itemArray[index].tasks.length,
                          finishedTasks.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
