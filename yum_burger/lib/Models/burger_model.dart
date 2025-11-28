import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference burgers = FirebaseFirestore.instance.collection('Burgers');

Future<void> addBurgerToDB(name, description, price, image) async {
    try {
      await burgers.add({
        'name': name,
        'description': description,
        'price': price,
        'image': image,
      });
    } catch (error) {
      print("{Problem occurred while creating burger}");
    }
}

Future<void> editBurger(id, name, description, price, image) async {
  if (id.isNotEmpty &&
      name.isNotEmpty &&
      description.isNotEmpty &&
      price.isNotEmpty &&
      image.isNotEmpty) {
    try {
      await burgers.doc(id).update({
        'name': name,
        'description': description,
        'price': price,
        'image': image,
      });
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

Future<bool> burgerNameExists(String checkName) async {
  try {
    QuerySnapshot querySnapshot = await burgers
        .where('name', isEqualTo: checkName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    }
  } catch (error) {
    print(error);
    print('Error with nameExists burgers check');
  }
  return false;
}

Future<List<Map<String, dynamic>>> getBurgersFromDB() async {
  try {
    QuerySnapshot querySnapshot = await burgers.get();
    return querySnapshot.docs.map((doc){
      return {
        'id': doc.id,
        'name': doc['name'],
        'description': doc['description'],
        'price': doc['price'],
        'image': doc['image'],
      };
    }).toList();
  } catch (error) {
    print(error);
    return [];
  }
}

Future<Map<String,dynamic>?> getBurgerByIdFromDB(String burgerId) async {
  try {
    var burger = await burgers.doc(burgerId).get();
    if (burger.exists) {
      return {
        'id': burger.id,
        'name': burger['name'],
        'description': burger['description'],
        'price': burger['price'],
        'image': burger['image'],
      };
    }
  } catch(error) {
    print('Error retrieving burger by id');
  }
  return null;
}
