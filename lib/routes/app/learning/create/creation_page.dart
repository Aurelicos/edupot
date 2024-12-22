import 'package:edupot/components/app/learning/creation_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/providers/step_provider.dart';
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
                    onTap: () => setState(() =>
                        step.selectedIndex < CreationContent.steps
                            ? step.selectedIndex++
                            : null),
                    child:
                        Text("Next", style: EduPotDarkTextTheme.headline2(1)),
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
          onTap: () => Get.back(),
          child: const Text(
            "Save",
            style: EduPotDarkTextTheme.headline3,
          ),
        ),
      ],
    );
  }
}
