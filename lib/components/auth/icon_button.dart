import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlatformButton extends StatelessWidget {
  final String iconPath;
  final Color color;
  final Function()? onPressed;

  const PlatformButton({
    super.key,
    required this.iconPath,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12)),
        onPressed: onPressed,
        child: SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
