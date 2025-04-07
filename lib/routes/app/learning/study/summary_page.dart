import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/models/learning/report.dart';
import 'package:edupot/providers/report_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/learning/reports/reports_page.dart';
import 'package:edupot/routes/app/learning/study/study_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/summary_animation.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatefulWidget {
  final QuizModel? quiz;

  final List<String>? userAnswers;

  final String? reportId;

  const SummaryPage({
    super.key,
    this.quiz,
    this.userAnswers,
    this.reportId,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late ReportProvider _reportProvider;
  late String _userId;

  ReportModel? _storedReport;

  List<bool> _isCorrect = [];

  @override
  void initState() {
    super.initState();
    _reportProvider = Provider.of<ReportProvider>(context, listen: false);
    _userId = Provider.of<UserProvider>(context, listen: false).user?.uid ?? "";

    if (widget.quiz != null && widget.userAnswers != null) {
      _isCorrect = _calculateIsCorrect(widget.quiz!, widget.userAnswers!);
      _saveReport();
    } else if (widget.reportId != null) {
      _loadStoredReport(widget.reportId!);
    }
  }

  List<bool> _calculateIsCorrect(QuizModel quiz, List<String> userAnswers) {
    List<bool> results = [];
    for (int i = 0; i < quiz.correctAnswers.length; i++) {
      final userAnswer = userAnswers[i].trim().toLowerCase();
      final correct = quiz.correctAnswers[i]
          .map((ans) => ans.trim().toLowerCase())
          .toList();
      results.add(correct.contains(userAnswer));
    }
    return results;
  }

  Future<void> _saveReport() async {
    if (widget.quiz == null || widget.userAnswers == null) return;

    final correctCount = _isCorrect.where((c) => c).length;
    final percentage = (correctCount / widget.quiz!.questions.length) * 100;

    final report = ReportModel(
      uid: '',
      userId: _userId,
      quizId: widget.quiz!.uid ?? "",
      quizName: widget.quiz!.title,
      totalQuestions: widget.quiz!.questions.length,
      correctAnswers: correctCount,
      percentage: percentage,
      date: DateTime.now(),
      isCorrect: _isCorrect,
    );

    try {
      await _reportProvider.addReport(_userId, report);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving report: $e')),
        );
      }
    }
  }

  void _loadStoredReport(String reportId) {
    final emptyModel = ReportModel(
      userId: '',
      quizId: '',
      quizName: '',
      totalQuestions: 0,
      correctAnswers: 0,
      percentage: 0.0,
      date: DateTime.now(),
      isCorrect: [],
    );
    final stored = _reportProvider.reports
        .firstWhere((r) => r.uid == reportId, orElse: () => emptyModel);
    if (stored != emptyModel) {
      setState(() {
        _storedReport = stored;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quiz != null && widget.userAnswers != null) {
      return _buildFullDetail(context);
    }

    if (_storedReport != null) {
      return _buildMinimalDetail(context);
    }

    return PrimaryScaffold(
      child: Center(
        child: Text(
          'No data available.',
          style: EduPotDarkTextTheme.headline2(1),
        ),
      ),
    );
  }

  Widget _buildFullDetail(BuildContext context) {
    final quiz = widget.quiz!;
    final userAnswers = widget.userAnswers!;
    final correctCount = _isCorrect.where((c) => c).length;
    final percentage = (correctCount / quiz.questions.length) * 100;

    return PrimaryScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.045),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.off(const StudyPage());
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
                GestureDetector(
                  onTap: () {
                    _reportProvider.deleteReport(_userId, quiz.uid ?? "");
                  },
                  child: SvgPicture.asset(
                    "assets/icons/bin.svg",
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SummaryAnimation(percentage: percentage),
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
                  final isCorrect = _isCorrect[index];

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

  Widget _buildMinimalDetail(BuildContext context) {
    final report = _storedReport!;
    final percentage = report.percentage;
    final correctCount = report.correctAnswers;

    return PrimaryScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.045),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.off(const ReportsPage());
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
            SummaryAnimation(percentage: percentage),
            Text(
              "Quiz: ${report.quizName}",
              style: EduPotDarkTextTheme.headline2(1).copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'You answered $correctCount out of ${report.totalQuestions} questions correctly.',
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
                itemCount: report.totalQuestions,
                itemBuilder: (context, index) {
                  final isCorrect = report.isCorrect[index];
                  return Card(
                    color:
                        isCorrect ? Colors.green.shade200 : Colors.red.shade200,
                    child: ListTile(
                      title: Text('Question #${index + 1}'),
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
