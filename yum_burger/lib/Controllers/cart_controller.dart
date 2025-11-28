import 'package:flutter/material.dart';

import 'package:yum_burger/Models/cart_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class CartController {

   Future<bool> addCartItem(String burgerId, int quantity) async {
    if (getUsername() == '') {
      print('No user');
      return false;
    }

    try {
      await addCartItemToDB(getUsername(), burgerId, quantity);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

   Future<List<Map<String, dynamic>>> getUserCart() async {
    if (getUsername() == '') {
      print('No user');
      return [];
    } else {
      return await getUserCartFromDB(getUsername());
    }
  }

   Future<void> updateQuantity(String burgerId, int newQuantity) async {
    if (getUsername() == '') {
      return;
    } else {
      await updateCartItemQuantity(getUsername(), burgerId, newQuantity);
    }
  }

   Future<void> removeItem(String burgerId) async {
    if (getUsername() == '') {
      return;
    } else {
      await removeCartItemFromDB(getUsername(), burgerId);
    }
  }

   Future<int> getCartLength() async {
    if (getUsername() == '') {
      return 0;
    } else {
      return await getCartLengthFromDB(getUsername());
    }
  }

   Future<double> getSubtotal() async {
    if (getUsername() == '') {
      return 0;
    } else {
      return await getSubtotalFromDB(getUsername());
    }
  }

   Future<double> getTax() async {
    if (getUsername() == '') {
      return 0;
    } else {
      return await getTaxFromDB(getUsername());
    }
  }

   Future<double> getTotal() async {
    if (getUsername() == '') {
      return 0;
    } else {
      return await getTotalFromDB(getUsername());
    }
  }
}
