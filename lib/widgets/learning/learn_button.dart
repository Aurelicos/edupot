import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LearnButton extends StatelessWidget {
  final String iconName;

  const LearnButton(this.iconName, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 2 - 30;
    return Container(
        width: size > 250 ? 250 : size,
        height: size > 250 ? 250 : size,
        decoration: ShapeDecoration(
          color: EduPotColorTheme.primaryBlueDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x7FFFFFFF),
              blurRadius: 20,
              offset: Offset(15, 19),
              spreadRadius: -12,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/$iconName.svg",
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 10),
            const Text(
              'Learn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ));
  }
}
