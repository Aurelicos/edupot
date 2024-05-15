import 'package:edupot/services/shared_preferences_service.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainCard extends StatefulWidget {
  final String asset;
  final String title;
  final String description;
  final LinearGradient gradient;
  final void Function()? onPressed;
  final bool icon;
  final bool background;
  final void Function(bool value)? onSwitch;

  const MainCard(
    this.asset, {
    super.key,
    required this.title,
    required this.description,
    required this.gradient,
    this.onPressed,
    this.icon = true,
    this.background = true,
    this.onSwitch,
  });

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  bool value = SharedPreferencesService.value("bool_2fa_auth");

  @override
  void initState() {
    super.initState();
    if (widget.onSwitch != null) {
      widget.onSwitch!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
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
              widget.background
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            gradient: widget.gradient,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SvgPicture.asset(
                          widget.asset,
                          width: 25,
                          height: 25,
                        ),
                      ],
                    )
                  : SvgPicture.asset(
                      widget.asset,
                      width: 50,
                      height: 50,
                    ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: EduPotDarkTextTheme.headline3.copyWith(fontSize: 16),
                  ),
                  Text(
                    widget.description,
                    style: EduPotDarkTextTheme.headline2(0.6)
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              if (widget.icon && widget.onSwitch == null)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              if (widget.onSwitch != null && !widget.icon)
                Switch(
                  value: value,
                  onChanged: (switchValue) {
                    SharedPreferencesService.setValue(
                        "bool_2fa_auth", switchValue);
                    setState(() {
                      value = switchValue;
                      widget.onSwitch!(value);
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: EduPotColorTheme.projectBlue,
                  inactiveTrackColor: EduPotColorTheme.primaryDark,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
