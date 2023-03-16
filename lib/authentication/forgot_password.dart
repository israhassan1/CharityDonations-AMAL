// ignore_for_file: use_build_context_synchronously

import 'package:charity_donations/authentication/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/mybuttons.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool linkIsSent = false;

  _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      const snackBar = SnackBar(
        backgroundColor: Colors.blueGrey,
        elevation: 10,
        content: Text(
          'Password reset link sent! Check your email',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_rounded,
              size: 100,
              color: Colors.blueGrey,
            ),
            Text(
              'Trouble Logging In?',
              style: GoogleFonts.bebasNeue(
                  fontSize: 30, color: Colors.black.withOpacity(0.8)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Enter your email and we'll send you a link to get back into your account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            _inputEmail(),
            const SizedBox(
              height: 15,
            ),
            _resetLoginButton(context),
            const SizedBox(
              height: 15,
            ),
            _returntoLogin()
          ],
        )),
      ),
    );
  }

  _inputEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueGrey)),
          hintText: 'Enter Email',
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.blueGrey,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  _resetLoginButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MyButton(
          label: 'Send Login Link',
          onTap: () => _resetPassword(context),
          height: 50,
          width: 400,
          color: Colors.blueGrey.withOpacity(0.8)),
    );
  }

  _returntoLogin() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: TextButton(
            child: const Text(
              "Back to Login",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              // clear previous screens up untill the AuthPage
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const AuthPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ));
  }
}
