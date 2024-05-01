import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetModal extends StatelessWidget {
  const NoInternetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/no_internet_background.svg',
                  height: 100,
                ),
                SvgPicture.asset(
                  'assets/icons/no_internet.svg',
                  height: 30,
                ),
              ],
            ),
          ),
          Text(
            'No Internet Connection',
            style: EduPotDarkTextTheme.headline1.copyWith(fontSize: 24),
          ),
          Text(
            'Oops it seems you’re not connected to the internet. Please check your connection and try again.',
            textAlign: TextAlign.center,
            style: EduPotDarkTextTheme.headline2(0.6),
          ),
        ],
      ),
    );
  }
}
