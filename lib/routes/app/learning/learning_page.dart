import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/routes/app/learning/create/creation_page.dart';
import 'package:edupot/routes/app/learning/study/study_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/learn_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Map<String, Widget> data = {
      "study": StudyPage(),
      "create": CreationPage(),
      "reports": Placeholder(),
      "settings": Placeholder(),
    };
    return PrimaryScaffold(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              const Text(
                'Learning Page',
                style: EduPotDarkTextTheme.headline1,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return LearnButton(
                      data.keys.toList()[index],
                      onPressed: () {
                        Get.to(data.values.toList()[index]);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
