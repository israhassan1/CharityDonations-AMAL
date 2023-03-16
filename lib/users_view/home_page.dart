// ignore_for_file: unused_field, dead_code, unused_label
import 'package:charity_donations/utils/loading.dart';
import 'package:charity_donations/utils/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Amal', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('donations')
              .where('userId', isNotEqualTo: user!.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loading(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ));
          },
        )
    );
  }
}
