import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputButton extends StatelessWidget {
  final String asset;
  final String text;

  final void Function()? onPressed;

  const InputButton({
    super.key,
    required this.asset,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: EduPotColorTheme.mainItemGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                asset,
                width: 18,
                height: 18,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
