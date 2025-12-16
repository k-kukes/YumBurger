import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/user_model.dart';

class NotificationsModel {
  UserModel userModel = UserModel();

  addNotificationsToUser(String userId, String msg) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference notifications = users.doc(userId).collection('Notifications');

    await notifications.add({
      'message': msg
    });
  }

  CollectionReference getUserNotifications(String userId) {
    CollectionReference users = userModel.getUsers();
    CollectionReference notifications = users.doc(userId).collection('Notifications');
    return notifications;
  }

  Future<void> removeNotifications(String userId) async {
    CollectionReference users = userModel.getUsers();
    CollectionReference notifications = users.doc(userId).collection('Notifications');

    QuerySnapshot notifs = await notifications.get();

    for (var doc in notifs.docs) {
      await notifications.doc(doc.id).delete();
    }
  }
}