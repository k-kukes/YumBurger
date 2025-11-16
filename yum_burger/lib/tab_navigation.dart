import 'package:flutter/material.dart';
import 'main.dart';
import 'offers.dart';
import 'menu.dart';

void main() {
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