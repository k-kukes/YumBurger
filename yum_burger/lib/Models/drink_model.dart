import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkModel {
  CollectionReference drinks = FirebaseFirestore.instance.collection('drinks');

  Future<void> addDrink(String name, String description, String image, double price) async{
    await drinks.add({
      'name': name,
      'description': description,
      'price': price,
      'image': image
    });
  }

  Future<void> editDrink(id, name, description, price) async {
    if (id.isNotEmpty &&
        name.isNotEmpty &&
        description.isNotEmpty &&
        price.isNotEmpty) {
      try {
        await drinks.doc(id).update({
          'name': name,
          'description': description,
          'price': price,
        });
      } catch (error) {
        print("{Problem occurred while editing drink: $error}");
      }
    }
  }

  Future<bool> deleteDrink(id) async {
    try {
      await drinks.doc(id).delete();
      return true;
    } catch (error) {
      print("{Problem occurred while deleting drink: $error}");
      return false;
    }
  }

  Future<void> updateDrink(String id, String name, String description, String image, double price) async{
    await drinks.doc(id).update({
      'name': name,
      'description': description,
      'price': price,
      'image': image
    });
  }

  CollectionReference getDrinksFromDB() {
    return drinks;
  }

  Future<DocumentSnapshot> getDrinkDocument(String drinkId) async {
    return await drinks.doc(drinkId).get();
  }
}
