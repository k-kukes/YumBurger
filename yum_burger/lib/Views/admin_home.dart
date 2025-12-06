import 'package:flutter/material.dart';
import 'package:yum_burger/Views/burger_admin.dart';
import 'package:yum_burger/Views/drink_admin.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome to the admin panel!'),
      ),
    );
  }
}
