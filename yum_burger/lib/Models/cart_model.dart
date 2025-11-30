import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  Future<void> addBurgerToCartDB(userId, burgerId, CollectionReference users, CollectionReference burgers) async {
    CollectionReference cart = users.doc(userId).collection('Cart');

    await cart.add({
      'item': burgerId,
      'quantity': 1,
      'type': "Burger"
    });
  }
}