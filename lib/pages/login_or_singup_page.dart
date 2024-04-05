import 'package:flutter/material.dart';
import 'package:wisewave/screens/login_screen.dart';
import 'package:wisewave/screens/signup_screen.dart';

class LoginOrSignupPage extends StatefulWidget {
  const LoginOrSignupPage({super.key});

  @override
  State<LoginOrSignupPage> createState() => _LoginOrSignupPageState();
}

class _LoginOrSignupPageState extends State<LoginOrSignupPage> {

  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginPage(
        onTap: toggleScreen,
      );
    } else {
      return SignupPage(
        onTap: toggleScreen,
      );
      //return const Placeholder();
    }
  }
}