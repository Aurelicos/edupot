import 'package:edupot/components/app/calendar/calendar.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/task_modal.dart';
import 'package:edupot/providers/day_provider.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/routes/app/task_tracker/search_overlay_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);

    return PrimaryScaffold(
      onPressed: () => modal(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Calendar', style: EduPotDarkTextTheme.headline1),
                  SizedBox(
                    width: 45,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(SearchOverlayPage(
                          items: [
                            ...projectProvider.projects,
                            ...entryProvider.exams,
                            ...entryProvider.tasks
                          ],
                        ));
                      },
                      child: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                  )
                ],
              ),
              const Expanded(child: Calendar()),
            ],
          ),
        ),
      ),
    );
  }

  Future modal() {
    DayProvider dayProvider = Provider.of<DayProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      backgroundColor: EduPotColorTheme.primaryDark,
      builder: (BuildContext context) {
        return TaskModal(onPressed: (int index) {
          Navigator.of(context).pop();
          Get.to(AddEntryPage(
            selectedCategory: index,
            initDate: DateTime(
              dayProvider.selectedDate.year,
              dayProvider.selectedDate.month,
              dayProvider.selectedDate.day,
              12,
              30,
            ),
            returnBack: true,
          ));
        });
      },
    );
  }
}
