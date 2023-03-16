// ignore_for_file: unused_field, library_prefixes

import 'dart:typed_data';
import 'package:charity_donations/utils/constants.dart' as Constants;
import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:charity_donations/utils/image_picker.dart';
import 'package:charity_donations/utils/loading.dart';
import 'package:charity_donations/utils/profile_pic_storage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/mybuttons.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text controllers
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _numberController = TextEditingController();
  final _pronounsController = TextEditingController();
  final _occupationController = TextEditingController();
  Uint8List? _image;
  String? selectedValue;

  // model reference
  CharityDonationsModel model = CharityDonationsModel();

  // adding a loading widget
  bool _isLoading = false;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  // Sign up method
  Future signUp() async {
    try {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        setState(() {
          _isLoading = true;
        }); // added a loading widget
        // String photoUrl = await uploadImageToStorage('profilePics', _image!);
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) async {
          // String photoUrl = uploadImageToStorage('profilePics', _image!);
          model.dbAddUserDetails(
            _firstnameController.text.trim(),
            _lastnameController.text.trim(),
            _emailController.text.trim(),
            value.user!.uid,
            await StorageMethods().uploadImageToStorage('profilePics', _image!, false),
            _pronounsController.text,
            selectedValue!,
            _numberController.text,
            _occupationController.text,
            _descriptionController.text,
          );
        });
        // String photoUrl = await uploadImageToStorage('profilePics', _image!);
        // model.dbAddUserProfilePic(photoUrl);
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

  // dispose of controllers when not in use
  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _descriptionController.dispose();
    _numberController.dispose();
    _pronounsController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                        height: 15,
                      ),
                      _userProfilePicture(),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          _inputFirstName(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputLastName(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputEmail(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputPronouns(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputGender(context),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputPhoneNumber(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputOccupation(),
                          const SizedBox(
                            height: 10,
                          ),
                          _inputDescription(),
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  // text field for the users email

  _inputEmail() {
    return TextField(
        controller: _emailController,
        decoration: textDecoration('Enter your email'));
  }

  // textfield for users password

  _inputPassword() {
    return TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: textDecoration('Enter password'));
  }

  _confirmPassword() {
    return TextField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: textDecoration('Confirm password'));
  }

  _returnToSignInPage(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Already a member? ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: widget.showLoginPage,
        child: const Text(
          'Log in',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    ]);
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

  _inputFirstName() {
    return TextField(
        controller: _firstnameController,
        decoration: textDecoration('Enter your firstname'));
  }

  _inputLastName() {
    return TextField(
      controller: _lastnameController,
      decoration: textDecoration('Enter your last name'));
  }

  _userProfilePicture() {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 100,
                backgroundImage: MemoryImage(_image!),
              )
            : CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(Constants.default_profile_pic),
              ),
        Positioned(
            bottom: 15,
            left: 160,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.blueGrey.shade400,
                size: 32,
              ),
              onPressed: selectImage,
            ))
      ],
    );
  }

  _inputPhoneNumber() {
    return TextField(
        controller: _numberController,
        decoration: textDecoration('Enter mobile number: (444)444-4444'));
  }

  _inputOccupation() {
    return TextField(
        controller: _occupationController,
        decoration: textDecoration('Enter your profession'));
  }

  _inputDescription() {
    return TextField(
        controller: _descriptionController,
        maxLines: 3,
        decoration: textDecoration('Tell us about yourself'));
  }

  _inputPronouns() {
    return TextField(
        controller: _pronounsController,
        decoration: textDecoration('Enter your Pronouns (he/him)'));
  }

  InputDecoration textDecoration(String hint) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueGrey)),
      hintText: hint,
      fillColor: Colors.grey[200],
      filled: true,
    );
  }

  _inputGender(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Expanded(
              child: Text(
                'Gender',
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: Constants.gender
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.blueGrey,
        iconDisabledColor: Colors.grey,
        buttonHeight: 55,
        buttonWidth: 450,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.grey.shade200,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        dropdownElevation: 8,
        dropdownDirection: DropdownDirection.left,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }

}
