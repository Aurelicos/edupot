import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/components/app/task_tracker/content.dart';
import 'package:edupot/providers/selection_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with SingleTickerProviderStateMixin {
  String title = "Task";
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectionProvider>();
    Content content = Content();

    _animationController.reset();
    _animationController.forward();
    return PrimaryScaffold(
      navBar: false,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              InkWell(
                onTap: () => context.popRoute(),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeadline(title, context),
              const SizedBox(
                height: 15,
              ),
              InputField(
                headline: "Title",
                placeholder: "My Task",
                validatorText: "",
                textChanged: (String input) {
                  setState(() {
                    if (input.isEmpty) {
                      title = "Task";
                    } else {
                      title = input;
                    }
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              InputField(
                headline: "Description",
                placeholder:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris gravida urna purus, eget mattis eros cursus lorem ipsum...",
                height: 100,
                maxLines: 3,
                textChanged: (String input) {},
              ),
              const SizedBox(
                height: 15,
              ),
              const DescriptionText(text: "Category"),
              buildButtons(provider.selectedIndex, (int index) {
                provider.selectedIndex = index;
                _animationController.reset();
                _animationController.forward();
              }),
              const SizedBox(
                height: 15,
              ),
              SizeTransition(
                sizeFactor: _scaleAnimation,
                child: content.getContent(
                  provider.selectedIndex,
                  examContent: const ExamContent(),
                  taskContent: const TaskContent(title: "SP"),
                  projectContent: ProjectContent(
                    onTextChanged: (String value) {},
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MainButton(
                onTap: () {},
                child: Text(
                  "Submit",
                  style: EduPotDarkTextTheme.headline2(1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
