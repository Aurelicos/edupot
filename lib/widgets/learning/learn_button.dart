import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:edupot/utils/extensions/capitalize.dart';

class LearnButton extends StatelessWidget {
  final String iconName;
  final void Function() onPressed;

  const LearnButton(this.iconName, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 2 - 30;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        ),
      ),
      child: Ink(
        decoration: ShapeDecoration(
          color: EduPotColorTheme.lightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: SizedBox(
          width: size > 250 ? 250 : size,
          height: size > 250 ? 250 : size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/$iconName.svg",
                height: 40,
                width: 40,
              ),
              const SizedBox(height: 10),
              Text(
                iconName.capitalize(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
