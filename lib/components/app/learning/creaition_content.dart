import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/routes/app/learning/create/create_quiz_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/common/radio_buttons.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreaitionContent {
  static const int steps = 3;

  static const Map<Enum, String> radioOptions = {
    AnswerType.quiz: "Quiz",
    AnswerType.trueFalse: "True or False",
    AnswerType.fillIn: "Type Answer",
  };

  static const List<Color> colors = [
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
        return _sharing();
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
      children: [
        const Text(
          "Add questions to your quiz",
          textAlign: TextAlign.center,
          style: EduPotDarkTextTheme.headline1,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: MainButton(
            onTap: () {
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
                                quizProvider.setType(
                                    0,
                                    radioOptions.keys
                                        .toList()[selected]
                                        .toString());
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
            },
            isBorderOnly: true,
            child: Text(
              "Add Question",
              style: EduPotDarkTextTheme.headline2(1),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _sharing() {
    return const Placeholder();
  }
}
