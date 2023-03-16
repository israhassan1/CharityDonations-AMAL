// ignore_for_file: iterable_contains_unrelated_type

import 'package:charity_donations/model/charity_donations_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/loading.dart';
import '../../utils/post_card.dart';

class Furnitures extends StatefulWidget {
  const Furnitures({super.key});

  @override
  State<Furnitures> createState() => _FurnituresState();
}

class _FurnituresState extends State<Furnitures> {
  User? user = FirebaseAuth.instance.currentUser!;
  CharityDonationsModel model = CharityDonationsModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllTasksStreamSnapShots() {
    return FirebaseFirestore.instance
        .collection('donations')
        .where('category', isEqualTo: "FURNITURES")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Furnitures', style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: StreamBuilder(
          stream: getAllTasksStreamSnapShots()
              .skipWhile((element) => element.docs.contains(user!.uid)),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loading(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('This category is empty'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ));
          },
        ));
  }
}
