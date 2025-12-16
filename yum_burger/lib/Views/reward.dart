import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Views/MenuItemCard.dart';
// Removed: import 'package:yum_burger/Controllers/reward_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/drink_controller.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  // Removed: final RewardsController _rewardController = RewardsController();
  final UserController _userController = UserController();
  final BurgerController _burgerController = BurgerController();
  final DrinkController _drinkController = DrinkController();

  CollectionReference<Object?>? _burgersList;
  CollectionReference<Object?>? _drinksList;

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  Future<void> _loadCollections() async {
    var burgers = await _burgerController.getBurgersCollection();
    var drinks = await _drinkController.getDrinksCollection();
    if (mounted) {
      setState(() {
        _burgersList = burgers;
        _drinksList = drinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _userController.getCurrentUser();
    if (user == null) {
      return const Center(child: Text("Please log in."));
    }
    final String userId = user.id;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(userId).snapshots(),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) return const Center(child: CircularProgressIndicator());

        var userData = userSnapshot.data!.data() as Map<String, dynamic>?;
        int currentPoints = userData?['currentPoints'] ?? 0;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  const Text("Rewards"),
                  Text("$currentPoints Points", style: const TextStyle(fontSize: 14, color: Colors.deepOrange)),
                ],
              ),
              centerTitle: true,
              bottom: const TabBar(
                labelColor: Colors.deepOrange,
                indicatorColor: Colors.deepOrange,
                tabs: [
                  Tab(text: "Drinks (5 pts)"),
                  Tab(text: "Burgers (10 pts)"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildGrid(context, _drinksList, 5, currentPoints, userId),
                _buildGrid(context, _burgersList, 10, currentPoints, userId),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context, CollectionReference<Object?>? collection, int cost, int points, String userId) {
    if (collection == null) return const Center(child: CircularProgressIndicator());

    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        if (snapshot.data!.docs.isEmpty) return const Center(child: Text("No items found."));

        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.55,
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return MenuItemCard(
              name: data['name'],
              price: cost.toDouble(),
              image: data['image'],
              onAddToCart: () {
                if (points >= cost) {
                  _showCashierDialog(context, userId, cost, data['name']);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Not enough points!")),
                  );
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showCashierDialog(BuildContext context, String userId, int cost, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Redeem Reward", textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.phone_android, size: 60, color: Colors.deepOrange),
              const SizedBox(height: 16),
              const Text(
                "Please show this screen to the cashier.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.deepOrange, width: 2),
                ),
                child: Text(
                  "1x FREE $itemName",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Text("Cost: $cost Points", style: const TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }
}