import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String headline;
  final String placeholder;
  final bool isPassword;

  const InputField({
    Key? key,
    required this.headline,
    required this.placeholder,
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
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [Color(0x72242547), Color(0xFF242547)],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: TextField(
            obscureText: isPassword,
            style: EduPotDarkTextTheme.headline2(1),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: EduPotDarkTextTheme.headline2(0.5),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 5),
            ),
          ),
        ),
      ],
    );
  }
}
