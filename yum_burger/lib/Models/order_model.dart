import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/cart_model.dart';
import 'package:yum_burger/Models/drink_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class OrderModel {
  UserModel userModel = UserModel();
  CartModel cartModel = CartModel();
  BurgerModel burgerModel = BurgerModel();
  DrinkModel drinkModel = DrinkModel();

  Future<void> saveOrder(String userId, double total) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference cart = users.doc(userId).collection('Cart');
    CollectionReference order = users.doc(userId).collection('Orders');

    QuerySnapshot cartSnapshot = await cart.get();
    if (cartSnapshot.docs.isEmpty) {
      return;
    }

    List<Map<String, dynamic>> orderItems = [];

    for (var cartItem in cartSnapshot.docs) {
      Map<String, dynamic> cartItemData = cartItem.data() as Map<String, dynamic>;
      String itemId = cartItemData['item'];
      String type = cartItemData['type'];
      String itemName = 'Couldn\'t load';
      if (type == 'Burger') {
        itemName = await burgerModel.getBurgerName(itemId);
      }

      if (type == 'Drink') {
        itemName = await drinkModel.getDrinkName(itemId);
      }

      orderItems.add({
        'itemName': itemName,
        'quantity': cartItemData['quantity'],
        'type': type
      });
    }

    await order.add({
      "items": orderItems,
      "date": DateTime.now(),
      'total': total.toStringAsFixed(2)
    });
  }

  CollectionReference<Object?> getUserOrders(userId) {
    CollectionReference users = userModel.getUsers();
    return users.doc(userId).collection('Orders');
  }

  Future<double> getRevenue() async {
    CollectionReference users = userModel.getUsers();
    double revenue = 0.0;

    try {
      QuerySnapshot userSnapshots = await users.get();

      for (var userDoc in userSnapshots.docs) {
        QuerySnapshot orderSnapshots = await userDoc.reference.collection('Orders').get();

        for (var orderDoc in orderSnapshots.docs) {
          var data = orderDoc.data() as Map<String, dynamic>;
          var total = data['total'];
          if (total != null) {
            revenue += double.parse(total);
          }
        }
      }

      return revenue;
    } catch (error) {
      print(error);
    }
    return 0.0;
  }

  Future<bool> checkEmptyOrders(CollectionReference<Object?> order) async {
    QuerySnapshot querySnapshot = await order.limit(1).get();
    return querySnapshot.docs.isEmpty;
  }
}