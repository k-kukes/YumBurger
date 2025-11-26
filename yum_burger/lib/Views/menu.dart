import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product added to cart')),
                );
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
        children: [
          MenuItemCard(
            name: "Cheeseburger",
            price: 8.99,
            image: "assets/images/hamburger2.jpg",
            onAddToCart: () {
              setState(() {
                CartController.addCartItem(
                  CartItem(
                    name: "Cheeseburger",
                    quantity: 1,
                    base_price: 8.99,
                    image: "assets/images/hamburger2.jpg",
                  ),
                );
              });
            },
          ),
          MenuItemCard(
            name: "Bacon Burger",
            price: 12.50,
            image: "assets/images/hamburger1.jpg",
            onAddToCart: () {
              setState(() {
                CartController.addCartItem(
                  CartItem(
                    name: "Bacon Burger",
                    quantity: 1,
                    base_price: 12.50,
                    image: "assets/images/hamburger1.jpg",
                  ),
                );
              });
            },
          ),
          MenuItemCard(
            name: "Supreme Burger",
            price: 5.75,
            image: "assets/images/hamburger4.jpg",
            onAddToCart: () {
              setState(() {
                CartController.addCartItem(
                  CartItem(
                    name: "Supreme Burger",
                    quantity: 1,
                    base_price: 5.75,
                    image: "assets/images/hamburger4.jpg",
                  ),
                );
              });
            },
          ),
          MenuItemCard(
            name: "Veggie Burger",
            price: 10.25,
            image: "assets/images/hamburger3.jpg",
            onAddToCart: () {
              CartController.addCartItem(
                CartItem(
                  name: "Veggie Burger",
                  quantity: 1,
                  base_price: 10.25,
                  image: "assets/images/hamburger3.jpg",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
