import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/tab_navigation.dart';
import '../Views/home.dart';

class NavBar extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const NavBar({super.key, required this.body, required this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YUM-BURGER', style: TextStyle(fontFamily: 'HoltwoodOneSC', fontSize: 28, color: Colors.brown),),
        centerTitle: true,
        backgroundColor: Color(0xFFEEE8DE),
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          backgroundColor: Color(0xFFEEE8DE),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('user'),
                accountEmail: Text('placeholder@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Text('S', style: TextStyle(fontSize: 40),),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop(); //close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyNavigation())
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
