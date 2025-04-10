import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/routes/app/home_page.dart';
import 'package:edupot/routes/auth/login_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/components/common/authentication.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _exception = "Please fill all the fields";
  bool _error = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _loading = false;

  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    AuthService().authStateChanges.listen((User? user) {
      if (user != null && mounted) {
        Get.off(const HomePage());
      }
    });
  }

  Future<dynamic> _register() async {
    if (!_isEmailValid || !_isPasswordValid) return false;

    if (firstName.isEmpty || lastName.isEmpty) {
      _updateState(loading: false, error: true);
      return false;
    }

    _updateState(loading: true, error: false);

    var result = await AuthService().createUserWithEmailAndPassword(
      email,
      password,
      firstName,
      lastName,
    );

    if (result is String || result != true) {
      _updateState(loading: false, error: true);
      return result is String ? result : false;
    }

    _updateState(loading: false, error: false);
    return true;
  }

  void _updateState({required bool loading, required bool error}) {
    setState(() {
      _loading = loading;
      _error = error;
    });
  }

  Future<bool> _loginWithGoogle() async {
    try {
      setState(() {
        _loading = true;
        _error = false;
      });
      await AuthService().signInWithGoogle().then((value) {
        if (value == AuthService.userExistsWithCredentialError) {
          setState(() {
            _exception = "User with this email already exists";
          });
          return false;
        }
      });
      if (AuthService().currentUser != null) {
        return true;
      }
    } on FirebaseAuthException {
      setState(() {
        _error = true;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
    setState(() {
      _error = true;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
              socialButtons(
                onFacebook: () {},
                onGoogle: () {
                  _loginWithGoogle().then((value) {
                    if (!value) return;
                    Get.off(const HomePage());
                  });
                },
              ),
              const SizedBox(height: 10),
              orDivider(),
              const SizedBox(height: 10),
              InputField(
                headline: 'Email',
                placeholder: 'johndoe@example.com',
                validatorText: "Check your email",
                textChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
                validated: (bool isValid) {
                  setState(() {
                    _isEmailValid = isValid;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      headline: 'First Name',
                      placeholder: "John",
                      textChanged: (String value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      headline: 'Last Name',
                      placeholder: 'Doe',
                      textChanged: (String value) {
                        setState(() {
                          lastName = value;
                        });
                      },
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
                textChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
                validated: (bool isValid) {
                  setState(() {
                    _isPasswordValid = isValid;
                  });
                },
              ),
              _error
                  ? Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _exception,
                        style: EduPotDarkTextTheme.headline2(0.4).copyWith(
                          color: Colors.red.withValues(alpha: 0.75),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButton(
                    onTap: () {
                      _register().then((value) {
                        if (value is String &&
                            value == AuthService.emailInUseError) {
                          return _exception = "Email already in use";
                        }
                        if (value is bool && value == true) {
                          userProvider.firstName = firstName;
                          userProvider.lastName = lastName;
                          userProvider.email = email;
                          userProvider.displayName = "$firstName $lastName";
                          Get.to(const HomePage());
                        }
                      });
                    },
                    child: _loading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : Text(
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
                          Get.to(const LoginPage());
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
