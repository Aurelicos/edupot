import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/loading_content.dart';
import 'package:edupot/components/app/task_tracker/task_modal.dart';
import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/task_tracker/add_task_page.dart';
import 'package:edupot/utils/common/bounce_physics.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/search_list.dart';
import 'package:edupot/widgets/task_tracker/project_view.dart';
import 'package:edupot/widgets/task_tracker/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class TaskTrackerPage extends StatefulWidget {
  const TaskTrackerPage({super.key});

  @override
  State<TaskTrackerPage> createState() => _TaskTrackerPageState();
}

class _TaskTrackerPageState extends State<TaskTrackerPage> {
  final List<bool> _isLoading = [true, true];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      final entryProvider = context.read<EntryProvider>();
      final projectProvider = context.read<ProjectProvider>();

      projectProvider.fetchProjects(userProvider.user!.uid ?? "").then((value) {
        if (value["cached"] == true) {
          setState(() => _isLoading[0] = false);
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _isLoading[0] = false);
          });
        }
      });

      entryProvider.fetchEntries(userProvider.user!.uid ?? "").then((value) {
        if (value["cached"] == true) {
          setState(() => _isLoading[1] = false);
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _isLoading[1] = false);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    bool isSearching = false;

    return PrimaryScaffold(
      onPressed: () => modal(),
      child: SafeArea(
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: EduPotColorTheme.primaryDark,
          onRefresh: () async {
            setState(() {
              _isLoading.setAll(0, [true, true]);
            });
            final entryProvider = context.read<EntryProvider>();
            projectProvider
                .fetchProjects(userProvider.user!.uid ?? "", forceRefresh: true)
                .then((value) {
              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() => _isLoading[0] = false);
              });
            });
            entryProvider
                .fetchEntries(userProvider.user!.uid ?? "", forceRefresh: true)
                .then((value) {
              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() => _isLoading[1] = false);
              });
            });
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: OneBouncePhysics()),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Column(
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
                                  onTap: () {
                                    setState(() {
                                      isSearching = !isSearching;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/search.svg"),
                                ),
                              )
                            ],
                          ),
                          _isLoading.every((element) => element == true)
                              ? projectLoadingUI()
                              : const ProjectView(),
                          _isLoading.every((element) => element == true)
                              ? loadingUI()
                              : _buildContent(context),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.045),
                        child: SearchList(
                          placeholder: "Search",
                          color: EduPotColorTheme.lightGray2,
                          dropdownButtonStyle: SearchListButtonStyle(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hideIcon: true,
                          items: _createDropdownItems(projectProvider),
                          onChange: (value) {},
                        ),
                      ),
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

  List<SearchListItem> _createDropdownItems(ProjectProvider provider) {
    List<ProjectModel> items = provider.projects;
    return items
        .asMap()
        .entries
        .map(
          (item) => SearchListItem(
            id: item.value.id!,
            name: item.value.name,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                formatText(item.value.name, 14),
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildContent(BuildContext context) {
    List<dynamic> exams =
        Provider.of<EntryProvider>(context, listen: true).exams;
    List<dynamic> tasks =
        Provider.of<EntryProvider>(context, listen: true).tasks;
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
        return TaskModal(onPressed: (int index) {
          Navigator.of(context).pop();
          Get.to(AddTaskPage(
            selectedCategory: index,
          ));
        });
      },
    );
  }
}
