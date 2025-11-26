import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/header.dart';
import 'package:yum_burger/Models/user_model.dart';
import 'package:yum_burger/Views/account.dart';
import 'package:yum_burger/Views/cart.dart';
import 'package:yum_burger/Views/home.dart';
import '../Views/create_account.dart';
import '../Views/login.dart';
import '../Views/offers.dart';
import '../Views/menu.dart';

void main() async{
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
    MyCartPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      if (index == 3) {
        if (getCurrentUser() != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()));
          return;
        }
      }
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
  ];

  @override
  Widget build(BuildContext context) {
    return NavBar(body: _pages[_selectedIndex],
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