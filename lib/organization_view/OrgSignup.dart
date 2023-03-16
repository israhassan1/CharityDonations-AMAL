// ignore_for_file: file_names

import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:charity_donations/utils/loading.dart';
import 'package:charity_donations/utils/myButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrgSignUp extends StatefulWidget {
  const OrgSignUp({Key? key}) : super(key: key);

  @override
  State<OrgSignUp> createState() => _OrgSignUpState();
}

class _OrgSignUpState extends State<OrgSignUp> {
  final _organisationnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // model reference
  CharityDonationsModel model = CharityDonationsModel();

  bool _isLoading = false;

  Future signUp() async {
    try {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        setState(() {
          _isLoading = true;
        }); // added a loading widget
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) {
          // model.dbAddOrgDetails(_organisationnameController.text.trim(),
          //     _emailController.text.trim(), value.user!.uid
          //     );
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false; // added loading
      });
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
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/amal_bluegrey_logo1.png'),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 45, color: Colors.blueGrey.shade400),
                            // style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _inputOrgName(),
                        const SizedBox(
                          height: 10,
                        ),
                        _inputEmail(),
                        const SizedBox(
                          height: 10,
                        ),
                        _inputPassword(),
                        const SizedBox(
                          height: 10,
                        ),
                        _confirmPassword(),
                        const SizedBox(
                          height: 10,
                        ),
                        _signUpButton(context),
                        const SizedBox(
                          height: 10,
                        ),
                        _returnToSignInPage(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _inputOrgName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: _organisationnameController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueGrey)),
          hintText: 'Enter Organisation Name',
          prefixIcon: const Icon(
            Icons.work,
            color: Colors.blueGrey,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
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

  _inputPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.8))),
          hintText: 'Enter Password',
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: Colors.blueGrey,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  _confirmPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueGrey)),
          hintText: 'Confirm Password',
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: Colors.blueGrey,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  _signUpButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MyButton(
          label: 'Sign Up',
          onTap: signUp,
          height: 50,
          width: 450,
          color: Colors.blueGrey.withOpacity(0.8)),
    );
  }

  _returnToSignInPage(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Already have an account? ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (BuildContext context) {
          //   return const LoginPage(
          //     showSignUpPage: SignUpPage(),
          //   );
          // }));
        },
        child: const Text(
          'Log in',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    ]);
  }
}
