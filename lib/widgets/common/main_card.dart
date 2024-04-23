import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainCard extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final LinearGradient gradient;
  final void Function() onPressed;
  const MainCard(
    this.asset, {
    super.key,
    required this.title,
    required this.description,
    required this.gradient,
    required this.onPressed,
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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 15),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SvgPicture.asset(
                    asset,
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: EduPotDarkTextTheme.headline3.copyWith(fontSize: 16),
                  ),
                  Text(
                    description,
                    style: EduPotDarkTextTheme.headline2(0.6)
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
