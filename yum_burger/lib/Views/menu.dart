import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/drink_controller.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
import 'package:yum_burger/Views/MenuItemCard.dart';


class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  BurgerController burgerController = new BurgerController();
  DrinkController drinkController = new DrinkController();
  CartController cartController = new CartController();
  CollectionReference<Object?>? burgerList = null;
  CollectionReference<Object?>? drinksList;

  @override
  void initState() {
    super.initState();
    loadCollections();
  }

  Future<void> loadCollections() async {
    var burgers = await burgerController.getBurgersCollection();
    var drinks = await drinkController.getDrinksCollection();
    setState(() {
      burgerList = burgers;
      drinksList = drinks;
    });
  }


  Widget buildGrid(CollectionReference<Object?>? collection) {
    if (collection == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.55,
          children: snapshot.data!.docs.map((doc) {
            return MenuItemCard(
              name: doc['name'],
              price: doc['price'],
              image: doc['image'],
              onAddToCart: () async {
                String result = await cartController.addToCart(doc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Food + Drinks
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE8DE),
        appBar: AppBar(
          title: const Text(
            "Menu",
            style: TextStyle(
              fontFamily: 'HoltwoodOneSC',
              color: Colors.brown,
            ),
          ),
          backgroundColor: const Color(0xFFEEE8DE),
          bottom: const TabBar(
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.fastfood), text: "Food"),
              Tab(icon: Icon(Icons.local_drink), text: "Drinks"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildGrid(burgerList),
            buildGrid(drinksList),
          ],
        ),
      ),
    );
  }
}

