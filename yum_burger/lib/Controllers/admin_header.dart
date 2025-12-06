import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/tab_navigation.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/admin_home.dart';

import 'admin_tab_navigation.dart';

class AdminNavBar extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const AdminNavBar({
    super.key,
    required this.body,
    required this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = new UserController();
    var currentUser = userController.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YUM-BURGER',
          style: TextStyle(
            fontFamily: 'HoltwoodOneSC',
            fontSize: 28,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFEEE8DE),
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          backgroundColor: Color(0xFFEEE8DE),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (currentUser == null)
                UserAccountsDrawerHeader(
                  accountName: Text('user'),
                  accountEmail: Text('placeholder@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: Text('S', style: TextStyle(fontSize: 40)),
                  ),
                )
              else
                UserAccountsDrawerHeader(
                  accountName: Text('${currentUser['username']}'),
                  accountEmail: Text('${currentUser['email']}'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: Text(
                      '${currentUser['username'][0].toUpperCase()}',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AdminTabNavigation()),
                        (route) => false,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  bool validLogout = userController.logout();
                  if (validLogout) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully logout')));
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => MyNavigation()),
                        (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
