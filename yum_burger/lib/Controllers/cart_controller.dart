import 'package:flutter/material.dart';

import 'package:yum_burger/Models/cart_model.dart';

class CartController {
  static List<CartItem> cartItems = [
    CartItem(name: 'Hamburger 1', quantity: 2, base_price: 12.99, image: "https://via.placeholder.com/150"),
    CartItem(name: 'Hamburger 2', quantity: 5, base_price: 2.99, image: "https://via.placeholder.com/150"),
  ];

  static List<CartItem> getCartItems() => cartItems;
  static int getCartLength() => cartItems.length;

  static void addCartItem(CartItem item) {
    int currentIndex = cartItems.indexWhere((cartItem) => cartItem.name == item.name);
    if (currentIndex != -1) {
      cartItems[currentIndex].quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
  }

  static void removeCartItem(CartItem item) {
    cartItems.remove(item);
  }

  static void increaseQuantity(int index) {
    cartItems[index].quantity++;
  }

  static void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
  }

  static double getSubtotal() {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].base_price * cartItems[i].quantity;
    }
    return total;
  }

  static double getTax() {
    return getSubtotal() * 0.15;
  }

  static double getTotal() {
    return getSubtotal() + getTax();
  }
}
