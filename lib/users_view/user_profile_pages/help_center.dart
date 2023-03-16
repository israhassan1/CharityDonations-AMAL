
import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Help Center'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
          child: Text(
        'Help Center Screen',
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}