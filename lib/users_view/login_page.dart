import 'package:charity_donations/authentication/forgot_password.dart';
import 'package:charity_donations/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/curve_clippers.dart';
import '../utils/mybuttons.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({Key? key, required this.showSignUpPage,}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late bool _isLoading = false;

  // sign in with email and password
  Future signIn() async {
    try {
      setState(() {
        _isLoading = true; // added loading
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
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

  // dispose of controllers when not in use
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            body: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _backgroundImage(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Welcome,',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 52, color: Colors.black.withOpacity(0.8)),
                        // style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Sign in to continue!',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade400),
                      ),
                    ),
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
                    _logInButton(context), // login button
                    const SizedBox(
                      height: 15,
                    ),
                    _signUpButton(context), // signup button
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // _signUpOrgButton(context), // organization
                    _forgotPassword(),
                  ]),
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

  _logInButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MyButton(
          label: 'Sign In',
          onTap: signIn,
          height: 50,
          width: 400,
          color: Colors.blueGrey.withOpacity(0.8)),
    );
  }

  _signUpButton(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Not a member? ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: 
        // (){
        //   Navigator.pushReplacement(
        //         context,
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation1, animation2) =>
        //               const SignUpPage(),
        //           transitionDuration: Duration.zero,
        //           reverseTransitionDuration: Duration.zero,
        //         ),
        //       );
        // },
        widget.showSignUpPage,
        child: const Text(
          'Register now',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    ]);
  }

  // sign up as an organiztion
  // _signUpOrgButton(context) {
  //   return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //     const Text(
  //       'Signing up as an organization? ',
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //     GestureDetector(
  //       onTap: () {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (BuildContext context) {
  //           return const OrgSignUp();
  //         }));
  //       },
  //       child: const Text(
  //         'Register now',
  //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
  //       ),
  //     ),
  //   ]);
  // }

  _backgroundImage() {
    Size size = MediaQuery.of(context).size;
    const double appPadding = 20.0; //20.0
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: size.height * .53, // .53
        width: size.width,
        color: Colors.blueGrey.withOpacity(0.8),
        child: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: appPadding / 2, vertical: appPadding * 3),
          child: Center(
            child: Image(
              image: AssetImage('assets/amal_white_logo5.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _forgotPassword() {
    return Center(
      child: TextButton(
        child: const Text(
          "Forgot Password?",
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const ForgotPasswordPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
    );
  }

}
