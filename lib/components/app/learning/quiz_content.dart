import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class QuizContent {
  static Widget getContent(AnswerType answerType, QuizModel quizModel,
      {required int quizIndex,
      required void Function(String value) onChanged}) {
    switch (answerType) {
      case AnswerType.quiz || AnswerType.trueFalse:
        return _buildQuiz(quizModel, quizIndex, onChanged);
      case AnswerType.fillIn:
        return _buildFillIn(quizModel, onChanged);
    }
  }

  static Widget _buildQuiz(QuizModel studyProvider, int quizIndex,
      void Function(String value) onChange) {
    return GridView.builder(
      itemCount: studyProvider.answers[quizIndex - 1].length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 5,
        childAspectRatio: 1.75,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TextButton(
          onPressed: () {
            onChange(studyProvider.answers[quizIndex - 1][index]);
          },
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: CreationContent.answerColors[index],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  studyProvider.answers[quizIndex - 1][index],
                  style: EduPotDarkTextTheme.smallHeadline,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildFillIn(
      QuizModel quizModel, void Function(String value) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: EduPotColorTheme.greenGradient,
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Add answer",
              hintStyle: EduPotDarkTextTheme.smallHeadline,
              border: InputBorder.none,
            ),
            style: EduPotDarkTextTheme.smallHeadline,
            textAlign: TextAlign.center,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
