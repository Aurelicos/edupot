import 'package:edupot/components/app/learning/creaition_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/common/select_time_modal.dart';
import 'package:edupot/providers/quiz_provider.dart';
import 'package:edupot/services/learning.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_button.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateQuizPage extends StatefulWidget {
  final int index;

  const CreateQuizPage({super.key, required this.index});

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
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

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
                      _buildHeader(),
                      const SizedBox(height: 25),
                      _buildQuestionInput(),
                      const SizedBox(height: 15),
                      _buildAnswersInput(),
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

  Widget _buildHeader() {
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
          CreaitionContent.radioOptions.values.toList()[widget.index],
          style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 28),
        ),
      ],
    );
  }

  Widget _buildQuestionInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color.fromARGB(255, 62, 67, 124),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
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
          onChanged: (value) => setState(() => _question = value),
        ),
      ),
    );
  }

  Widget _buildAnswersInput() {
    return GridView.builder(
      itemCount: 4,
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
            color: CreaitionContent.colors[index],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Answer ${index + 1}",
                      hintStyle: EduPotDarkTextTheme.smallHeadline,
                      border: InputBorder.none,
                    ),
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
                  onChanged: (switchValue) => setState(() {
                    value[index] = switchValue;
                    if (switchValue) {
                      _correctAnswers.add(_answers[index]);
                    } else {
                      _correctAnswers.remove(_answers[index]);
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
          _showErrorDialog("Question title cannot be empty.");
          return;
        }

        final nonEmptyAnswers =
            _answers.where((answer) => answer.isNotEmpty).toList();
        if (nonEmptyAnswers.isEmpty) {
          _showErrorDialog("Answers cannot be empty.");
          return;
        }

        if (_correctAnswers.isEmpty ||
            _correctAnswers.every((answer) => answer.isEmpty)) {
          _showErrorDialog("There must be at least one correct answer.");
          return;
        }

        quizProvider.addQuestion(
          _question,
          CreaitionContent.radioOptions.keys.toList()[widget.index].toString(),
          nonEmptyAnswers,
          _correctAnswers,
          date.second,
        );
        LearningService().createQuiz(
          quizProvider.title,
          quizProvider.isPublic,
          quizProvider.questions,
          quizProvider.answerTypes,
          quizProvider.answers,
          quizProvider.correctAnswers,
          quizProvider.times,
        );
        Get.back();
      },
      child: Text("Submit", style: EduPotDarkTextTheme.headline2(1)),
    );
  }

  void _showErrorDialog(String message) {
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
