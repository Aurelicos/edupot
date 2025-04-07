import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/report_provider.dart';
import 'package:edupot/providers/study_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class QuizItem extends StatelessWidget {
  final AnswerType answerType;
  final String title;
  final int? time;
  final Color? customColor;
  final double height;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final double iconSize;
  final String? iconName;
  final String? reportId;
  final int? quizId;
  final bool showmenu;
  const QuizItem({
    super.key,
    required this.answerType,
    required this.title,
    required this.onPressed,
    this.reportId,
    this.quizId,
    this.iconName,
    this.height = 54,
    this.iconSize = 40,
    this.time,
    this.showmenu = false,
    this.customColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: showmenu
            ? () {
                final RenderBox renderBox =
                    context.findAncestorRenderObjectOfType<RenderBox>()!;
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
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      onTap: () {
                        if (reportId != null) {
                          final ReportProvider reportProvider =
                              Provider.of<ReportProvider>(context,
                                  listen: false);

                          reportProvider.deleteReport(
                              userProvider.user!.uid ?? "", reportId ?? "");
                        } else if (quizId != null) {
                          final StudyProvider studyProvider =
                              Provider.of<StudyProvider>(context,
                                  listen: false);

                          studyProvider.deleteQuiz(userProvider.user!.uid ?? "",
                              studyProvider.quizzes[quizId!].uid ?? "");
                        }
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
              }
            : null,
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
              "assets/icons/${iconName ?? answerType.name}.svg",
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
