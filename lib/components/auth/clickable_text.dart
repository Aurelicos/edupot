import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final Function() onPressed;
  final String firstText;
  final String clickableText;
  final String? lastText;

  const ClickableText({
    super.key,
    required this.onPressed,
    required this.firstText,
    required this.clickableText,
    this.lastText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: EduPotDarkTextTheme.headline2(0.4),
        children: <TextSpan>[
          TextSpan(text: firstText),
          TextSpan(
            text: clickableText,
            style: EduPotDarkTextTheme.headline2(0.4).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white.withOpacity(0.4),
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
          TextSpan(text: lastText, style: EduPotDarkTextTheme.headline2(0.4)),
        ],
      ),
    );
  }
}
