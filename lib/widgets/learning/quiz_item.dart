import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizItem extends StatelessWidget {
  final AnswerType answerType;
  final String title;
  final int time;
  final void Function() onPressed;
  const QuizItem({
    super.key,
    required this.answerType,
    required this.title,
    required this.onPressed,
    this.time = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 54,
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
              height: 40,
              colorFilter: ColorFilter.mode(
                CreationContent.answerColors[answerType.index],
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: EduPotDarkTextTheme.headline2(1),
            ),
            const Spacer(),
            Text("${time}s", style: EduPotDarkTextTheme.headline2(1)),
          ],
        ),
      ),
    );
  }
}
