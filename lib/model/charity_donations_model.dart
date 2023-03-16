// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CharityDonationsModel {
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late final _uid;
  final auth = FirebaseAuth.instance;
  late User currentUser;
  late firebase_storage.Reference ref;
  late CollectionReference imgRef;
  var uuid = const Uuid();

  getCurrentUser() {
    currentUser = auth.currentUser!;
    if (auth.currentUser != null) {
      // User is signed in
      _uid = FirebaseAuth.instance.currentUser!.uid.toString();
    }
    return _uid;
  }

  // Add user details to the database and store their userID
  Future dbAddUserDetails(
    String firstname,
    String lastName,
    String email,
    String docId,
    String url,
    String pronouns,
    String gender,
    String number,
    String occupation,
    String description,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(docId).set({
      'firstname': firstname,
      'lastname': lastName,
      'email': email,
      'profilePicture': url,
      'pronouns': pronouns,
      'gender': gender,
      'aboutMe': description,
      'phoneNumber': number,
      'occupation': occupation,
      'userId': getCurrentUser(),
    });
  }

  // Add user profile to the database and store their userID
  Future dbAddUserProfile(
      String url,
      String pronouns,
      String gender,
      String number,
      String occupation,
      String description,
      String docId) async {
    await FirebaseFirestore.instance
        .collection('usersProfiles')
        .doc(docId)
        .set({
      'profilePicture': url,
      'pronouns': pronouns,
      'gender': gender,
      'userId': getCurrentUser(),
      'aboutMe': description,
      'phoneNumber': number,
      'occupation': occupation
    });
  }

  // Add organizations details to the database and store their userID
  Future dbAddOrgDetails(String orgName, String email, String docId) async {
    await FirebaseFirestore.instance
        .collection('organizations')
        .doc(docId)
        .set({
      'orgName': orgName,
      'email': email,
      'userId': getCurrentUser(),
    });
  }

  Future dbDonationDetails(
      String fullname,
      String itemName,
      String docId,
      String category,
      String itemDescription,
      List<String> url,
      String profilePic,
      String uuid) async {
    await FirebaseFirestore.instance.collection('donations').doc(uuid).set({
      'fullname': fullname,
      'itemName': itemName,
      'category': category,
      'description': itemDescription,
      'url': url,
      'profilePicture': profilePic,
      'userId': docId,
      'datePublished': DateTime.now()
    });
  }

  Future dbUpdateProfilePic(String url) async {
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(getCurrentUser())
        .update({'profilePicture': url})
        .then((value) => print("Updated"))
        .catchError((onError) => print('Update failed: $onError'));
  }

  // Future dbAddUserProfile(
  //   String pic, String phoneNumber, String aboutMe, String gender, String proffession) async {
  //     await FirebaseFirestore.instance.collection('users').add('data':pic,);
  //   }
}
