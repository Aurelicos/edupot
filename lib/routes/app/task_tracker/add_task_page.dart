import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/components/app/task_tracker/build_buttons.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/input_button.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String title = "Task";

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      navBar: false,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.085,
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
                height: 20,
              ),
              buildHeadline(title, context),
              const SizedBox(
                height: 20,
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
                height: 20,
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
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              buildButtons((int index) => print("$index")),
              const InputButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
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
