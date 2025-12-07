import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yum_burger/Models/cart_model.dart';

class BurgerModel {
  CollectionReference burgers = FirebaseFirestore.instance.collection(
    'Burgers',
  );

  CollectionReference<Object?> getBurgersFromDB() {
    return burgers;
  }

  Future<DocumentSnapshot<Object?>> getBurgerDocument(burgerId) async {
    DocumentReference<Object?> burger = await burgers.doc(burgerId);
    return burger.get();
  }

  Future<bool> deleteBurger(id) async {
    try {
      await burgers.doc(id).delete();

      return true;
    } catch (error) {
      print("{Problem occurred while deleting drink: $error}");
      return false;
    }
  }

  Future<bool> burgerExists(String burgerId) async{
    try {
      DocumentSnapshot doc = await burgers.doc(burgerId).get();
      return doc.exists;
    } catch (error) {
      return false;
    }
  }

  Future<String> getBurgerName(String burgerId) async{
    try {
      DocumentSnapshot doc = await burgers.doc(burgerId).get();
      Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
      return data['name'];
    } catch (error) {
      return '';
    }
  }

  Future<void> addBurger(String name, String description, String image, double price) async{
    await burgers.add({
      'name': name,
      'description': description,
      'price': price,
      'image': image
    });
  }

  Future<void> updateBurger(String id, String name, String description, String image, double price) async{
    await burgers.doc(id).update({
      'name': name,
      'description': description,
      'price': price,
      'image': image
    });
  }
}
