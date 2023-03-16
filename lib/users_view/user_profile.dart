// ignore_for_file: library_prefixes, unused_field, unused_import
import 'package:charity_donations/utils/constants.dart' as Constants;
import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:charity_donations/users_view/user_profile_pages/help_center.dart';
import 'package:charity_donations/users_view/user_profile_pages/my_account.dart';
import 'package:charity_donations/users_view/user_profile_pages/notifications.dart';
import 'package:charity_donations/users_view/user_profile_pages/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TmpUserProfile extends StatefulWidget {
  const TmpUserProfile({super.key});

  @override
  State<TmpUserProfile> createState() => _TmpUserProfileState();
}

class _TmpUserProfileState extends State<TmpUserProfile> {
  User? user = FirebaseAuth.instance.currentUser!;
  CharityDonationsModel md = CharityDonationsModel();
  String _firstname = "";
  String _lastname = "";
  String _fullname = "";
  String _email = "";
  String _uid = "";
  String _imgUrl = "";
  String _pronouns = "";
  String _occupation = "";

  late final DocumentSnapshot dbReference;

  void getData() async {
    _uid = user!.uid;
    dbReference =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _firstname = dbReference.get('firstname');
      _lastname = dbReference.get('lastname');
      _fullname = "$_firstname $_lastname";
      _email = dbReference.get('email');
      _imgUrl = dbReference.get('profilePicture');
      _pronouns = dbReference.get('pronouns');
      _occupation = dbReference.get('occupation');
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userProfilePicture(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _fullname,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 45, color: Colors.blueGrey),
                  // style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _occupation,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 25, color: Colors.blueGrey.shade400),
                  // style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _pronouns,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 18, color: Colors.blueGrey.shade400),
                  // style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Constants.myButton(
                  'My Account',
                  Icons.person,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const MyAccount(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Constants.myButton(
                  'Notifications',
                  Icons.notifications,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const Notifications(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Constants.myButton(
                  'Settings',
                  Icons.settings,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const SettingsPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Constants.myButton(
                  'Help Center',
                  Icons.help,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const HelpCenter(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Constants.myButton('Log Out', Icons.exit_to_app, signOut),
                // matButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _userProfilePicture() {
    return CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(
          _imgUrl,
        ));
  }

}
