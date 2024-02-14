import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:edupot/widgets/task_tracker/task_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = "Task";

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      navBar: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.085,
            ),
            InkWell(
              onTap: () => context.popRoute(),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formatText(
                    title,
                    context,
                    EduPotDarkTextTheme.headline1.copyWith(fontSize: 32),
                    MediaQuery.of(context).size.width * 0.75,
                  ),
                  style: EduPotDarkTextTheme.headline1.copyWith(
                    fontSize: 32,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/circle_big.svg",
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    EduPotColorTheme.examsOrange,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              headline: "Title",
              placeholder: "My Task",
              validatorText: "",
              textChanged: (String input) {
                setState(() {
                  if (input.isEmpty) {
                    title = "Task";
                  } else {
                    title = input;
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              headline: "Description",
              placeholder:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris gravida urna purus, eget mattis eros cursus lorem ipsum...",
              height: 100,
              maxLines: 3,
              textChanged: (String input) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TaskDropdown<int>(
              onChange: (int index) => print("index: $index"),
              gradient: EduPotColorTheme.mainItemGradient,
              dropdownButtonStyle: TaskDropdownButtonStyle(
                height: 56,
                width: double.infinity,
                elevation: 1,
                gradient: EduPotColorTheme.mainItemGradient,
                borderRadius: BorderRadius.circular(7),
              ),
              dropdownStyle: TaskDropdownStyle(
                elevation: 1,
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              items: [
                '📝 Exam',
                '💻 Task',
                '🗂️ Project',
              ]
                  .asMap()
                  .entries
                  .map(
                    (item) => TaskDropdownItem<int>(
                      gradient: EduPotColorTheme.mainItemGradient,
                      value: item.key + 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          item.value,
                          style: EduPotDarkTextTheme.headline2(1),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "📝 Exam",
                  style: EduPotDarkTextTheme.headline2(1),
                ),
              ),
            ),
            const Spacer(),
            MainButton(
              onTap: () {},
              child: Text(
                "Submit",
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String formatText(
    String input,
    BuildContext context,
    TextStyle textStyle,
    double maxWidth,
  ) {
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: input, style: textStyle),
    );

    painter.layout();

    if (painter.width > maxWidth) {
      for (int i = input.length; i > 0; i--) {
        painter.text =
            TextSpan(text: "${input.substring(0, i)}...", style: textStyle);
        painter.layout();

        if (painter.width <= maxWidth) {
          return "${input.substring(0, i)}...";
        }
      }
    }

    return input;
  }
}
