import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/admin_header.dart';
import 'package:yum_burger/Controllers/header.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/admin_home.dart';
import 'package:yum_burger/Views/admin_orders.dart';
import 'package:yum_burger/Views/burger_admin.dart';
import 'package:yum_burger/Views/drink_admin.dart';

void main() async{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminTabNavigation(),
  ));
}

class AdminTabNavigation extends StatefulWidget {
  const AdminTabNavigation({super.key});

  @override
  State<AdminTabNavigation> createState() => _MyAdminNavigationState();
}

class _MyAdminNavigationState extends State<AdminTabNavigation> {
  UserController userController = UserController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminHomePage(),
    BurgerAdminPage(),
    DrinkAdminPage(),
    AdminOrdersPage()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood_sharp), label: 'Burgers'),
    BottomNavigationBarItem(icon: Icon(Icons.fastfood_sharp), label: 'Drinks'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Orders')
  ];

  @override
  Widget build(BuildContext context) {
    return AdminNavBar(body: _pages[_selectedIndex],
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