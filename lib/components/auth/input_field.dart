import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:edupot/utils/auth/validator.dart';

class InputField extends StatelessWidget {
  final String headline;
  final String placeholder;
  final String validatorText;
  final bool isPassword;

  const InputField({
    Key? key,
    required this.headline,
    required this.placeholder,
    required this.validatorText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            headline,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: ShapeDecoration(
            gradient: EduPotColorTheme.mainItemGradient,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 56,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) {
              if (input!.isEmpty) return null;
              if (headline == 'Email') {
                return isValidEmail(input) ? null : validatorText;
              } else if (headline == 'Password') {
                return input.length >= 8 ? null : validatorText;
              }
              return null;
            },
            obscureText: isPassword,
            style: EduPotDarkTextTheme.headline2(1),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: EduPotDarkTextTheme.headline2(0.5),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 2),
            ),
          ),
        ),
      ],
    );
  }
}
