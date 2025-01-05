import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/routes/app/learning/study/study_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/summary_animation.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryPage extends StatelessWidget {
  final QuizModel quiz;
  final List<String> userAnswers;

  const SummaryPage({
    super.key,
    required this.quiz,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctCount = 0;

    for (int i = 0; i < quiz.correctAnswers.length; i++) {
      String userAnswer = userAnswers[i].trim().toLowerCase();
      List<String> correct = quiz.correctAnswers[i]
          .map((ans) => ans.trim().toLowerCase())
          .toList();

      if (correct.contains(userAnswer)) {
        correctCount++;
      }
    }

    double percentage = (correctCount / quiz.questions.length) * 100;

    return PrimaryScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const StudyPage());
                  },
                  child: const Icon(Icons.arrow_back_rounded,
                      size: 32, color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    'Quiz Summary',
                    textAlign: TextAlign.center,
                    style: EduPotDarkTextTheme.smallHeadline.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
            const SizedBox(height: 20),
            SummaryAnimation(
              percentage: percentage,
            ),
            Text(
              "Quiz: ${quiz.title}",
              style: EduPotDarkTextTheme.headline2(1).copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'You answered $correctCount out of ${quiz.questions.length} questions correctly.',
              style: EduPotDarkTextTheme.headline2(1).copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  final correctAnswer = quiz.correctAnswers[index].join(', ');
                  final userAnswer = userAnswers[index].isEmpty
                      ? 'No answer'
                      : userAnswers[index];
                  final isCorrect = quiz.correctAnswers[index]
                      .map((ans) => ans.trim().toLowerCase())
                      .contains(userAnswer.trim().toLowerCase());

                  return Card(
                    color:
                        isCorrect ? Colors.green.shade200 : Colors.red.shade200,
                    child: ListTile(
                      title: Text(question),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your answer: $userAnswer'),
                          Text('Correct answer: $correctAnswer'),
                        ],
                      ),
                      trailing: Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            MainButton(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Finish',
                style: EduPotDarkTextTheme.headline2(1).copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
