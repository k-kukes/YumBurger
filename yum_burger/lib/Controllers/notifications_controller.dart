import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/notifications_model.dart';
import 'package:yum_burger/Models/user_model.dart';

class NotificationController {
  UserModel userModel = UserModel();
  NotificationsModel notificationsModel = NotificationsModel();
  // Request Notification Permissions
  Future<void> requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
  }

  // Create a Notification
  Future<void> createNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000), // Unique ID for this notification
        channelKey: 'basic_channel', // Must match initialized channel
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default
      ),
    );
  }

  Future<CollectionReference?> getUserNotificationsReference() async {
    try {
      var user = await userModel.getCurrentUser();
      if (user != null) {
        return notificationsModel.getUserNotifications(user.id);
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<void> checkForNotifications() async {
    try {
      var user = await userModel.getCurrentUser();
      if (user != null) {
        CollectionReference notifs = notificationsModel.getUserNotifications(user.id);
        QuerySnapshot snapshot = await notifs.get();

        for (var doc in snapshot.docs) {
          String docId = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String message = data['message'];

          await createNotification('Yum Burger Notifications', message);
        }
        notificationsModel.removeNotifications(user.id);
      }
    } catch (error) {
      print(error);
    }
  }
}

