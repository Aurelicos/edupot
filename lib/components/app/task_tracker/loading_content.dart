import 'package:edupot/utils/common/shimmer.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

Widget projectLoadingUI() {
  return SizedBox(
    height: 175,
    child: Shimmer(
      linearGradient: EduPotColorTheme.shimmerGradient,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, snapshot) {
            return ShimmerLoading(
              isLoading: true,
              child: Container(
                width: 225,
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: EduPotColorTheme.primaryBlueDark,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
    ),
  );
}

Widget loadingUI() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 25),
        child: Text("Exams", style: EduPotDarkTextTheme.headline4),
      ),
      _buildLoading(),
      const Padding(
        padding: EdgeInsets.only(top: 25),
        child: Text("Tasks", style: EduPotDarkTextTheme.headline4),
      ),
      _buildLoading(),
    ],
  );
}

Widget _buildLoading() {
  return SizedBox(
    height: 128,
    child: Shimmer(
      linearGradient: EduPotColorTheme.shimmerGradient,
      child: Column(
        children: [
          for (int i = 0; i < 2; i++)
            ShimmerLoading(
              isLoading: true,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                height: 54,
                decoration: BoxDecoration(
                  color: EduPotColorTheme.primaryBlueDark,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
