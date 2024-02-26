import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/components/app/task_tracker/content.dart';
import 'package:edupot/components/tasks/select_time_modal.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/add_notes_modal.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  final int selectedCategory;

  final ExamModel? exam;
  final TaskModel? task;

  final ProjectModel? project;

  const AddTaskPage({
    super.key,
    required this.selectedCategory,
    this.exam,
    this.task,
    this.project,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  List<String> headlines = [
    "My Exam",
    "My Task",
    "My Project",
  ];

  List<Color> colorsPalete = [
    EduPotColorTheme.examsOrange,
    EduPotColorTheme.tasksPurple,
    EduPotColorTheme.projectBlue,
  ];

  String title = "";
  String simpleTitle = "MP";

  @override
  void initState() {
    super.initState();
    title =
        widget.exam?.title ?? widget.task?.title ?? widget.project?.name ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SelectionProvider>(context, listen: false);
      provider.selectedIndex = widget.selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectionProvider>();
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
                          onTap: () => context.popRoute(),
                          child: const Icon(Icons.arrow_back_rounded,
                              size: 32, color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        buildHeadline(
                          title.isEmpty
                              ? headlines[provider.selectedIndex]
                              : title,
                          context,
                          isProject: provider.selectedIndex == 2,
                          hexagonText: simpleTitle,
                          color: colorsPalete[provider.selectedIndex],
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
                          textChanged: (String input) {},
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
                                      (int index) =>
                                          provider.selectedIndex = index),
                                ],
                              ),
                        const SizedBox(height: 5),
                        content.getContent(
                          provider.selectedIndex,
                          examContent: ExamContent(
                            onAttachment: () => showNotesModal(
                              context,
                              addNotes: () {},
                              importNotes: () {},
                            ),
                            onTime: () => timeModal(context),
                          ),
                          taskContent: TaskContent(
                            title: "SP",
                            onTime: () => timeModal(context),
                          ),
                          projectContent: ProjectContent(
                              onTextChanged: (value) {
                                setState(
                                    () => simpleTitle = value.toUpperCase());
                              },
                              onTime: () => timeModal(context),
                              onAttachment: () => showNotesModal(context,
                                  addNotes: () {}, importNotes: () {})),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: MainButton(
                        onTap: () {},
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

  Widget buildInputField(
          String headline, String placeholder, Function(String)? onChanged,
          {String? initialValue}) =>
      InputField(
        headline: headline,
        placeholder: placeholder,
        validatorText: "",
        textChanged: onChanged ?? (String input) {},
        initialValue: initialValue,
      );

  void showNotesModal(
    BuildContext context, {
    required void Function() addNotes,
    required void Function() importNotes,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: EduPotColorTheme.primaryDark,
      builder: (BuildContext context) =>
          AddNotesModal(addNotes: addNotes, importNotes: importNotes),
    );
  }

  void timeModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: EduPotColorTheme.primaryDark,
        builder: (BuildContext context) {
          return const SelectTimeModal();
        });
  }
}
