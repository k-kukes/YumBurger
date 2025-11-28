import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yum_burger/Models/burger_model.dart';

CollectionReference carts = FirebaseFirestore.instance.collection('Carts');
CollectionReference burgers = FirebaseFirestore.instance.collection('Burgers');

Future<void> addCartItemToDB(
  String username,
  String burgerId,
  int quantity,
) async {
  try {
    var userCart = carts.doc(username);
    var currentCart = await userCart.get();
    var burger = burgers.doc(burgerId);

    if (!currentCart.exists) {
      await userCart.set({
        'username': username,
        'items': [
          {'burger': burger, 'quantity': quantity},
        ],
      });
    } else {
      List items = currentCart['items'];
      int index = items.indexWhere((item) => item['burger'].id == burgerId);
      if (index > -1) {
        items[index]['quantity'] += quantity;
      } else {
        items.add({'burger': burger, 'quantity': quantity});
      }

      await userCart.update({'items': items});
    }
  } catch (error) {
    print('Error adding to cart');
  }
}

Future<List<Map<String, dynamic>>> getUserCartFromDB(String username) async {
  try {
    var userCart = await carts.doc(username).get();

    if (!userCart.exists) {
      return [];
    }

    List items = userCart['items'];
    List<Map<String, dynamic>> cartItems = [];

    for (var item in items) {
      var burgerInCart = item['burger'];
      String burgerId = burgerInCart.id;

      Map<String, dynamic>? burger = await getBurgerByIdFromDB(burgerId);

      if (burger != null) {
        cartItems.add({
          'burgerId': burgerId,
          'name': burger['name'],
          'description': burger['description'],
          'price': burger['price'],
          'image': burger['image'],
          'quantity': item['quantity'],
        });
      }
    }
    return cartItems;
  } catch (error) {
    print('Cant get user cart');
    return [];
  }
}

Future<void> updateCartItemQuantity(
  String username,
  String burgerId,
  int newQuantity,
) async {
  try {
    var cart = await carts.doc(username).get();

    if (cart.exists) {
      List items = cart['items'];
      int index = items.indexWhere((item) => (item['burger']).id == burgerId);

      if (index != -1) {
        if (newQuantity <= 0) {
          items.removeAt(index);
        } else {
          items[index]['quantity'] = newQuantity;
        }

        await carts.doc(username).update({'items': items});
      }
    }
  } catch (error) {
    print('Cant update quantity');
  }
}

Future<void> removeCartItemFromDB(String username, String burgerId) async {
  try {
    var cart = await carts.doc(username).get();

    if (cart.exists) {
      List items = cart['items'];
      items.removeWhere((item) => (item['burger']).id == burgerId);
      await carts.doc(username).update({'items': items});
    }
    ;
  } catch (error) {
    print('Error removing cart item');
  }
}

Future<int> getCartLengthFromDB(String username) async {
  try {
    var cart = await carts.doc(username).get();

    if (!cart.exists) {
      return 0;
    } else {
      List items = cart['items'];
      int totalItems = items.length;

      return totalItems;
    }
  } catch (error) {
    print('Error getting the lentgh of cart');
    return 0;
  }
}

Future<double> getSubtotalFromDB(String username) async {
  try {
    List<Map<String, dynamic>> cartItems = await getUserCartFromDB(username);
    double subtotal = 0;

    for (var item in cartItems) {
      subtotal += item['price'] * item['quantity'];
    }
    return subtotal;
  } catch(error) {
    return 0;
  }
}

Future<double> getTaxFromDB(String username) async{
  return await getSubtotalFromDB(username) * 0.15;
}

Future<double> getTotalFromDB(String username) async {
  return await getSubtotalFromDB(username) + await getTaxFromDB(username);
}
