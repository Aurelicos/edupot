import 'package:edupot/components/auth/icon_button.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

Widget buildtitle(String title, String title2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: EduPotDarkTextTheme.headline1,
      ),
      const SizedBox(height: 10),
      Text(
        title2,
        style: EduPotDarkTextTheme.headline2(0.6),
      ),
    ],
  );
}

Widget orDivider() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            color: Colors.white.withOpacity(0.1),
            height: 20,
            thickness: 1,
          ),
        ),
        Text("or", style: EduPotDarkTextTheme.headline2(1)),
        Expanded(
          child: Divider(
            color: Colors.white.withOpacity(0.1),
            height: 20,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}

Widget socialButtons(
    {dynamic Function()? onGoogle, dynamic Function()? onFacebook}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PlatformButton(
          iconPath: "assets/icons/google.svg",
          onPressed: onGoogle,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        PlatformButton(
          iconPath: "assets/icons/facebook.svg",
          onPressed: onFacebook,
          color: EduPotColorTheme.facebookPrimary,
        ),
      ],
    ),
  );
}
