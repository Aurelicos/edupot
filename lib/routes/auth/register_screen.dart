import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/routes/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/auth/input_field.dart';
import 'package:edupot/components/common/authentication.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 46),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildtitle("Register to EduPot",
                  "Start Your Learning Journey with EduPot"),
              const SizedBox(height: 46),
              socialButtons(),
              const SizedBox(height: 10),
              orDivider(),
              const SizedBox(height: 10),
              const InputField(
                headline: 'Email',
                placeholder: 'johndoe@example.com',
                validatorText: "Check your email",
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: InputField(
                      headline: 'First Name',
                      placeholder: "John",
                      validatorText: "",
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      headline: 'Last Name',
                      placeholder: 'Doe',
                      validatorText: "",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const InputField(
                headline: 'Password',
                placeholder: 'Your Password',
                validatorText: "Password must be at least 8 characters",
                isPassword: true,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          child: Ink(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: EduPotColorTheme.buttonGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: EduPotDarkTextTheme.headline2(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClickableText(
                        firstText: "I'm a new user. ",
                        clickableText: "Registration",
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
