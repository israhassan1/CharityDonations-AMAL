import 'package:charity_donations/utils/body.dart';
import "package:flutter/material.dart";

class UserProfile extends StatelessWidget {
  // static String routeName = '/Profile';

  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      backgroundColor: Colors.grey[300],
      body: const Body(),
    );
  }
}
