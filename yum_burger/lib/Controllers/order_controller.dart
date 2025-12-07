import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/order_model.dart';

class OrderController {
  OrderModel orderModel = OrderModel();

  Future<void> saveOrder(String userId, double total) async {
    if (userId.isEmpty || total < 0) {
      return;
    }
    await orderModel.saveOrder(userId, total);
  }

  Future<bool> isOrdersEmpty(CollectionReference<Object?> order) async {
    return orderModel.checkEmptyOrders(order);
  }

  Future<CollectionReference<Object?>?> getUserOrdersCollection(userId) async {
    CollectionReference<Object?> orders = orderModel.getUserOrders(userId);
    return await isOrdersEmpty(orders) ? null : orders;
  }
}