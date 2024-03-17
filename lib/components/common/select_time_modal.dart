import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/task_tracker/time_checbox.dart';
import 'package:edupot/components/common/wheel_list.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectTimeModal extends StatefulWidget {
  final void Function(DateTime time) selectedTime;
  const SelectTimeModal({super.key, required this.selectedTime});

  @override
  State<SelectTimeModal> createState() => _SelectTimeModalState();
}

class _SelectTimeModalState extends State<SelectTimeModal> {
  int selected = 0;
  List<String> times = ["Selection", "14:00", "18:00", "8:00"];
  int hours = 12;
  int minutes = 30;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: SizedBox(
        height: height / 2 <= 475 ? 500 : height / 2,
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
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: times.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomCheckbox(
                    onClick: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    isSelected: selected == index,
                    content: times[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 185,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: EduPotColorTheme.primaryLightDark,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/metric_left.svg",
                    height: 165,
                  ),
                  Row(
                    children: [
                      WheelList(
                        onItemChanged: (int value) {
                          setState(() {
                            hours = value;
                          });
                        },
                        initialItem: selected == 0
                            ? 12
                            : int.parse(times[selected].split(":")[0]),
                        childCount: 24,
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      WheelList(
                        onItemChanged: (int value) {
                          setState(() {
                            minutes = value;
                          });
                        },
                        initialItem: selected == 0
                            ? 30
                            : int.parse(times[selected].split(":")[1]),
                        childCount: 60,
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/metric_right.svg",
                    height: 165,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainButton(
                onTap: () {
                  widget.selectedTime(DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    hours,
                    minutes,
                  ));
                  context.maybePop();
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
                  onPressed: () => context.maybePop(),
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
