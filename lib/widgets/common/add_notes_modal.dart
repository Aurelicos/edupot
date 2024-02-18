import 'package:auto_route/auto_route.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddNotesModal extends StatelessWidget {
  final void Function() addNotes;
  final void Function() importNotes;
  const AddNotesModal(
      {super.key, required this.addNotes, required this.importNotes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 45,
          ),
          Text(
            "Add notes",
            style: EduPotDarkTextTheme.headline1.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MainButton(
            onTap: addNotes,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/upload.svg",
                    width: 22,
                    height: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Upload attachment from local device",
                        style: EduPotDarkTextTheme.headline2(1),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 22,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MainButton(
            onTap: importNotes,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/github.svg",
                    width: 22,
                    height: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Import notes from repository",
                        style: EduPotDarkTextTheme.headline2(1),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 22,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => context.popRoute(),
            child: Text(
              "Cancel",
              style: EduPotDarkTextTheme.headline2(0.4),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
