import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String label;
  final String image;
  final Function() onTap;
  const ImageButton(
      {Key? key, required this.label, required this.onTap, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.blueGrey,
      child: Column(
          // alignment: Alignment.center,
          children: <Widget>[
            Ink.image(
              image: NetworkImage(image),
              height: 240,
              fit: BoxFit.fill,
              child: InkWell(
                onTap: onTap,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
                // backgroundColor: Colors.lightBlueAccent
              ),
            )
          ]),
    );
  }
}
