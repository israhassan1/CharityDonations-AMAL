// ignore_for_file: deprecated_member_use
// @author: Isra

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: flatButtonStyle,
            // padding: EdgeInsets.all(20),
            // shape:
            //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //    color: Color(0xFFF5F6F9),
            onPressed: () {},
            child: Image.asset('assets/user.png'),
          ),
        ),
      ],
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.blue,
  );

}
