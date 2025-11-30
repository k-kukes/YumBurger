import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/burger_model.dart';

class BurgerController {
  BurgerModel burgerModel = new BurgerModel();

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


}