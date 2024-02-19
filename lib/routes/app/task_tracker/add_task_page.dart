import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/components/app/task_tracker/content.dart';
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

  const AddTaskPage({super.key, required this.selectedCategory});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = "Task";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SelectionProvider>(context, listen: false);
      provider.selectedIndex = widget.selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectionProvider>();
    Content content = Content();

    return PrimaryScaffold(
      navBar: false,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              InkWell(
                onTap: () => context.popRoute(),
                child: const Icon(Icons.arrow_back_rounded,
                    size: 32, color: Colors.white),
              ),
              const SizedBox(height: 15),
              buildHeadline(title, context),
              const SizedBox(height: 15),
              buildInputField("Title", "My Task", (input) {
                setState(() => title = input.isEmpty ? "Task" : input);
              }),
              const SizedBox(height: 15),
              InputField(
                headline: "Description",
                placeholder:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris gravida urna purus, eget mattis eros cursus lorem ipsum...",
                height: 100,
                maxLines: 3,
                textChanged: (String input) {},
              ),
              const SizedBox(height: 15),
              const DescriptionText(text: "Category"),
              buildButtons(widget.selectedCategory,
                  (int index) => provider.selectedIndex = index),
              const SizedBox(height: 15),
              content.getContent(
                provider.selectedIndex,
                examContent: ExamContent(
                    onAttachment: () => showNotesModal(context,
                        addNotes: () {}, importNotes: () {})),
                taskContent: const TaskContent(title: "SP"),
                projectContent: ProjectContent(
                  onTextChanged: (value) {},
                  onAttachment: () => showNotesModal(context,
                      addNotes: () {}, importNotes: () {}),
                ),
              ),
              const SizedBox(height: 30),
              MainButton(
                onTap: () {},
                child: Text("Submit", style: EduPotDarkTextTheme.headline2(1)),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
          String headline, String placeholder, Function(String)? onChanged) =>
      InputField(
        headline: headline,
        placeholder: placeholder,
        validatorText: "",
        textChanged: onChanged ?? (String input) {},
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
}
