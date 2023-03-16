// ignore_for_file: deprecated_member_use
// @author: Isra
import 'package:charity_donations/utils/profile_pic.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProfilePic(), const SizedBox(height: 20), ProfileMenu()],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          style: flatButtonStyle,
          // padding: const EdgeInsets.all(20),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // color: const Color.fromARGB(255, 209, 202, 202),
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "My Account",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const Icon(Icons.person),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          style: flatButtonStyle,
          // padding: const EdgeInsets.all(20),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // color: const Color.fromARGB(255, 209, 202, 202),
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const Icon(Icons.notifications),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: textButton(context),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          style: flatButtonStyle,
          // padding: const EdgeInsets.all(20),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // color: const Color.fromARGB(255, 209, 202, 202),
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Log Out",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const Icon(Icons.logout),
            ],
          ),
        ),
      ),
    ]);
  }

  TextButton textButton(BuildContext context) {
    return TextButton(
        style: flatButtonStyle,
        // padding: const EdgeInsets.all(20),
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // color: const Color.fromARGB(255, 209, 202, 202),
        onPressed: () {},
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                "Help Center",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const Icon(Icons.help_center),
          ],
        ),
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
