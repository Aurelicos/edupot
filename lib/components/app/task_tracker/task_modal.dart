import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskModal extends StatelessWidget {
  final void Function(int index)? onPressed;

  const TaskModal({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 65,
                height: 6,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: constraints.maxHeight * 0.8 < 350
                  ? 350
                  : constraints.maxHeight * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: EduPotColorTheme.primaryLightDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildModalButtons(
                      context,
                      "assets/icons/check_simple.svg",
                      "Add single task",
                      "Create and manage a specific task, setting deadlines and priorities.",
                      () => onPressed!(1)),
                  const SizedBox(
                    height: 20,
                  ),
                  buildModalButtons(
                    context,
                    "assets/icons/note.svg",
                    "Add upcoming exam",
                    "Enter details of an upcoming exam including date, subject and notes.",
                    () => onPressed!(0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildModalButtons(
                    context,
                    "assets/icons/rocket.svg",
                    "Add full project",
                    "Plan out a complete project, breaking it down into task, milestones and deadlines.",
                    () => onPressed!(2),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget buildModalButtons(BuildContext context, String iconPath, String title,
      String description, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  gradient: EduPotColorTheme.darkGradient,
                  shape: BoxShape.circle,
                ),
              ),
              SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: EduPotDarkTextTheme.headline3.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: EduPotDarkTextTheme.headline2(0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
