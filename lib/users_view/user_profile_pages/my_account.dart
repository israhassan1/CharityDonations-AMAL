// ignore_for_file: library_prefixes

import 'dart:typed_data';

import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:charity_donations/utils/image_picker.dart';
import 'package:charity_donations/utils/loading.dart';
import 'package:charity_donations/utils/myButtons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charity_donations/utils/constants.dart' as Constants;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Uint8List? _image;
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
  String _description = "";

  late final DocumentSnapshot dbReference;
  late List<String> photos;

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
      _description = dbReference.get('aboutMe');
    });
    // print(_imgUrl);
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

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _userProfilePicture(),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _fullname,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 28, color: Colors.blueGrey),
                          ),
                          Text(_email,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  color: Colors.blueGrey.shade400)),
                          Text(_occupation,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  color: Colors.blueGrey.shade400)),
                          Text(_pronouns,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  color: Colors.blueGrey.shade400))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Constants.myButton1(_description),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                      label: 'Edit Profile',
                      onTap: () {},
                      height: 45,
                      width: 450,
                      color: Colors.blueGrey.shade400),
                    
                  Container(
                    // child: _getStream()
                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('donations')
                    //       .where('userId', isEqualTo: user!.uid)
                    //       .snapshots(),
                    //   builder: (context,
                    //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    //           snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Center(
                    //         child: Loading(),
                    //       );
                    //     }
                    //     return ListView.builder(
                    //         itemCount: snapshot.data!.docs.length,
                    //         itemBuilder: (context, index) => PostCard(
                    //               snap: snapshot.data!.docs[index].data(),
                    //             ));
                    //   },
                    // ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  _userProfilePicture() {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(_image!),
              )
            : CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(_imgUrl),
              ),
        Positioned(
            bottom: -3,
            left: 75,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.blueGrey.shade500,
                size: 25,
              ),
              onPressed: selectImage,
            ))
      ],
    );
  }

  // ignore: unused_element
  _getStream(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('userId', isEqualTo: user!.uid)
          .snapshots(),
      builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loading(),
              );
            }
            return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          primary: false,
          shrinkWrap: true,
          children: List<Widget>.generate(
            snapshot.data!.docs.length, // same length as the data
            (index) => Text(
              snapshot.data!.docs[index].toString(),
                  // .fullName, // Use the fullName property of each item
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        );
            // return ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     itemBuilder: (context, index) => PostCard(
            //       snap: snapshot.data!.docs[index].data(),
            //     ));
          },
    );
  }

}