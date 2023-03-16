import 'package:charity_donations/users_view/login_page.dart';
import 'package:charity_donations/users_view/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // show login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showSignUpPage: toggleScreen,
      );
    } else {
      return SignUpPage(
        showLoginPage: toggleScreen,
      );
    }
  }
}
