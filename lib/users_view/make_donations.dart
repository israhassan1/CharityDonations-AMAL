// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter, library_prefixes, unused_field

import 'dart:io';
import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:charity_donations/utils/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:charity_donations/utils/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:uuid/uuid.dart';

import '../utils/myButtons.dart';

class MakeDonations extends StatefulWidget {
  const MakeDonations({super.key});

  @override
  State<MakeDonations> createState() => _MakeDonationsState();
}

class _MakeDonationsState extends State<MakeDonations> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _firstname = "";
  String _lastname = "";
  String _fullname = "";
  String _email = "";
  String _uid = "";
  String _profilePic = "";

  double val = 0;
  var uuid = const Uuid();
  bool _isUploading = false;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  User? user = FirebaseAuth.instance.currentUser!;

  CharityDonationsModel model = CharityDonationsModel();

  String? selectedValue;

  final List<File> _image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getData();
    // imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  void getData() async {
    _uid = user!.uid;
    final DocumentSnapshot dbReference =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _firstname = dbReference.get('firstname');
      _lastname = dbReference.get('lastname');
      _fullname = "$_firstname $_lastname";
      _email = dbReference.get('email');
      _profilePic = dbReference.get('profilePicture');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Make Donations', style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: _image.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      !_isUploading ? chooseImage() : null;
                                    },
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_image[index - 1]),
                                          fit: BoxFit.cover)),
                                );
                        }),
                    _isUploading
                        ? Center(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'uploading...',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircularProgressIndicator(
                                value: val,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blueGrey),
                              )
                            ],
                          ))
                        : Container(),
                  ],
                ),
                const SizedBox(height: 10),
                _inputItemTitle(),
                const SizedBox(height: 10),
                _categoriesMenu(context),
                const SizedBox(height: 10),
                _inputItemDescription(),
                const SizedBox(height: 10),
                _uploadButton(context)
              ],
            ),
          ),
        ));
  }

  // function that allows you to pick images from gallery
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    try {
      File? file = File(pickedFile!.path);
      setState(() {
        _image.add(file);
      });
    } catch (error) {
      const Text('File empty');
    }
  }

  Future uploadFile() async {
    List<String> imageUrlList = [];
    int i = 1;
    var v1 = uuid.v1();
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$selectedValue/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageUrlList.add(value);
          i++;
        });
      });
    }
    model.dbDonationDetails(_fullname, _nameController.text, _uid,
        selectedValue!, _descriptionController.text, imageUrlList, _profilePic, v1);
  }

  _inputItemTitle() {
    return TextField(
        controller: _nameController,
        decoration: textDecoration('Enter item title'));
  }

  _inputItemDescription() {
    return TextField(
        controller: _descriptionController,
        maxLines: 6,
        decoration: textDecoration('Enter items description'));
  }

  _uploadButton(context) {
    if (kDebugMode) {
      print("Before upload is clicked $_isUploading");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MyButton(
          label: 'Upload',
          onTap: () {
            if (_nameController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty &&
                selectedValue != null) {
              setState(() {
                _isUploading = true;
                if (kDebugMode) {
                  print("After upload is clicked $_isUploading");
                }
              });
              uploadFile().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const LandingPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Fill in the empty fields'),
                    );
                  });
            }
          },
          height: 50,
          width: 450,
          color: Colors.blueGrey.withOpacity(0.8)),
    );
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

  //drop down menu for categories
  _categoriesMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Expanded(
              child: Text(
                'Choose category',
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
        items: Constants.items
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
