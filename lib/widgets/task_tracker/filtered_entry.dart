import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FilteredEntry extends StatelessWidget {
  final void Function()? onChange;
  final String name;
  final String searchedText;
  final dynamic item;

  const FilteredEntry({
    super.key,
    required this.onChange,
    required this.name,
    required this.searchedText,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle normalStyle = EduPotDarkTextTheme.headline2(0.45);
    final TextStyle boldStyle =
        EduPotDarkTextTheme.headline2(1).copyWith(fontWeight: FontWeight.bold);

    final List<TextSpan> spans =
        _buildTextSpans(name, searchedText, normalStyle, boldStyle);

    return InkWell(
      onTap: () {
        Get.offAll(AddTaskPage(
          selectedCategory: _getSelectedCategory(),
          exam: item is ExamModel ? item : null,
          task: item is TaskModel ? item : null,
          project: item is ProjectModel ? item : null,
        ));
      },
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: ShapeDecoration(
                      gradient: _getGradient(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/circle.svg',
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    _getColor(),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            RichText(
              text: TextSpan(
                style: normalStyle,
                children: spans,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getSelectedCategory() {
    if (item is ExamModel) return 0;
    if (item is TaskModel) return 1;
    if (item is ProjectModel) return 2;
    return -1;
  }

  Gradient _getGradient() {
    if (item is TaskModel) {
      return EduPotColorTheme.brighterPinkGradient;
    } else if (item is ExamModel) {
      return EduPotColorTheme.brighterOrangeGradient;
    } else {
      return EduPotColorTheme.brighterBlueGradient;
    }
  }

  Color _getColor() {
    if (item is TaskModel) {
      return EduPotColorTheme.tasksPurple;
    } else if (item is ExamModel) {
      return EduPotColorTheme.examsOrange;
    } else {
      return EduPotColorTheme.projectBlue;
    }
  }

  List<TextSpan> _buildTextSpans(String text, String searchedText,
      TextStyle normalStyle, TextStyle boldStyle) {
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfSearchedText;

    while ((indexOfSearchedText =
            text.toLowerCase().indexOf(searchedText.toLowerCase(), start)) !=
        -1) {
      if (indexOfSearchedText != start) {
        spans.add(TextSpan(
            text: text.substring(start, indexOfSearchedText),
            style: normalStyle));
      }
      spans.add(TextSpan(
          text: text.substring(
              indexOfSearchedText, indexOfSearchedText + searchedText.length),
          style: boldStyle));
      start = indexOfSearchedText + searchedText.length;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: normalStyle));
    }

    return spans;
  }
}
