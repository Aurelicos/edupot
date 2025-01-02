import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/routes/app/learning/create/creation_page.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      navBar: false,
      onPressed: () => Get.to(const CreationPage()),
      buttonMargin: const EdgeInsets.only(bottom: 84),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_rounded,
                        size: 32, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      'Study',
                      textAlign: TextAlign.center,
                      style: EduPotDarkTextTheme.smallHeadline,
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
