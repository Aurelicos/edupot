import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:edupot/utils/auth/validator.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String headline;
  final String placeholder;
  final String validatorText;
  final bool isPassword;
  final Function(String) textChanged;
  final Function(bool)? validated;

  final int? maxLength;
  final int? maxLines;

  const InputField(
      {super.key,
      required this.headline,
      required this.placeholder,
      required this.validatorText,
      required this.textChanged,
      this.isPassword = false,
      this.validated,
      this.maxLength,
      this.maxLines});

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
        const SizedBox(height: 5),
        Container(
          decoration: ShapeDecoration(
            gradient: EduPotColorTheme.mainItemGradient,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          height: 56,
          child: TextFormField(
            maxLength: maxLength,
            maxLines: maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (input) {
              bool isValid = false;
              if (headline == 'Email') {
                isValid = isValidEmail(input);
              } else if (headline == 'Password') {
                isValid = input.length >= 8;
              }
              textChanged(input);
              validated != null ? validated!(isValid) : null;
            },
            validator: (input) {
              if (input!.isEmpty) return null;
              bool isValid = (headline == 'Email' && isValidEmail(input)) ||
                  (headline == 'Password' && input.length >= 8);
              return isValid ? null : validatorText;
            },
            obscureText: isPassword,
            style: EduPotDarkTextTheme.headline2(1),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[\n]'))],
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
