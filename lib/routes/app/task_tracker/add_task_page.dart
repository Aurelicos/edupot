import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_field.dart';
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
                  formatText(title),
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
              placeholder: "",
              validatorText: "",
              textChanged: (String input) {
                setState(() {
                  if (input.isEmpty) {
                    title = "Task";
                  } else {
                    if (input.contains("\n")) {
                      title = input.replaceAll("\n", "");
                    } else {
                      title = input;
                    }
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  String formatText(String input) {
    String finalText = input;
    if (input.length > 17) {
      finalText = "${input.substring(0, 15)}...";
    }
    return finalText;
  }
}
