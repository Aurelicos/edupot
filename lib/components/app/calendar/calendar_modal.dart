import 'package:edupot/components/app/calendar/calendar.dart';
import 'package:edupot/providers/day_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CalendarModal extends StatelessWidget {
  final void Function(DateTime time) selectedTime;
  const CalendarModal({super.key, required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    DayProvider dayProvider = Provider.of<DayProvider>(context, listen: false);

    return SingleChildScrollView(
      child: SizedBox(
        height: height / 2 <= 550 ? 600 : height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Select Time",
                style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 24),
              ),
            ),
            const Expanded(
              child: Calendar(simpleView: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainButton(
                onTap: () {
                  selectedTime(dayProvider.selectedDate);
                  Get.back();
                },
                child: Text(
                  "Done",
                  style: EduPotDarkTextTheme.headline2(1),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Cancel",
                    style: EduPotDarkTextTheme.headline2(0.4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
