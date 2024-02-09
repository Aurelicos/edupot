import 'package:edupot/utils/common/time_format.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/haxagon.dart';
import 'package:flutter/material.dart';

class GridProject extends StatelessWidget {
  final List<dynamic> itemArray;
  const GridProject({super.key, required this.itemArray});

  @override
  Widget build(BuildContext context) {
    final List<LinearGradient> gradientList = [
      EduPotColorTheme.mainBlueGradient(opacity: 0.55),
      EduPotColorTheme.purpleCardGradient,
      EduPotColorTheme.lightGrayCardGradient,
      EduPotColorTheme.darkGrayCardGradient,
    ];
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 0.8,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemArray.length,
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                gradient: gradientList[i % 4],
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hexagon(
                    title: itemArray[i]["iconTitle"],
                    height: 24,
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatTitle(itemArray[i]["title"]),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        formatTime(itemArray[i]["finalDate"]),
                        style: EduPotDarkTextTheme.headline2(0.6).copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${itemArray[i]["finished"]} out of ${itemArray[i]["tasks"].length}",
                    style: EduPotDarkTextTheme.headline3,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String formatTitle(String title) {
    if (title.length >= 11) {
      return "${title.substring(0, 9)}...";
    }
    return title;
  }
}
