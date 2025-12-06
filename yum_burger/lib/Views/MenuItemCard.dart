import 'dart:convert';

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
          image.startsWith('assets/')
              ? Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : Image.memory(
            base64Decode(image),
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
              onPressed: onAddToCart,
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
