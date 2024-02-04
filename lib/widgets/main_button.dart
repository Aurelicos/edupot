import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function() onTap;
  final Widget? child;

  const MainButton({
    super.key,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                gradient: EduPotColorTheme.mainBlueGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
