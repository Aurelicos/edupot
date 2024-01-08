import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/auth/input_field.dart';
import 'package:edupot/components/common/authentication.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  MainButton(
                    title: "Registration",
                    onTap: () => context.pushRoute(const OnboardingRoute()),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClickableText(
                        firstText: "Already have an account? ",
                        clickableText: "Login",
                        onPressed: () {
                          context.pushRoute(const LoginRoute());
                        },
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
