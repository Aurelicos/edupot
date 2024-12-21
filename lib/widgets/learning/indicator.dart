import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int base;
  final int progression;
  const Indicator({
    super.key,
    required this.base,
    required this.progression,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: EduPotColorTheme.purplePinkGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: const BoxDecoration(
                        color: EduPotColorTheme.lightGray,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      width: constraints.maxWidth *
                          (progression > 0 ? ((base - progression) / base) : 1),
                      height: 6,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
