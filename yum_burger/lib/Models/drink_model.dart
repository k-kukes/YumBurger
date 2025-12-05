import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkModel {
  CollectionReference drinks = FirebaseFirestore.instance.collection('drinks');

  Future<void> addDrink(name, description, price) async {
    if (name.isNotEmpty && description.isNotEmpty && price.isNotEmpty) {
      try {
        await drinks.add({
          'name': name,
          'description': description,
          'price': price,
        });
      } catch (error) {
        print("{Problem occurred while creating drink: $error}");
      }
    }
  }

  Future<void> editDrink(id, name, description, price) async {
    if (id.isNotEmpty &&
        name.isNotEmpty &&
        description.isNotEmpty &&
        price.isNotEmpty) {
      try {
        await drinks
            .doc(id)
            .update({'name': name, 'description': description, 'price': price});
      } catch (error) {
        print("{Problem occurred while editing drink: $error}");
      }
    }
  }

  Future<void> deleteDrink(id) async {
    if (id.isNotEmpty) {
      try {
        await drinks.doc(id).delete();
      } catch (error) {
        print("{Problem occurred while deleting drink: $error}");
      }
    }
  }

  CollectionReference getDrinksFromDB() {
    return drinks;
  }

  Future<DocumentSnapshot> getDrinkDocument(String drinkId) async {
    return await drinks.doc(drinkId).get();
  }
}
