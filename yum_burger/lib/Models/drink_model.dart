import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference drinks = FirebaseFirestore.instance.collection('Drink');

Future<void> addDrink(name, description, price) async {
  if (name.isNotEmpty && description.isNotEmpty && price.isNotEmpty) {
    try {
      await drinks.add({
        'name': name,
        'description': description,
        'price': price,
      });
    } catch (error) {
      print("{Problem occurred while creating burger}");
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
      print("{Problem occurred while editing burger}");
    }
  }
}

Future<void> deleteDrink(id) async {
  if (id.isNotEmpty) {
    try {
      await drinks.doc(id).delete();
    } catch (error) {
      print("{Problem occurred while deleting burger}");
    }
  }
}
