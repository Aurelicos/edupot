import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizItem extends StatelessWidget {
  final AnswerType answerType;
  final String title;
  final int? time;
  final Color? customColor;
  final double height;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final double iconSize;
  const QuizItem({
    super.key,
    required this.answerType,
    required this.title,
    required this.onPressed,
    this.height = 54,
    this.iconSize = 40,
    this.time,
    this.customColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 20)),
          backgroundColor:
              WidgetStateProperty.all<Color>(EduPotColorTheme.primaryBlueDark),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/${answerType.name}.svg",
              height: iconSize,
              colorFilter: ColorFilter.mode(
                customColor ?? CreationContent.answerColors[answerType.index],
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: textStyle ?? EduPotDarkTextTheme.headline2(1),
            ),
            const Spacer(),
            time == null
                ? const SizedBox()
                : Text("${time}s", style: EduPotDarkTextTheme.headline2(1)),
          ],
        ),
      ),
    );
  }
}
