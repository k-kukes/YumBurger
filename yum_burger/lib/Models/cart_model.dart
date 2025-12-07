import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/drink_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class CartModel {
  UserModel userModel = UserModel();
  BurgerModel burgerModel = BurgerModel();
  DrinkModel drinkModel = DrinkModel();

  Future<void> addItemToCartDB(userId, itemId, itemType) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference burgers = burgerModel.getBurgersFromDB();
    CollectionReference cart = users.doc(userId).collection('Cart');
    bool itemExists = false;

    if (itemType == 'Burger') {

    }

    await cart.add({
      'item': itemId,
      'quantity': 1,
      'type': itemType
    });
  }

  Future<bool> itemExistsInCart(userId, itemId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    Query query = await cart.where('item', isEqualTo: itemId);
    var resultQuery = await query.count().get();

    return resultQuery.count! > 0 ? true : false;
  }

  Future<String> getItemFromCart(userId, itemId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    QuerySnapshot querySnapshot = await cart.where('item', isEqualTo: itemId).limit(1).get();

    return querySnapshot.docs.first.id;
  }

  Future<void> addExitingItemToCart(userId, cartId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    DocumentSnapshot cartItem = await cart.doc(cartId).get();
    int itemQuantity = cartItem['quantity'];

    cart.doc(cartId).update({
      'quantity': itemQuantity + 1,
    });
  }

  Future<void> addQuantityToItem(userId, cartId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    DocumentSnapshot cartItem = await cart.doc(cartId).get();
    int itemQuantity = cartItem['quantity'];

    await cart.doc(cartId).update({
      'quantity': itemQuantity + 1,
    });
  }

  Future<void> decreaseQuantity(userId, cartId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    DocumentSnapshot cartItem = await cart.doc(cartId).get();
    int itemQuantity = cartItem['quantity'];

    if (itemQuantity > 1) {
     await cart.doc(cartId).update({
        'quantity': itemQuantity - 1,
      });
    } else {
      await cart.doc(cartId).delete();
    }
  }

  CollectionReference<Object?> getUserCartFromDB(userId) {
    CollectionReference users = userModel.getUsers();
    return users.doc(userId).collection('Cart');
  }

  Future<bool> checkEmptyCart(CollectionReference<Object?> cart) async {
    QuerySnapshot querySnapshot = await cart.limit(1).get();
    return querySnapshot.docs.isEmpty;
  }

  Future<int> getCartLength(CollectionReference<Object?> cart) async {
    int count = 0;
    QuerySnapshot snapshot = await cart.get();
    for (var doc in snapshot.docs) {
      int quantity = doc['quantity'];
      count = count + quantity;
    }
    return count;
  }

  Future<void> deleteCartItem(userId, cartId) async{
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    await cart.doc(cartId).delete();
  }

  Future<void> deleteEntireCart(userId) async{
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    QuerySnapshot cartItems = await cart.get();

    for (var doc in cartItems.docs) {
      await cart.doc(doc.id).delete();
    }
  }
  
  Future<double> getSubtotal(CollectionReference<Object?> cart, userId) async {
    QuerySnapshot<Object?> querySnapshot = await cart.get();
    double subtotal = 0;

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['type'] == 'Burger') {
          DocumentSnapshot burger = await burgerModel.getBurgerDocument(data['item']);
          if (burger.data() != null) {
            subtotal = subtotal + burger['price'] * data['quantity'];
          }
        }
        if (data['type'] == 'Drink') {
          DocumentSnapshot drink = await drinkModel.getDrinkDocument(data['item']);
          if (drink.data() != null) {
            subtotal = subtotal + drink['price'] * data['quantity'];
          }
        }
      }
    }
    return subtotal;
  }

  Future<double> getTax(CollectionReference<Object?> cart, userId) async {
    double tax = 0;
    tax = await getSubtotal(cart, userId) * 0.15;
    return tax;
  }

  Future<double> getTotal(CollectionReference<Object?> cart, userId) async {
    double total = 0;
    total = await getSubtotal(cart, userId) + await getTax(cart, userId);
    return total;
  }

  Future<void> removeDeletedItemFromCarts(String itemId) async {
    try {
      CollectionReference users = userModel.getUsers();
      QuerySnapshot usersSnapshot = await users.get();

      for (var userDoc in usersSnapshot.docs) {
        String userId = userDoc.id;
        CollectionReference cartRef = getUserCartFromDB(userId);
        QuerySnapshot cartSnapshot = await cartRef.get();

        for (var cartDoc in cartSnapshot.docs) {
          if (cartDoc['item'] == itemId) {
            await cartRef.doc(cartDoc.id).delete();
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }
}