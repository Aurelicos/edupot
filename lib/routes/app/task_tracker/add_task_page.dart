import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/components/app/task_tracker/content.dart';
import 'package:edupot/components/app/task_tracker/content_helper.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/project_provider.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/services/entry.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/common/multi_select_dropdown.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  final int selectedCategory;
  final BuildContext? modalContext;

  final ExamModel? exam;
  final TaskModel? task;

  final ProjectModel? project;

  const AddTaskPage({
    super.key,
    required this.selectedCategory,
    this.modalContext,
    this.exam,
    this.task,
    this.project,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = "";
  String simpleTitle = "MP";

  String description = "";

  DateTime time = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    12,
    30,
  );

  DocumentReference? assignedProject;
  List<DocumentReference>? assignedTasks;

  bool isTaskDone = false;

  @override
  void initState() {
    super.initState();
    time = widget.exam?.finalDate ??
        widget.task?.finalDate ??
        widget.project?.finalDate ??
        time;
    assignedTasks = widget.project?.tasks;
    description = widget.exam?.description ??
        widget.task?.description ??
        widget.project?.description ??
        "";
    simpleTitle = widget.project?.iconTitle ?? "MP";
    assignedProject = widget.task?.assignedProject;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SelectionProvider>(context, listen: false);
      provider.selectedIndex = widget.selectedCategory;
      title = widget.exam?.title ??
          widget.task?.title ??
          widget.project?.name ??
          headlines[provider.selectedIndex];
    });
    isTaskDone = widget.task?.done ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectionProvider>();
    final userProvider = context.watch<UserProvider>();
    final entryProvider = context.watch<EntryProvider>();
    final projectProvider = context.watch<ProjectProvider>();
    final Content content = Content();

    return PrimaryScaffold(
      navBar: false,
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.arrow_back_rounded,
                              size: 32, color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        buildHeadline(
                          title.isEmpty
                              ? headlines[provider.selectedIndex]
                              : title,
                          onDone: (bool selected) => isTaskDone = selected,
                          show: isTaskDone,
                          context,
                          disabled: provider.selectedIndex != 1,
                          isProject: provider.selectedIndex == 2,
                          hexagonText: simpleTitle,
                          color: colorsPalete[provider.selectedIndex],
                          onDelete: widget.exam != null ||
                                  widget.task != null ||
                                  widget.project != null
                              ? () {
                                  String? id;
                                  String type = "";

                                  if (widget.exam != null) {
                                    id = widget.exam!.id;
                                    type = "exam";
                                  } else if (widget.task != null) {
                                    id = widget.task!.id;
                                    type = "task";
                                  } else if (widget.project != null) {
                                    id = widget.project!.id;
                                    type = "project";
                                  }

                                  if (id != null) {
                                    deleteAndFetchEntries(
                                      id,
                                      type,
                                      entryProvider: entryProvider,
                                      userProvider: userProvider,
                                      projectProvider: projectProvider,
                                      assigned: type == "task"
                                          ? widget.task?.assignedProject
                                          : null,
                                    );
                                  }
                                }
                              : null,
                        ),
                        const SizedBox(height: 15),
                        buildInputField(
                            "Title", headlines[provider.selectedIndex],
                            initialValue: widget.exam?.title ??
                                widget.task?.title ??
                                widget.project?.name, (input) {
                          setState(() => title = input);
                        }),
                        const SizedBox(height: 5),
                        InputField(
                          headline: "Description",
                          placeholder:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                          height: 100,
                          maxLines: 3,
                          textChanged: (String input) =>
                              setState(() => description = input),
                          initialValue: widget.exam?.description ??
                              widget.task?.description ??
                              widget.project?.description,
                        ),
                        const SizedBox(height: 5),
                        widget.exam != null ||
                                widget.task != null ||
                                widget.project != null
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DescriptionText(text: "Category"),
                                  buildButtons(
                                    widget.selectedCategory,
                                    (int index) => setState(() {
                                      provider.selectedIndex = index;
                                      title = headlines[provider.selectedIndex];
                                    }),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 5),
                        content.getContent(
                          provider.selectedIndex,
                          examContent: ExamContent(
                            timeText: _selectedTime(),
                            dateText: _selectedDate(),
                            onAttachment: () => showNotesModal(
                              context,
                              addNotes: () {},
                              importNotes: () {},
                            ),
                            onTime: () => timeModal(context, time,
                                (date) => setState(() => time = date)),
                            onDate: () => buildDatePicker(context, time,
                                (date) => setState(() => time = date)),
                          ),
                          taskContent: TaskContent(
                              timeText: _selectedTime(),
                              dateText: _selectedDate(),
                              onTime: () => timeModal(context, time,
                                  (date) => setState(() => time = date)),
                              onDate: () => buildDatePicker(context, time,
                                  (date) => setState(() => time = date)),
                              context: context,
                              docId: widget.task?.assignedProject?.id,
                              onProject: (String id) {
                                setState(() {
                                  if (id.isEmpty) {
                                    assignedProject = null;
                                  } else {
                                    assignedProject = FirebaseFirestore.instance
                                        .collection("projects")
                                        .doc(id);
                                  }
                                });
                              }),
                          projectContent: ProjectContent(
                            iconTitle: simpleTitle,
                            timeText: _selectedTime(),
                            dateText: _selectedDate(),
                            onTextChanged: (value) {
                              setState(() => simpleTitle = value.toUpperCase());
                            },
                            onTime: () => timeModal(context, time,
                                (date) => setState(() => time = date)),
                            onDate: () => buildDatePicker(context, time,
                                (date) => setState(() => time = date)),
                            onAttachment: () => showNotesModal(context,
                                addNotes: () {}, importNotes: () {}),
                            onIdChange: (List<Item> value) => setState(() {
                              final uid = userProvider.user?.uid ?? "";
                              setState(() {
                                assignedTasks = value
                                    .map((element) {
                                      return FirebaseFirestore.instance
                                          .collection("entry")
                                          .doc(uid)
                                          .collection("tasks")
                                          .doc(element.id);
                                    })
                                    .cast<DocumentReference<Object?>>()
                                    .toList();
                              });
                            }),
                            initialTasks: assignedTasks,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: MainButton(
                        onTap: () {
                          final entryType =
                              provider.selectedIndex == 0 ? "exam" : "task";

                          final model = provider.selectedIndex == 0
                              ? (widget.exam != null
                                  ? widget.exam!.copyWith(
                                      title: title,
                                      description: description,
                                      finalDate: time)
                                  : ExamModel(
                                      title: title,
                                      description: description,
                                      finalDate: time))
                              : provider.selectedIndex == 1
                                  ? (widget.task != null
                                      ? widget.task!.copyWith(
                                          title: title,
                                          description: description,
                                          finalDate: time,
                                          assignedProject: assignedProject,
                                          done: isTaskDone,
                                        )
                                      : TaskModel(
                                          title: title,
                                          description: description,
                                          finalDate: time,
                                          assignedProject: assignedProject,
                                          done: isTaskDone,
                                        ))
                                  : provider.selectedIndex == 2
                                      ? (widget.project != null
                                          ? widget.project!.copyWith(
                                              name: title,
                                              description: description,
                                              finalDate: time,
                                              iconTitle: simpleTitle,
                                              tasks: assignedTasks ?? [],
                                            )
                                          : ProjectModel(
                                              name: title,
                                              description: description,
                                              finalDate: time,
                                              finished: 0,
                                              iconTitle: simpleTitle,
                                              tasks: assignedTasks ?? [],
                                            ))
                                      : null;

                          final uid = userProvider.user?.uid ?? "";
                          Get.back();

                          if (model is ProjectModel) {
                            if (widget.project != null) {
                              EntryService()
                                  .assignTasks(
                                      uid,
                                      widget.project!.id!,
                                      assignedTasks ?? [],
                                      widget.project!.tasks)
                                  .then((data) {
                                EntryService()
                                    .setProject(model,
                                        update: widget.project != null)
                                    .then((_) {
                                  if (data["updated"] == true) {
                                    projectProvider.fetchProjects(uid,
                                        forceRefresh: true);
                                    entryProvider.fetchEntries(uid,
                                        forceRefresh: true);
                                  } else {
                                    projectProvider.fetchProjects(uid,
                                        forceRefresh: true);
                                  }
                                }).then((_) => mounted ? Get.back() : false);
                              });
                            } else {
                              EntryService()
                                  .setProject(model,
                                      update: false,
                                      uid: userProvider.user?.uid ?? "")
                                  .then((projectId) {
                                if (assignedTasks != null &&
                                    assignedTasks!.isNotEmpty) {
                                  EntryService().assignTasks(uid, projectId,
                                      assignedTasks!, []).then((_) {
                                    projectProvider.fetchProjects(uid,
                                        forceRefresh: true);
                                    entryProvider.fetchEntries(uid,
                                        forceRefresh: true);
                                  });
                                } else {
                                  projectProvider.fetchProjects(uid,
                                      forceRefresh: true);
                                }
                              }).then((_) => mounted ? Get.back() : false);
                            }
                          } else {
                            EntryService()
                                .setEntry(uid, model, entryType,
                                    oldAssignee: widget.task?.assignedProject,
                                    update: provider.selectedIndex == 0
                                        ? widget.exam != null
                                        : widget.task != null)
                                .then((value) {
                              if (value["updated"] == true ||
                                  (widget.task != null &&
                                      widget.task!.done != isTaskDone)) {
                                projectProvider
                                    .fetchProjects(uid, forceRefresh: true)
                                    .then((_) {
                                  entryProvider
                                      .fetchEntries(uid, forceRefresh: true)
                                      .then(
                                          (_) => mounted ? Get.back() : false);
                                });
                              } else {
                                entryProvider
                                    .fetchEntries(uid, forceRefresh: true)
                                    .then((_) => mounted ? Get.back() : false);
                              }
                            });
                          }
                        },
                        child: Text("Submit",
                            style: EduPotDarkTextTheme.headline2(1)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _selectedDate() {
    return "${time.day}/${time.month}/${time.year}";
  }

  String _selectedTime() {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  void deleteAndFetchEntries(
    String id,
    String type, {
    required UserProvider userProvider,
    required EntryProvider entryProvider,
    required ProjectProvider projectProvider,
    DocumentReference? assigned,
  }) {
    if (type == "project") {
      EntryService()
          .deleteProject(
              id, widget.project!.tasks, userProvider.user!.uid ?? "")
          .then((value) {
        if (value["updated"] == true) {
          entryProvider
              .fetchEntries(userProvider.user!.uid ?? "", forceRefresh: true)
              .then((_) => projectProvider
                  .fetchProjects(userProvider.user!.uid ?? "",
                      forceRefresh: true)
                  .then((value) => Get.back()));
        } else {
          projectProvider
              .fetchProjects(userProvider.user!.uid ?? "", forceRefresh: true)
              .then((value) => Get.back());
        }
      });
      return;
    } else {
      EntryService()
          .deleteEntry(userProvider.user!.uid ?? "", id, type, assigned)
          .then((value) {
        entryProvider
            .fetchEntries(userProvider.user!.uid ?? "", forceRefresh: true)
            .then((value) => Get.back());
      });
    }
  }
}
