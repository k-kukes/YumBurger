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

  Future<void> addDrink(String name, String description, double price) async {
    await drinkModel.addDrink(name, description, price);
  }

  Future<void> editDrink(String id, String name, String description, double price) async {
    await drinkModel.editDrink(id, name, description, price);
  }

  Future<void> deleteDrink(String id) async {
    await drinkModel.deleteDrink(id);
  }
}