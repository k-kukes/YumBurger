import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/order_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  OrderController orderController = OrderController();
  UserController userController = UserController();
  List<Map<String, dynamic>> usersWithOrders = [];

  @override
  void initState() {
    super.initState();
    loadUsersAndOrders();
  }

  Future<void> loadUsersAndOrders() async {
    List<Map<String, dynamic>> tempUsers = [];
    CollectionReference users = await userController.getUsersCollection();
    QuerySnapshot usersSnapshot = await users.get();

    for (var userDoc in usersSnapshot.docs) {
      String userId = userDoc.id;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      CollectionReference<Object?>? ordersCollection = await orderController
          .getUserOrdersCollection(userId);
      if (ordersCollection == null) continue;

      QuerySnapshot ordersSnapshot = await ordersCollection.get();
      List<Map<String, dynamic>> orders = [];

      for (var orderDoc in ordersSnapshot.docs) {
        Map<String, dynamic> orderData =
            orderDoc.data() as Map<String, dynamic>;
        orderData['orderId'] = orderDoc.id;
        orderData['total'] = (orderData['total'] is String)
            ? double.parse(orderData['total'])
            : orderData['total'];

        List<String> itemsInfo = [];
        var orderItems = orderData['items'];
        for (var item in orderItems) {
          String name = item['itemName'];
          int quantity = item['quantity'];
          itemsInfo.add('$name x$quantity');
        }
        orderData['itemsInfo'] = itemsInfo;
        orders.add(orderData);
      }
      if (orders.isNotEmpty) {
        tempUsers.add(({
          'userId': userId,
          'fullName': userData['fullName'],
          'username': userData['username'],
          'orders': orders,
        }));
      }
    }
    setState(() {
      usersWithOrders = tempUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(title: Text('All Orders')),
      body: usersWithOrders.isEmpty
          ? Center(child: Text('No orders yet sorry.'))
          : ListView.builder(
              itemCount: usersWithOrders.length,
              itemBuilder: (context, index) {
                var user = usersWithOrders[index];
                List<dynamic> orders = user['orders'] as List<dynamic>;

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user['fullName']} (${user['username']})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Divider(),
                        ...orders.map((order) {
                          DateTime date = (order['date'] as Timestamp).toDate();
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order #${order['orderId']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${date.month}/${date.day}/${date.year}"),
                                Text(
                                  "Total: ${order['total'].toStringAsFixed(2)}\$",
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
