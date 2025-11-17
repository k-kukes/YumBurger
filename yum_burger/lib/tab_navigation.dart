import 'package:flutter/material.dart';
import 'create_account.dart';
import 'login.dart';
import 'offers.dart';
import 'menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class MyNavigation extends StatefulWidget {
  const MyNavigation({super.key});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MenuPage(),
    OffersPage(),
    LoginPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}