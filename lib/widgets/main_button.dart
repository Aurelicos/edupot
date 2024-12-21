import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final bool isBorderOnly;

  const MainButton({
    super.key,
    required this.onTap,
    required this.child,
    this.isBorderOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isBorderOnly ? null : EduPotColorTheme.mainBlueGradient(),
          borderRadius: BorderRadius.circular(8),
          border: isBorderOnly
              ? Border.all(
                  color: EduPotColorTheme.projectBlue,
                  width: 2,
                )
              : null,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 56,
          child: child,
        ),
      ),
    );
  }
}
