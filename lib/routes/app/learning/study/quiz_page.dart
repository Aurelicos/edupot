import 'dart:async';

import 'package:edupot/components/app/learning/quiz_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/study_provider.dart';
import 'package:edupot/routes/app/learning/study/summary_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/circular_timer.dart';
import 'package:edupot/widgets/learning/indicator.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  final int quizId;
  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int quizIndex = 1;
  String typeInAnswer = '';
  int remainingTime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    final studyProvider = Provider.of<StudyProvider>(context, listen: false);
    final quiz = studyProvider.quizzes[widget.quizId];
    final currentTime = quiz.times[quizIndex - 1];

    setState(() {
      remainingTime = currentTime;
    });

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _stopTimer();
        _evaluateQuiz(
          studyProvider.quizzes[widget.quizId].correctAnswers,
          "",
          correctAnswer: studyProvider
              .quizzes[widget.quizId].correctAnswers[quizIndex - 1][0],
          quizzes: studyProvider.quizzes[widget.quizId].questions,
          onSubmit: () {
            Get.back();
            setState(() {
              if (quizIndex <
                  studyProvider.quizzes[widget.quizId].questions.length) {
                quizIndex++;
                _startTimer();
              } else {
                Get.to(const SummaryPage());
              }
            });
          },
        );
      }
    });
  }

  void _stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final studyProvider = Provider.of<StudyProvider>(context, listen: true);
    final quiz = studyProvider.quizzes[widget.quizId];
    final quizzes = quiz.questions;
    final answerTypes = quiz.answerTypes;
    final correctAnswers = quiz.correctAnswers;
    final AnswerType answerType = AnswerType.values.firstWhere(
      (e) => e.toString() == 'AnswerType.${answerTypes[quizIndex - 1]}',
    );

    final currentTime = quiz.times[quizIndex - 1];

    return PrimaryScaffold(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_rounded,
                        size: 32, color: Colors.white),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Question $quizIndex/${quizzes.length}',
                          style: EduPotDarkTextTheme.smallHeadline,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Indicator(
                            base: quizzes.length,
                            progression: quizIndex,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: CircularTimer(
                  remainingTime: remainingTime,
                  totalTime: currentTime,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromARGB(255, 62, 67, 124),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    quizzes[quizIndex - 1],
                    style: EduPotDarkTextTheme.smallHeadline.copyWith(
                        fontSize: 20,
                        color: Colors.white.withValues(alpha: 0.85),
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: QuizContent.getContent(
                  answerType,
                  studyProvider.quizzes[widget.quizId],
                  quizIndex: quizIndex,
                  onChanged: (value) {
                    if (answerType == AnswerType.fillIn) {
                      setState(() {
                        typeInAnswer = value;
                      });
                    } else {
                      String correctAnswer;
                      if (answerType == AnswerType.quiz) {
                        correctAnswer =
                            correctAnswers[quizIndex - 1].join(', ');
                      } else {
                        correctAnswer = correctAnswers[quizIndex - 1][0];
                      }

                      _evaluateQuiz(
                        correctAnswers,
                        value,
                        correctAnswer: correctAnswer,
                        quizzes: quizzes,
                        onSubmit: () {
                          Get.back();
                          setState(() {
                            if (quizIndex < quizzes.length) {
                              quizIndex++;
                              _startTimer();
                            } else {
                              Get.to(const SummaryPage());
                            }
                          });
                        },
                      );
                    }
                  },
                ),
              ),
              if (answerType == AnswerType.fillIn)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: MainButton(
                        onTap: () {
                          final correctAnswer =
                              correctAnswers[quizIndex - 1][0];

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Vyhodnocení odpovědi'),
                              content: Text(
                                typeInAnswer.trim().toLowerCase() ==
                                        correctAnswer.trim().toLowerCase()
                                    ? 'Správně!'
                                    : 'Špatně. Správná odpověď je: $correctAnswer',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      typeInAnswer = '';
                                      if (quizIndex < quizzes.length) {
                                        quizIndex++;
                                        _startTimer();
                                      } else {
                                        Get.to(const SummaryPage());
                                      }
                                    });
                                  },
                                  child: const Text('Next'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Next',
                          style: EduPotDarkTextTheme.headline2(1),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _evaluateQuiz(List<List<String>> correctAnswers, String value,
      {required String correctAnswer,
      required List<String> quizzes,
      void Function()? onSubmit}) {
    _stopTimer();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: const BoxDecoration(
            color: EduPotColorTheme.primaryDark,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                correctAnswers[quizIndex - 1].contains(value)
                    ? 'Correct!'
                    : 'Incorrect!',
                style: EduPotDarkTextTheme.smallHeadline.copyWith(
                  color: correctAnswers[quizIndex - 1].contains(value)
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              Text(
                'The correct answer${correctAnswers[quizIndex - 1].length > 1 ? "s are" : " is"}: $correctAnswer',
                style: EduPotDarkTextTheme.headline2(1),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: onSubmit,
                child: Text(
                  'Next',
                  style: EduPotDarkTextTheme.headline2(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
