import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/study_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/learning/create/creation_page.dart';
import 'package:edupot/routes/app/learning/learning_page.dart';
import 'package:edupot/routes/app/learning/study/quiz_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final studyProvider = context.read<StudyProvider>();

      studyProvider
          .fetchQuizzes(context.read<UserProvider>().user!.uid ?? "",
              forceRefresh: true)
          .then(
        (value) {
          if (value == false && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to fetch quizzes'),
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final studyProvider = Provider.of<StudyProvider>(context, listen: true);
    return PrimaryScaffold(
      navBar: false,
      onPressed: () => Get.to(const CreationPage()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Get.to(const LearningPage()),
                    child: const Icon(Icons.arrow_back_rounded,
                        size: 32, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'Study',
                      textAlign: TextAlign.center,
                      style: EduPotDarkTextTheme.smallHeadline.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: studyProvider.quizzes.length,
                  itemBuilder: (context, index) {
                    return QuizItem(
                      answerType: AnswerType.quiz,
                      title: formatTitle(studyProvider.quizzes[index].title),
                      customColor: EduPotColorTheme.projectBlue,
                      height: 84,
                      iconSize: 50,
                      textStyle: EduPotDarkTextTheme.headline2(1).copyWith(
                        fontSize: 18,
                      ),
                      onPressed: () {
                        Get.to(QuizPage(
                          quizId: index,
                        ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTitle(String title, {int? length}) {
  if (title.length > (length ?? 20)) {
    return '${title.substring(0, length ?? 20)}...';
  }
  return title;
}
