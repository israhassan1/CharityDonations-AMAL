// Categeories lists
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> items = [
  'CLOTHING',
  'BAGS AND SHOES',
  'KITCHEN APPLIANCES',
  'FURNITURES',
  'SPORTING GOODS',
  'BOOKS',
  'TOYS',
  'ELECTRONICS'
];

List<String> gender = ['Male', 'Female', 'Other'];

String get clothing_images =>
    'https://i.etsystatic.com/20765435/r/il/ac6f4f/4059499692/il_1588xN.4059499692_7hus.jpg';
String get bags_shoes_image =>
    'https://previews.123rf.com/images/tatyvovchek/tatyvovchek1907/tatyvovchek190700042/128916808-set-of-fashion-accessories-hand-drawn-woman-items-and-accessories-collection-of-bags-shoes-high-heel.jpg?fj=1';
String get kitchen_image =>
    'https://thumbs.dreamstime.com/b/kitchen-utensils-hanging-wall-12427628.jpg';
String get furniture_image =>
    'https://d12mivgeuoigbq.cloudfront.net/magento-media/members-furniture/bigs1-bigsandy/catalog-furniture-custom.jpg';
String get sporting_image =>
    'https://allabout.city/singapore/wp-content/uploads/2020/06/Sports-Facilities-Clubs-Associations.jpg';
String get toy_image =>
    'https://images.unsplash.com/photo-1587654780291-39c9404d746b?ixlib=rb-4.0.3&w=1080&fit=max&q=80&fm=jpg&crop=entropy&cs=tinysrgb';
String get book_image =>
    'https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop';
String get electronics_image =>
    'https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2022/07/electronic-devices.jpg';
String get default_profile_pic => 
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E';


myButton(String text, IconData icon, Function() ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: 450,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Colors.blueGrey,
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
            width: 2),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blueGrey,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    ),
  );
}

myButton1(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      maxLines: 4,
      style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 18,
          fontWeight: FontWeight.normal),
    ),
  );
}
