import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

Widget indicator(int size, int filled) {
  return Container(
    padding: const EdgeInsets.only(top: 16),
    child: Row(
      children: [
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: EduPotColorTheme.mainBlueGradient(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width:
                      constraints.maxWidth * (size > 0 ? (filled / size) : 1),
                  height: 6,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 6,
                ),
              ],
            );
          }),
        ),
      ],
    ),
  );
}
