import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BurgerModel {
  CollectionReference burgers = FirebaseFirestore.instance.collection('Burgers');

  CollectionReference<Object?> getBurgersFromDB() {
    return burgers;
  }
}
