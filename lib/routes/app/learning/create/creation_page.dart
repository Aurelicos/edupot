import 'package:edupot/components/app/learning/creaition_content.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/indicator.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  int step = 1;
  @override
  Widget build(BuildContext context) {
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
              header(context),
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: CreaitionContent.getContent(
                    step,
                    context: context,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MainButton(
                    onTap: () => setState(
                        () => step < CreaitionContent.steps ? step++ : null),
                    child:
                        Text("Next", style: EduPotDarkTextTheme.headline2(1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => step > 1 ? setState(() => step--) : Get.back(),
          child: const Icon(Icons.arrow_back_rounded,
              size: 32, color: Colors.white),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Step $step/${CreaitionContent.steps}',
                style: EduPotDarkTextTheme.smallHeadline,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Indicator(
                  base: CreaitionContent.steps,
                  progression: step,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => Get.back(),
          child: const Text(
            "Save",
            style: EduPotDarkTextTheme.headline3,
          ),
        ),
      ],
    );
  }
}
