import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/services/entry.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class TaskView extends StatelessWidget {
  final Color? color;
  final List<dynamic> entry;
  final bool isTask;
  final bool? returnBack;
  const TaskView({
    super.key,
    this.color,
    this.isTask = false,
    this.returnBack = false,
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

    bool isDone = false;

    final userProvider = context.watch<UserProvider>();
    final entryProvider = context.watch<EntryProvider>();

    if (item is ExamModel) {
      title = item.title;
      finalDate = item.finalDate;
    } else if (item is TaskModel) {
      title = item.title;
      finalDate = item.finalDate;
      isDone = item.done ?? false;
    } else {
      throw Exception('Unknown item type');
    }

    Map<String, dynamic> formattedDate = formatDate(finalDate, item);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 54,
      child: Builder(
        builder: (BuildContext context) {
          return TextButton(
            onLongPress: () {
              final RenderBox renderBox =
                  context.findRenderObject() as RenderBox;
              final Offset offset = renderBox.localToGlobal(Offset.zero);

              showMenu(
                context: context,
                elevation: 0,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width - offset.dx,
                  offset.dy,
                  offset.dx,
                  MediaQuery.of(context).size.height - offset.dy,
                ),
                color: EduPotColorTheme.primaryBlueDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                shadowColor: Colors.transparent,
                items: [
                  if (item is TaskModel)
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      onTap: () {
                        setDone(item.id ?? "", !isDone,
                            userProvider: userProvider,
                            entryProvider: entryProvider);
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/${isDone ? "uncheckmark" : "checkmark"}.svg",
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                  EduPotColorTheme.projectBlue,
                                  BlendMode.srcIn),
                            ),
                            const SizedBox(width: 10),
                            Text(isDone ? "Undone" : "Done",
                                style: EduPotDarkTextTheme.correctText()),
                          ],
                        ),
                      ),
                    ),
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      deleteAndFetchEntries(
                        item.id,
                        item is ExamModel ? "exam" : "task",
                        userProvider: userProvider,
                        entryProvider: entryProvider,
                        assigned:
                            item is TaskModel ? item.assignedProject : null,
                      );
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/bin.svg",
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text("Remove",
                              style: EduPotDarkTextTheme.correctText(
                                  color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            onPressed: () {
              if (item is ExamModel) {
                Get.to(AddTaskPage(
                    selectedCategory: 0, exam: item, returnBack: returnBack));
              } else if (item is TaskModel) {
                Get.to(AddTaskPage(
                    selectedCategory: 1, task: item, returnBack: returnBack));
              }
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20)),
              backgroundColor: WidgetStateProperty.all<Color>(
                  EduPotColorTheme.primaryBlueDark),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: Row(
              children: [
                isDone
                    ? SvgPicture.asset(
                        "assets/icons/check.svg",
                        width: 20,
                        height: 20,
                      )
                    : SvgPicture.asset(
                        "assets/icons/circle.svg",
                        width: 20,
                        height: 20,
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
          );
        },
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

  void deleteAndFetchEntries(
    String id,
    String type, {
    required UserProvider userProvider,
    required EntryProvider entryProvider,
    DocumentReference? assigned,
  }) {
    EntryService()
        .deleteEntry(userProvider.user!.uid ?? "", id, type, assigned)
        .then((value) {
      entryProvider.fetchEntries(userProvider.user!.uid ?? "",
          forceRefresh: true);
    });
  }

  void setDone(
    String id,
    bool done, {
    required UserProvider userProvider,
    required EntryProvider entryProvider,
  }) {
    EntryService().markDone(userProvider.user!.uid ?? "", id, done: done).then(
        (value) => entryProvider.fetchEntries(userProvider.user!.uid ?? "",
            forceRefresh: true));
  }
}
