import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function() onTap;
  final Widget child;

  const MainButton({
    super.key,
    required this.onTap,
    required this.child,
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
          gradient: EduPotColorTheme.mainBlueGradient(),
          borderRadius: BorderRadius.circular(8),
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
