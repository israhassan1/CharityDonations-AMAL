// ignore_for_file: library_prefixes

import 'package:charity_donations/users_view/category_pages.dart/books.dart';
import 'package:charity_donations/users_view/category_pages.dart/electronics.dart';
import 'package:charity_donations/users_view/category_pages.dart/furnitures.dart';
import 'package:charity_donations/users_view/category_pages.dart/kitchen_appliances.dart';
import 'package:charity_donations/users_view/category_pages.dart/sporting_goods.dart';
import 'package:charity_donations/users_view/category_pages.dart/toys.dart';
import 'package:charity_donations/utils/constants.dart' as Constants;
import 'package:flutter/material.dart';

import '../utils/image_button.dart';
import 'category_pages.dart/bags_and_shoes.dart';
import 'category_pages.dart/clothings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
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
        title: const Text('Search', style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _clothingAndShoesRow(context),
            _kitchenAndFurnitureRow(context),
            _sportsAndToysRow(context),
            _booksAndElectronicsRow(context)
          ],
        ),
      ),
    );
  }

  _clothingAndShoesRow(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Flexible(
            child: ImageButton(
              label: 'Clothings', 
              onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Clothings(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ), 
              image: Constants.clothing_images
            ),
          ),
    
          Flexible(
            child: ImageButton(
              label: 'Bags and Shoes', 
              onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const BagsAndShoes(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ), 
              image: Constants.bags_shoes_image
            ),
          )
        ],
      ),
    );
  }

  _kitchenAndFurnitureRow(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Flexible(
            child: ImageButton(
                label: 'Kitchen Appliances',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const KitchenAppliances(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.kitchen_image
              ),
          ),
          Flexible(
            child: ImageButton(
                label: 'Furnitures',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Furnitures(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.furniture_image
              ),
          )
        ],
      ),
    );
  }

  _sportsAndToysRow(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Flexible(
            child: ImageButton(
                label: 'Sporting Goods',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const SportingGoods(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.sporting_image
              ),
          ),
          Flexible(
            child: ImageButton(
                label: 'Toys',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Toys(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.toy_image
              ),
          )
        ],
      ),
    );
  }

  _booksAndElectronicsRow(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Flexible(
            child: ImageButton(
                label: 'Books',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Books(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.book_image
              ),
          ),
          Flexible(
            child: ImageButton(
                label: 'Electronics',
                onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Electronics(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                image: Constants.electronics_image
              ),
          )
        ],
      ),
    );
  }


}