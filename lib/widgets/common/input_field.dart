import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/description_text.dart';
import 'package:flutter/material.dart';
import 'package:edupot/utils/auth/validator.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String headline;
  final String placeholder;
  final bool isPassword;
  final Function(String) textChanged;

  final Function(bool)? validated;
  final String? validatorText;

  final int? maxLength;
  final int? maxLines;
  final double? height;

  final String? initialValue;

  const InputField({
    super.key,
    required this.headline,
    required this.placeholder,
    required this.textChanged,
    this.validatorText,
    this.isPassword = false,
    this.validated,
    this.maxLength,
    this.maxLines = 1,
    this.height,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DescriptionText(text: headline),
        Container(
          decoration: ShapeDecoration(
            gradient: EduPotColorTheme.mainItemGradient,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: height != null ? 8 : 2,
          ),
          height: height ?? 56,
          child: Padding(
            padding: maxLength != null
                ? const EdgeInsets.symmetric(vertical: 5)
                : EdgeInsets.zero,
            child: TextFormField(
              maxLength: maxLength,
              maxLines: maxLines,
              initialValue: initialValue,
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
                if (validatorText == null) return null;
                bool isValid = (headline == 'Email' && isValidEmail(input)) ||
                    (headline == 'Password' && input.length >= 8);
                return isValid ? null : validatorText ?? '';
              },
              obscureText: isPassword,
              style: EduPotDarkTextTheme.headline2(1),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[\n]'))
              ],
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: EduPotDarkTextTheme.headline2(0.5),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
