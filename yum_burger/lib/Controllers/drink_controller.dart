import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/drink_model.dart';

class DrinkController {
  final DrinkModel drinkModel = DrinkModel();

  Future<CollectionReference<Object?>?> getDrinksCollection() async {
    CollectionReference<Object?> drinks = drinkModel.getDrinksFromDB();
    QuerySnapshot querySnapshot = await drinks.get();
    if (querySnapshot.docs.isNotEmpty) {
      return drinks;
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot<Object?>> getDrinkDocumentById(String drinkId) async {
    return await drinkModel.getDrinkDocument(drinkId);
  }

  Future<void> addDrink(String name, double price, String description, String image) async {
    if (name.isNotEmpty && price > 0 && description.isNotEmpty && image.isNotEmpty) {
      await drinkModel.addDrink(name, description, image, price);
    }
  }

  Future<void> editDrink(String id, String name, String description, double price) async {
    await drinkModel.editDrink(id, name, description, price);
  }

  Future<void> updateDrink(String id, String name, String description, String image, double price) async {
    if (id.isNotEmpty && name.isNotEmpty && description.isNotEmpty && price > 0) {
      drinkModel.updateDrink(id, name, description, image, price);
    }
  }

  Future<bool> deleteDrink(String id) async {
    if (id.isNotEmpty) {
      await drinkModel.deleteDrink(id);
      return true;
    }
    return false;
  }
}