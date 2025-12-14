import 'package:flutter/material.dart';
import 'package:yum_burger/Views/burger_admin.dart';
import 'package:yum_burger/Views/drink_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Future<int> getCount(String collection) async {
    final snapshot = await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<int>>(
          future: Future.wait([
            getCount('Burgers'),
            getCount('Users'),
            getCount('drinks'),
          ]),
          builder: (context, snapshot) {
            final burgers = snapshot.data?[0] ?? 0;
            final users = snapshot.data?[1] ?? 0;
            final drinks = snapshot.data?[2] ?? 0;

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildDashboardCard("Hamburgers", "$burgers", Icons.fastfood),
                _buildDashboardCard("Revenue", "\$2,450", Icons.attach_money),
                _buildDashboardCard("Customers", "$users", Icons.people),
                _buildDashboardCard("Drinks", "$drinks", Icons.local_drink),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon) {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

