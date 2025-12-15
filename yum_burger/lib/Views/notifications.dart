import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    null, // Use default icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      )
    ],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome Notifications Example',
      home: NotificationExample(),
    );
  }
}

class NotificationExample extends StatefulWidget {
  @override
  State<NotificationExample> createState() => _NotificationExampleState();
}

class _NotificationExampleState extends State<NotificationExample> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }

  // Request Notification Permissions
  void requestNotificationPermissions() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Show dialog to request permissions
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // Create a Notification
  void createNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1, // Unique ID for this notification
        channelKey: 'basic_channel', // Must match initialized channel
        title: 'Hello, Flutter!',
        body: 'This is a simple notification using Awesome Notifications.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Notifications Example'),
        backgroundColor: const Color(0xFF9D50DD),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: createNotification,
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}