import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/routes/app/learning/create/create_quiz_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/common/radio_buttons.dart';
import 'package:edupot/widgets/learning/quiz_item.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreationContent {
  static const int steps = 3;

  static const Map<Enum, String> radioOptions = {
    AnswerType.quiz: "Quiz",
    AnswerType.trueFalse: "True or False",
    AnswerType.fillIn: "Type Answer",
  };

  static const List<Color> answerColors = [
    Color(0xFFe31b3f),
    Color(0xFF0640bb),
    Color(0xFFd99f00),
    Color(0xFF26890a),
  ];

  static Widget getContent(
    int index, {
    required BuildContext context,
  }) {
    switch (index) {
      case 1:
        return _title(context);
      case 2:
        return _addQuizes(context);
      case 3:
        return _sharing(context);
      default:
        return const SizedBox();
    }
  }

  static Widget _title(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Choose a title for your quiz",
            textAlign: TextAlign.center,
            style: EduPotDarkTextTheme.headline1,
          ),
          InputField(
            headline: "Title",
            placeholder: "Enter title",
            textChanged: (value) {
              QuizProvider quizProvider =
                  Provider.of<QuizProvider>(context, listen: false);
              quizProvider.setTitle(value.isEmpty ? "Untitled" : value);
            },
          ),
        ],
      ),
    );
  }

  static Widget _addQuizes(BuildContext context) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizProvider.questions.length,
                itemBuilder: (context, index) {
                  final question = quizProvider.questions[index];
                  return QuizItem(
                    answerType: quizProvider.answerTypes[index],
                    title: question,
                    time: quizProvider.times[index],
                    onPressed: () {
                      Get.to(CreateQuizPage(
                        existingIndex: index,
                      ));
                    },
                  );
                },
              );
            },
          ),
        ),
        if (quizProvider.questions.length <= 4) ..._addQuestionButton(context)
      ],
    );
  }

  static Widget _sharing(BuildContext context) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Change visibility of your quiz",
            textAlign: TextAlign.center,
            style: EduPotDarkTextTheme.headline1,
          ),
          TextButton(
            onPressed: () {
              quizProvider.setIsPublic(!quizProvider.isPublic);
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.transparent),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: EduPotColorTheme.mainItemGradient,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Switch(
                      value: quizProvider.isPublic,
                      onChanged: (value) {
                        quizProvider.setIsPublic(value);
                      },
                      activeColor: Colors.white,
                      activeTrackColor: EduPotColorTheme.projectBlue,
                      inactiveTrackColor: EduPotColorTheme.primaryDark,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      quizProvider.isPublic ? "Public" : "Private",
                      style: EduPotDarkTextTheme.headline2(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static List<Widget> _addQuestionButton(BuildContext context) {
    return [
      const SizedBox(height: 15),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: MainButton(
          onTap: () {
            addQuestion(context);
          },
          isBorderOnly: true,
          child: Text(
            "Add Question",
            style: EduPotDarkTextTheme.headline2(1),
          ),
        ),
      ),
    ];
  }

  static addQuestion(BuildContext context) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: EduPotColorTheme.primaryDark,
      builder: (context) {
        int selectedIndex = 0;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  const Text(
                    "Select type of quiz",
                    style: EduPotDarkTextTheme.smallHeadline,
                  ),
                  const SizedBox(height: 15),
                  RadioButtons(
                    count: 3,
                    options: radioOptions.values.toList(),
                    onChanged: (selected) {
                      setState(() {
                        selectedIndex = selected;
                      });
                      quizProvider.setType(quizProvider.questions.length,
                          AnswerType.values[selected]);
                    },
                  ),
                  const Spacer(),
                  MainButton(
                    onTap: () {
                      Get.to(CreateQuizPage(
                        index: selectedIndex,
                      ));
                    },
                    child: Text(
                      "Add",
                      style: EduPotDarkTextTheme.headline2(1),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
