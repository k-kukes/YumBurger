import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';
import 'package:yum_burger/Models/cart_model.dart';

class BurgerController {
  BurgerModel burgerModel = new BurgerModel();
  CartModel cartModel = CartModel();

  Future<CollectionReference<Object?>?> getBurgersCollection() async {
    CollectionReference<Object?> burgers = burgerModel.getBurgersFromDB();
    QuerySnapshot querySnapshot = await burgers.get();
    if (querySnapshot.docs.isNotEmpty) {
      return burgers;
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot<Object?>> getBurgerDocumentById(burgerId) async {
    return await burgerModel.getBurgerDocument(burgerId);
  }

  Future<bool> deleteBurger(burgerId) async {
    if (burgerId.isNotEmpty) {
      await cartModel.removeDeletedItemFromCarts(burgerId);
      return await burgerModel.deleteBurger(burgerId);
    }
    return false;
  }

  Future<void> addBurger(String name, double price, String description, String image) async {
    if (name.isNotEmpty && price > 0 && description.isNotEmpty && image.isNotEmpty) {
      await burgerModel.addBurger(name, description, image, price);
    }
  }

  Future<void> updateBurger(String id, String name, String description, String image, double price) async {
    if (id.isNotEmpty && name.isNotEmpty && description.isNotEmpty && price > 0) {
      burgerModel.updateBurger(id, name, description, image, price);
    }
  }
}