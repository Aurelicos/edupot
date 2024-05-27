import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputButton extends StatelessWidget {
  final String? asset;
  final String? text;
  final String? asset2;
  final Widget? child;

  final void Function()? onPressed;

  const InputButton({
    super.key,
    this.asset,
    this.text,
    this.asset2,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    asset ?? "",
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text ?? "",
                    style: EduPotDarkTextTheme.headline2(1),
                  ),
                  asset2 != null
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              asset2 ?? "",
                              width: 18,
                              height: 18,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
        ),
      ),
    );
  }
}
