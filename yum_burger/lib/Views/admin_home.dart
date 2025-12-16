import 'package:flutter/material.dart';
import 'package:yum_burger/Models/order_model.dart';
import 'package:yum_burger/Views/burger_admin.dart';
import 'package:yum_burger/Views/drink_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

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

  Future<double> getRevenue() async {
    OrderModel orderModel = OrderModel();
    return await orderModel.getRevenue();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            getCount('Burgers'),
            getCount('Users'),
            getCount('drinks'),
            getRevenue()
          ]),
          builder: (context, snapshot) {
            final burgers = snapshot.data?[0] ?? 0;
            final users = snapshot.data?[1] ?? 0;
            final drinks = snapshot.data?[2] ?? 0;
            final revenue =  snapshot.data?[3] ?? 0.0;

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildDashboardCard(t.adminHomeHamburgers, "$burgers", Icons.fastfood),
                _buildDashboardCard(t.adminHomeRevenue, "\$${revenue.toStringAsFixed(2)}", Icons.attach_money),
                _buildDashboardCard(t.adminHomeCustomers, "$users", Icons.people),
                _buildDashboardCard(t.adminHomeDrinks, "$drinks", Icons.local_drink),
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

