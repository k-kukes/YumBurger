import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/order_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrderController orderController = OrderController();
  UserController userController = UserController();
  CollectionReference<Object?>? ordersList;
  bool userExist = false;

  @override
  void initState() {
    super.initState();
    checkForUser();
    if (userExist) {
      loadUserOrders();
    }
  }

  void checkForUser() {
    setState(() {
      userExist = userController.getCurrentUser() != null ? true : false;
    });
  }

  Future<void> loadUserOrders() async {
    var user = userController.getCurrentUser();
    CollectionReference<Object?>? orders = await orderController
        .getUserOrdersCollection(user.id);

    setState(() {
      ordersList = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      body: userExist == false
          ? Center(
              child: Text(
                t.mustLoginOrders,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ordersList == null
          ? Center(
              child: Text(
                t.emptyOrders,
                style: TextStyle(fontSize: 18),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: ordersList!.orderBy("date", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text(t.loading));
                }

                final orders = snapshot.data!.docs;

                if (orders.isEmpty) {
                  return Center(
                    child: Text(
                      t.noOrders,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var doc = orders[index];
                    var data = doc.data() as Map<String, dynamic>;

                    DateTime date = (data['date'] as Timestamp).toDate();
                    double total = 0.0;
                    if (data['total'] is String) {
                      total = double.parse(data['total']);
                    } else {
                      total = data['total'];
                    }

                    List<String> orderItemsInfo = [];
                    var orderItems = data['items'];

                    for (var item in orderItems) {
                      String name = item['itemName'];
                      int quantity = item['quantity'];
                      
                      orderItemsInfo.add('$name x$quantity');
                    }

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          "#${doc.id}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(orderItemsInfo.join('\n')),
                        leading: Text(
                          "${date.month}/${date.day}/${date.year}",
                        ),
                        trailing: Text("${total.toStringAsFixed(2)}\$"),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
