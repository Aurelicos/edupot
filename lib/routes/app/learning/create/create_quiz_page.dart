import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/components/app/learning/quiz_creation_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/common/select_time_modal.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/routes/app/learning/create/creation_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_button.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateQuizPage extends StatefulWidget {
  final int? index;
  final int? existingIndex;

  const CreateQuizPage({super.key, this.index, this.existingIndex});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  DateTime date = DateTime(0, 0, 0, 0, 0, 10, 0, 0);
  String _question = '';
  final List<String> _answers = ['', '', '', ''];
  final List<String> _correctAnswers = [''];
  List<bool> value = List<bool>.generate(4, (index) => false, growable: false);

  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    if (widget.existingIndex != null) {
      _initializeExistingQuiz(quizProvider);
    }
  }

  void _initializeExistingQuiz(QuizProvider quizProvider) {
    _question = quizProvider.questions[widget.existingIndex!];
    _answers.setAll(0, quizProvider.answers[widget.existingIndex!]);
    _correctAnswers
      ..clear()
      ..addAll(quizProvider.correctAnswers[widget.existingIndex!]);
    value = List<bool>.generate(
      4,
      (index) =>
          _answers[index].isNotEmpty &&
          _correctAnswers.contains(_answers[index]),
      growable: false,
    );
    date = DateTime(0, 0, 0, 0, 0, quizProvider.times[widget.existingIndex!]);
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return PrimaryScaffold(
      navBar: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.045),
                      QuizCreationContent.buildHeader(widget.index != null
                          ? widget.index ?? 0
                          : widget.existingIndex != null
                              ? AnswerType.values.indexOf(quizProvider
                                  .answerTypes[widget.existingIndex!])
                              : 0),
                      const SizedBox(height: 25),
                      QuizCreationContent.buildQuestionInput(
                          initialValue: _question,
                          onChanged: (value) =>
                              setState(() => _question = value)),
                      const SizedBox(height: 15),
                      if (widget.index != null && widget.index! <= 1 ||
                          (widget.existingIndex != null &&
                              quizProvider.answerTypes[widget.existingIndex!] !=
                                  AnswerType.fillIn))
                        _buildAnswersInput(widget.index == 1 ||
                            (widget.existingIndex != null &&
                                quizProvider
                                        .answerTypes[widget.existingIndex!] ==
                                    AnswerType.trueFalse))
                      else
                        _buildFillInAnswer(),
                      const SizedBox(height: 25),
                      _buildTimeSelector(),
                    ],
                  ),
                ),
              ),
              _buildSubmitButton(quizProvider),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFillInAnswer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: EduPotColorTheme.greenGradient,
      ),
      child: TextFormField(
        initialValue: _answers[0],
        decoration: const InputDecoration(
          hintText: "Add answer",
          hintStyle: EduPotDarkTextTheme.smallHeadline,
          border: InputBorder.none,
        ),
        style: EduPotDarkTextTheme.smallHeadline,
        textAlign: TextAlign.center,
        onChanged: (value) => setState(() {
          _answers[0] = value;
          _correctAnswers[0] = value;
        }),
      ),
    );
  }

  Widget _buildAnswersInput(bool isTrueFalse) {
    if (isTrueFalse) {
      _answers.setAll(0, ["True", "False"]);
    }
    return GridView.builder(
      itemCount: isTrueFalse ? 2 : 4,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 5,
        childAspectRatio: 1.75,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CreationContent.answerColors[index],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    initialValue: isTrueFalse
                        ? ["True", "False"][index]
                        : _answers[index],
                    decoration: InputDecoration(
                      hintText: isTrueFalse
                          ? ["True", "False"][index]
                          : "Answer ${index + 1}",
                      hintStyle: EduPotDarkTextTheme.smallHeadline,
                      border: InputBorder.none,
                    ),
                    readOnly: isTrueFalse,
                    style: EduPotDarkTextTheme.smallHeadline,
                    textAlign: TextAlign.center,
                    onChanged: (value) =>
                        setState(() => _answers[index] = value),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.75,
                child: Switch(
                  value: value[index],
                  onChanged: _answers[index].isEmpty && !isTrueFalse
                      ? null
                      : (switchValue) => setState(() {
                            if (isTrueFalse) {
                              value = List<bool>.generate(
                                  2, (i) => i == index && switchValue,
                                  growable: false);
                              _correctAnswers.clear();
                              if (switchValue) {
                                _correctAnswers.add(_answers[index]);
                              }
                            } else {
                              value[index] = switchValue;
                              if (switchValue) {
                                _correctAnswers.add(_answers[index]);
                              } else {
                                _correctAnswers.remove(_answers[index]);
                              }
                            }
                          }),
                  activeColor: Colors.white,
                  activeTrackColor: EduPotColorTheme.projectBlue,
                  inactiveTrackColor: EduPotColorTheme.primaryDark,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeSelector() {
    return InputButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: EduPotColorTheme.primaryDark,
          builder: (context) => SelectTimeModal(
            title: "Choose length of quiz",
            oldTime: date,
            showSecondsOnly: true,
            selectedTime: (selectedTime) {
              setState(() {
                date = (selectedTime.minute >= 1)
                    ? DateTime(0, 0, 0, 0, 0, 59)
                    : selectedTime;
              });
            },
          ),
        );
      },
      asset: "assets/icons/clock_simple.svg",
      text: "${date.second}s",
    );
  }

  Widget _buildSubmitButton(QuizProvider quizProvider) {
    return MainButton(
      onTap: () {
        if (_question.isEmpty) {
          QuizCreationContent.showErrorDialog(
              "Question title cannot be empty.", context);
          return;
        }

        final nonEmptyAnswers =
            _answers.where((answer) => answer.isNotEmpty).toList();
        if (nonEmptyAnswers.isEmpty) {
          QuizCreationContent.showErrorDialog(
              "Answers cannot be empty.", context);
          return;
        }

        if (_correctAnswers.isEmpty ||
            _correctAnswers.every((answer) => answer.isEmpty)) {
          QuizCreationContent.showErrorDialog(
              "There must be at least one correct answer.", context);
          return;
        }
        if (widget.existingIndex != null) {
          quizProvider.updateQuestion(
            widget.existingIndex!,
            question: _question,
            answerOptions: nonEmptyAnswers,
            correctAnswers: _correctAnswers,
            time: date.second,
          );
        } else {
          quizProvider.addQuestion(
            _question,
            AnswerType.values[widget.index!],
            nonEmptyAnswers,
            _correctAnswers,
            date.second,
          );
        }
        Get.off(const CreationPage());
      },
      child: Text("Submit", style: EduPotDarkTextTheme.headline2(1)),
    );
  }
}
