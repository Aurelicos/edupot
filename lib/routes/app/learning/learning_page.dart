import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/learning/learn_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Learning Page',
                style: EduPotDarkTextTheme.headline1,
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 100,
              maxWidth: MediaQuery.of(context).size.width - 40,
            ),
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return const LearnButton("learn");
              },
            ),
          )
        ],
      ),
    );
  }
}
