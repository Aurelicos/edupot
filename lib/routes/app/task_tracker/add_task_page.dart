import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/components/app/task_tracker/content.dart';
import 'package:edupot/components/app/task_tracker/content_helper.dart';
import 'package:edupot/models/entries/exam.dart';
import 'package:edupot/models/entries/task.dart';
import 'package:edupot/models/projects/project.dart';
import 'package:edupot/providers/entry_provider.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/services/entry.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
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

  @override
  void initState() {
    super.initState();
    title =
        widget.exam?.title ?? widget.task?.title ?? widget.project?.name ?? "";
    time = widget.exam?.finalDate ??
        widget.task?.finalDate ??
        widget.project?.finalDate ??
        time;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SelectionProvider>(context, listen: false);
      provider.selectedIndex = widget.selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectionProvider>();
    final userProvider = context.watch<UserProvider>();
    final entryProvider = context.watch<EntryProvider>();
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
                                      (int index) =>
                                          provider.selectedIndex = index),
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
                            title: "SP",
                            onTime: () => timeModal(context, time,
                                (date) => setState(() => time = date)),
                            onDate: () => buildDatePicker(context, time,
                                (date) => setState(() => time = date)),
                          ),
                          projectContent: ProjectContent(
                              timeText: _selectedTime(),
                              dateText: _selectedDate(),
                              onTextChanged: (value) {
                                setState(
                                    () => simpleTitle = value.toUpperCase());
                              },
                              onTime: () => timeModal(context, time,
                                  (date) => setState(() => time = date)),
                              onDate: () => buildDatePicker(context, time,
                                  (date) => setState(() => time = date)),
                              onAttachment: () => showNotesModal(context,
                                  addNotes: () {}, importNotes: () {})),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: MainButton(
                        onTap: () {
                          if (provider.selectedIndex == 0) {
                            widget.modalContext?.popRoute();
                            final model = ExamModel(
                              title: title,
                              description: description,
                              finalDate: time,
                            );
                            EntryService()
                                .createExam(userProvider.user!.uid ?? "", model)
                                .then((value) {
                              entryProvider
                                  .fetchEntries(userProvider.user!.uid ?? "",
                                      forceRefresh: true)
                                  .then((value) => context.popRoute());
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
}
