import 'package:auto_route/auto_route.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddNotesModal extends StatelessWidget {
  final void Function() addNotes;
  final void Function() importNotes;

  const AddNotesModal({
    super.key,
    required this.addNotes,
    required this.importNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 45),
          Text(
            "Add notes",
            style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 15),
          buildMainButton(
            "Upload attachment from local device",
            "assets/icons/upload.svg",
            addNotes,
          ),
          const SizedBox(height: 15),
          buildMainButton(
            "Import notes from repository",
            "assets/icons/github.svg",
            importNotes,
          ),
          const Spacer(),
          cancelButton(context),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget buildMainButton(String text, String iconPath, VoidCallback onTap) {
    return MainButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(iconPath, width: 22, height: 22),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(text, style: EduPotDarkTextTheme.headline2(1)),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white, size: 22)
          ],
        ),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.maybePop(),
      child: Text(
        "Cancel",
        style: EduPotDarkTextTheme.headline2(0.4),
      ),
    );
  }
}
