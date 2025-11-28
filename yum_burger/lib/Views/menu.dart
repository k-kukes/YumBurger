import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/cart_model.dart';

class MenuItemCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final VoidCallback onAddToCart;

  const MenuItemCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("\$${price.toStringAsFixed(2)}"),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {
                onAddToCart();
              },
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, dynamic>> burgerList = [];
  BurgerController burgerController = new BurgerController();
  CartController cartController = new CartController();

  @override
  void initState() {
    super.initState();
    loadBurgers();
  }

  Future<void> loadBurgers() async {
    final burgers = await burgerController.getBurgers();
    setState(() {
      burgerList = burgers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(
        title: Text(
          "Hamburgers",
          style: TextStyle(fontFamily: 'HoltwoodOneSC', color: Colors.brown),
        ),
        backgroundColor: Color(0xFFEEE8DE),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
        children: burgerList.map((burger) {
          return MenuItemCard(
            name: burger['name'],
            price: burger['price'],
            image: burger['image'],
            onAddToCart: () async {
              final result = await cartController.addCartItem(burger['id'], 1);
              if (!result) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please log in to add items'))
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product added to cart.'))
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
