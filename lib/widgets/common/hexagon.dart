import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Hexagon extends StatelessWidget {
  final String title;

  final double height;
  final double width;

  const Hexagon({
    super.key,
    required this.title,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/hexagon.svg",
          height: height,
          width: width,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: height * 0.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
