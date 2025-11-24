import 'package:flutter/material.dart';

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
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("\$${price.toStringAsFixed(2)}"),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2, // 👈 two cards per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3/4, // 👈 controls card width vs height
        children: [
          MenuItemCard(
            name: "Cheeseburger",
            price: 8.99,
            image: "assets/images/cheeseburger.png",
            onAddToCart: () {},
          ),
          MenuItemCard(
            name: "Bacon Burger",
            price: 12.50,
            image: "assets/images/pizza.png",
            onAddToCart: () {},
          ),
          MenuItemCard(
            name: "Supreme Burger",
            price: 5.75,
            image: "assets/images/hamburger3.png",
            onAddToCart: () {},
          ),
          MenuItemCard(
            name: "Veggie Burger",
            price: 10.25,
            image: "assets/images/hamburger4.png",
            onAddToCart: () {},
          ),
        ],
      ),
    );
  }
}
