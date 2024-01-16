import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupot/components/auth/input_field.dart';
import 'package:edupot/components/common/authentication.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    AuthService().authStateChanges.listen((User? user) {
      if (user != null) {
        context.replaceRoute(const HomeRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height * 0.085),
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
              InputField(
                headline: 'Email',
                placeholder: 'johndoe@example.com',
                validatorText: "Check your email",
                textChanged: (String value) {},
                validated: (bool value) {},
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      headline: 'First Name',
                      placeholder: "John",
                      validatorText: "",
                      textChanged: (String value) {},
                      validated: (bool value) {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      headline: 'Last Name',
                      placeholder: 'Doe',
                      validatorText: "",
                      textChanged: (String value) {},
                      validated: (bool value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InputField(
                headline: 'Password',
                placeholder: 'Your Password',
                validatorText: "Password must be at least 8 characters",
                isPassword: true,
                textChanged: (String value) {},
                validated: (bool value) {},
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButton(
                    onTap: () => context.pushRoute(const OnboardingRoute()),
                    child: Text(
                      "Registration",
                      style: EduPotDarkTextTheme.headline2(1),
                    ),
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
