import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
