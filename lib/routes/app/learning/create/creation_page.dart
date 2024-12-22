import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/components/app/learning/quiz_creation_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/providers/step_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/learning/learning_page.dart';
import 'package:edupot/services/learning.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/indicator.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  @override
  Widget build(BuildContext context) {
    final step = context.watch<StepProvider>();
    final QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return PrimaryScaffold(
      navBar: false,
      onPressed: quizProvider.questions.length > 4
          ? () {
              CreationContent.addQuestion(context);
            }
          : null,
      buttonMargin: const EdgeInsets.only(bottom: 84),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              header(context),
              const SizedBox(height: 25),
              if (step.selectedIndex == 2)
                const Text(
                  "Add questions to your quiz",
                  textAlign: TextAlign.center,
                  style: EduPotDarkTextTheme.headline1,
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CreationContent.getContent(
                        step.selectedIndex,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 25,
                      top: quizProvider.questions.length > 4 &&
                              step.selectedIndex == 2
                          ? 25
                          : 0),
                  child: MainButton(
                    onTap: () => setState(() {
                      if (step.selectedIndex < CreationContent.steps) {
                        step.selectedIndex++;
                      } else {
                        if (quizProvider.questions.isNotEmpty) {
                          LearningService learningService = LearningService();
                          final quizModel = QuizModel(
                            title: quizProvider.title,
                            isPublic: quizProvider.isPublic,
                            questions: quizProvider.questions,
                            answerTypes: quizProvider.answerTypes
                                .map((type) => type.toString().split('.').last)
                                .toList(),
                            answers: quizProvider.answers,
                            correctAnswers: quizProvider.correctAnswers,
                            times: quizProvider.times,
                          );
                          learningService.addQuiz(
                              userProvider.user!.uid ?? "", quizModel);
                          Get.off(const LearningPage());
                        } else {
                          QuizCreationContent.showErrorDialog(
                              "Please add at least one question", context);
                        }
                      }
                    }),
                    child: Text(
                        step.selectedIndex < CreationContent.steps
                            ? "Next"
                            : "Save",
                        style: EduPotDarkTextTheme.headline2(1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    final step = context.watch<StepProvider>();
    final QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => step.selectedIndex > 1
              ? setState(() => step.selectedIndex--)
              : Get.back(),
          child: const Icon(Icons.arrow_back_rounded,
              size: 32, color: Colors.white),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Step ${step.selectedIndex}/${CreationContent.steps}',
                style: EduPotDarkTextTheme.smallHeadline,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Indicator(
                  base: CreationContent.steps,
                  progression: step.selectedIndex,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (quizProvider.questions.isNotEmpty) {
              LearningService learningService = LearningService();
              final quizModel = QuizModel(
                title: quizProvider.title,
                isPublic: quizProvider.isPublic,
                questions: quizProvider.questions,
                answerTypes: quizProvider.answerTypes
                    .map((type) => type.toString().split('.').last)
                    .toList(),
                answers: quizProvider.answers,
                correctAnswers: quizProvider.correctAnswers,
                times: quizProvider.times,
              );
              learningService.addQuiz(userProvider.user!.uid ?? "", quizModel);
              Get.off(const LearningPage());
            } else {
              QuizCreationContent.showErrorDialog(
                  "Please add at least one question", context);
            }
          },
          child: const Text(
            "Save",
            style: EduPotDarkTextTheme.headline3,
          ),
        ),
      ],
    );
  }
}
