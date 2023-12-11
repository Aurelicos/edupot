import 'package:edupot/components/auth/icon_button.dart';
import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/auth/input_field.dart';

class LoginScreen extends StatelessWidget {
  final String title;
  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: EduPotDarkTextTheme.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome to EduPot - Your Learning Companion",
              style: EduPotDarkTextTheme.headline2(0.6),
            ),
            const SizedBox(height: 46),
            const InputField(
              headline: 'Email',
              placeholder: 'johndoe@example.com',
              validatorText: "Check your email",
            ),
            const SizedBox(height: 20),
            const InputField(
              headline: 'Password',
              placeholder: 'Your Password',
              validatorText: "Password must be at least 8 characters",
              isPassword: true,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white.withOpacity(0.1),
                      height: 20,
                      thickness: 1,
                      indent: 0,
                      endIndent: 20,
                    ),
                  ),
                  Text(
                    "or",
                    style: EduPotDarkTextTheme.headline2(1),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white.withOpacity(0.1),
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlatformButton(
                    iconPath: "assets/icons/google.svg",
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  PlatformButton(
                    iconPath: "assets/icons/facebook.svg",
                    onPressed: () {},
                    color: EduPotColorTheme.facebookPrimary,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password?",
                    style: EduPotDarkTextTheme.headline2(0.4).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: EduPotColorTheme.buttonGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(
                                "Login",
                                style: EduPotDarkTextTheme.headline2(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
