import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference burgers = FirebaseFirestore.instance.collection('Burgers');

Future<void> addBurger(name, description, price) async {
  if (name.isNotEmpty && description.isNotEmpty && price.isNotEmpty) {
    try {
      await burgers.add({
        'name': name,
        'description': description,
        'price': price,
      });
    } catch (error) {
      print("{Problem occurred while creating burger}");
    }
  }
}

Future<void> editBurger(id, name, description, price) async {
  if (id.isNotEmpty &&
      name.isNotEmpty &&
      description.isNotEmpty &&
      price.isNotEmpty) {
    try {
      await burgers
          .doc(id)
          .update({'name': name, 'description': description, 'price': price});
    } catch (error) {
      print("{Problem occurred while editing burger}");
    }
  }
}

Future<void> deleteBurger(id) async {
  if (id.isNotEmpty) {
    try {
      await burgers.doc(id).delete();
    } catch (error) {
      print("{Problem occurred while deleting burger}");
    }
  }
}
