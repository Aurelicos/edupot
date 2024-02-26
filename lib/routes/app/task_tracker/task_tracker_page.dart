import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/task_modal.dart';
import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/utils/common/shimmer.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/task_tracker/project_view.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TaskTrackerPage extends StatefulWidget {
  const TaskTrackerPage({super.key});

  @override
  State<TaskTrackerPage> createState() => _TaskTrackerPageState();
}

class _TaskTrackerPageState extends State<TaskTrackerPage> {
  bool _isLoading = true;

  List array = [
    {
      "title": "Muster Projekt Beispiel",
      "description": "Description 1",
      "finalDate": DateTime.parse("2022-01-22 22:18:04Z"),
      "tasks": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"],
      "finished": 3,
      "iconTitle": "SP"
    },
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      final entryProvider = context.read<EntryProvider>();
      entryProvider.fetchEntries(userProvider.user!.uid ?? "").then((value) {
        if (value["cached"] == true) {
          setState(() => _isLoading = false);
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _isLoading = false);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return PrimaryScaffold(
      onPressed: () => modal(),
      child: SafeArea(
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: EduPotColorTheme.primaryDark,
          onRefresh: () async {
            setState(() {
              _isLoading = true;
            });
            final entryProvider = context.read<EntryProvider>();
            entryProvider
                .fetchEntries(userProvider.user!.uid ?? "", forceRefresh: true)
                .then((value) {
              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() => _isLoading = false);
              });
            });
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Task Tracker',
                            style: EduPotDarkTextTheme.headline1,
                          ),
                          SizedBox(
                            width: 45,
                            child: GestureDetector(
                              onTap: () {},
                              child:
                                  SvgPicture.asset("assets/icons/search.svg"),
                            ),
                          )
                        ],
                      ),
                      ProjectView(
                        itemArray: array,
                      ),
                      _isLoading ? _loadingUI() : _buildContent(context),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _loadingUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text("Exams", style: EduPotDarkTextTheme.headline4),
        ),
        _buildLoading(),
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text("Tasks", style: EduPotDarkTextTheme.headline4),
        ),
        _buildLoading(),
      ],
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 128,
      child: Shimmer(
        linearGradient: EduPotColorTheme.shimmerGradient,
        child: Column(
          children: [
            for (int i = 0; i < 2; i++)
              ShimmerLoading(
                isLoading: true,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  height: 54,
                  decoration: BoxDecoration(
                    color: EduPotColorTheme.primaryBlueDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    List<dynamic> exams = Provider.of<EntryProvider>(context).exams;
    List<dynamic> tasks = Provider.of<EntryProvider>(context).tasks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        exams.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("Exams", style: EduPotDarkTextTheme.headline4),
              )
            : const SizedBox(),
        TaskView(
          entry: exams,
          color: EduPotColorTheme.examsOrange,
        ),
        tasks.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text("Tasks", style: EduPotDarkTextTheme.headline4),
              )
            : const SizedBox(),
        TaskView(
          entry: tasks,
          isTask: true,
          color: EduPotColorTheme.tasksPurple,
        ),
        exams.isEmpty && tasks.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ClickableText(
                      onPressed: () => modal(),
                      firstText: "You don't have any entries. ",
                      clickableText: "Add entry"),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Future modal() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: EduPotColorTheme.primaryDark,
      builder: (BuildContext context) {
        return TaskModal(
          onPressed: (int index) =>
              context.pushRoute(AddTaskRoute(selectedCategory: index)),
        );
      },
    );
  }
}
