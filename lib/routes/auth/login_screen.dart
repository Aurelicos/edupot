import 'package:edupot/components/auth/clickable_text.dart';
import 'package:edupot/routes/app/home_page.dart';
import 'package:edupot/routes/auth/register_screen.dart';
import 'package:edupot/services/auth.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:edupot/components/common/authentication.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _authException = "Wrong email or password";
  bool _error = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _loading = false;

  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    AuthService().authStateChanges.listen((User? user) {
      if (user != null && mounted) {
        Get.off(const HomePage());
      }
    });
  }

  Future<bool> _login() async {
    try {
      if (_isEmailValid && _isPasswordValid) {
        setState(() {
          _loading = true;
          _error = false;
        });
        await AuthService().signInWithEmailAndPassword(email, password);
        if (AuthService().currentUser != null) {
          return true;
        }
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

  Future<bool> _loginWithGoogle() async {
    try {
      setState(() {
        _loading = true;
        _error = false;
      });
      await AuthService().signInWithGoogle().then((value) {
        if (value == AuthService.userExistsWithCredentialError) {
          setState(() {
            _authException = "User with this email already exists";
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
    return Scaffold(
      backgroundColor: EduPotColorTheme.primaryDark,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height * 0.085,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildtitle("Login to EduPot",
                          "Welcome to EduPot - Your Learning Companion"),
                      const SizedBox(height: 46),
                      InputField(
                        headline: 'Email',
                        placeholder: 'johndoe@example.com',
                        validatorText: "Check your email",
                        textChanged: (text) {
                          setState(() {
                            email = text;
                          });
                        },
                        validated: (bool isValid) {
                          setState(() {
                            _isEmailValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        headline: 'Password',
                        placeholder: 'Your Password',
                        validatorText: "Password must be at least 8 characters",
                        isPassword: true,
                        textChanged: (text) {
                          setState(() {
                            password = text;
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
                                _authException,
                                style:
                                    EduPotDarkTextTheme.headline2(0.4).copyWith(
                                  color: Colors.red.withValues(alpha: 0.75),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      orDivider(),
                      socialButtons(
                        onGoogle: () {
                          _loginWithGoogle().then((value) {
                            if (!value) return;
                            Get.off(const HomePage());
                          });
                        },
                        onFacebook: () {},
                      ),
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
                                decorationColor:
                                    Colors.white.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        onTap: () {
                          _login().then((value) {
                            if (value) {
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
                                "Login",
                                style: EduPotDarkTextTheme.headline2(1),
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ClickableText(
                          firstText: "I'm a new user. ",
                          clickableText: "Registration",
                          onPressed: () {
                            Get.off(const RegisterPage());
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
      ),
    );
  }
}
