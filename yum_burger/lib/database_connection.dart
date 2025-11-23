import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'tab_navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBEjH28dcF1J6iGhrb8H7jpgWVkSG5vpjQ",
      appId: "1:697511557856:android:7f2f11f0491ff62c9e2e85",
      messagingSenderId: "697511557856",
      projectId: "yumburger-44e34",
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyNavigation(),
  ));
}