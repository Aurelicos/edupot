import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/models/learning/quiz.dart';
import 'package:edupot/providers/report_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/learning/learning_page.dart';
import 'package:edupot/routes/app/learning/study/study_page.dart';
import 'package:edupot/routes/app/learning/study/summary_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reportProvider = context.read<ReportProvider>();

      reportProvider
          .fetchReports(context.read<UserProvider>().user!.uid ?? "")
          .then(
        (value) {
          if (value == false && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to fetch reports'),
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: true);
    return PrimaryScaffold(
      navBar: false,
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
                      Get.off(const LearningPage());
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
              Expanded(
                child: ListView.builder(
                  itemCount: reportProvider.reports.length,
                  itemBuilder: (context, index) {
                    return QuizItem(
                      answerType: AnswerType.quiz,
                      showmenu: true,
                      title:
                          formatTitle(reportProvider.reports[index].quizName),
                      customColor: EduPotColorTheme.examsOrange,
                      reportId: reportProvider.reports[index].uid ?? "",
                      height: 84,
                      iconSize: 40,
                      iconName: "graph",
                      textStyle: EduPotDarkTextTheme.headline2(1).copyWith(
                        fontSize: 18,
                      ),
                      onPressed: () {
                        Get.to(SummaryPage(
                          reportId: reportProvider.reports[index].uid ?? "",
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
