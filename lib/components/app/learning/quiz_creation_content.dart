import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizCreationContent {
  static Widget buildHeader(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_rounded,
              size: 32, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          CreationContent.radioOptions.values.toList()[index],
          style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 28),
        ),
      ],
    );
  }

  static Widget buildQuestionInput(
      {required String initialValue, required Function(String) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromARGB(255, 62, 67, 124),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: "Add question",
            hintStyle: EduPotDarkTextTheme.smallHeadline.copyWith(
              fontSize: 20,
              color: Colors.white.withOpacity(0.85),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            border: InputBorder.none,
          ),
          style: EduPotDarkTextTheme.smallHeadline.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
          onChanged: (value) => onChanged(value),
        ),
      ),
    );
  }

  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: EduPotDarkTextTheme.smallHeadline,
        ),
        backgroundColor: EduPotColorTheme.primaryDark,
        actions: [
          TextButton(
            child: Text("OK", style: EduPotDarkTextTheme.headline2(1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
