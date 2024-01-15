import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/auth/input_field.dart';
import 'package:edupot/components/common/authentication.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height * 0.075,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildtitle("Login to EduPot",
                          "Welcome to EduPot - Your Learning Companion"),
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
                      orDivider(),
                      socialButtons(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style:
                                  EduPotDarkTextTheme.headline2(0.4).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    MainButton(
                      title: "Login",
                      onTap: () {},
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClickableText(
                        firstText: "I'm a new user. ",
                        clickableText: "Registration",
                        onPressed: () {
                          context.popRoute(const RegisterRoute());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
