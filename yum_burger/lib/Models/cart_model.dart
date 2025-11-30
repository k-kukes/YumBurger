import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class CartModel {
  UserModel userModel = UserModel();
  BurgerModel burgerModel = BurgerModel();

  Future<void> addBurgerToCartDB(userId, burgerId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    await cart.add({
      'item': burgerId,
      'quantity': 1,
      'type': "Burger"
    });
  }

  Future<bool> burgerExistsInCart(userId, burgerId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    Query query = await cart.where('item', isEqualTo: burgerId);
    var resultQuery = await query.count().get();

    return resultQuery.count! > 0 ? true : false;
  }

  Future<String> getBurgerFromCart(userId, burgerId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    QuerySnapshot querySnapshot = await cart.where('item', isEqualTo: burgerId).limit(1).get();

    return querySnapshot.docs.first.id;
  }

  Future<void> addExitingBurgerToCart(userId, cartId) async {
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
    AggregateQuerySnapshot query =  await cart.count().get();
    return query.count ?? 0;
  }

  Future<void> deleteCartItem(userId, cartId) async{
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');

    await cart.doc(cartId).delete();
  }
  
  Future<double> getSubtotal(CollectionReference<Object?> cart, userId) async {
    QuerySnapshot<Object?> querySnapshot = await cart.get();
    double subtotal = 0;

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['type'] == 'Burger') {
          DocumentSnapshot burger = await burgerModel.getBurgerDocument(data['item']);
          subtotal = subtotal + burger['price'] * data['quantity'];
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
}