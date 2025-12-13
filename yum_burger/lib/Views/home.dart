import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/notifications_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Models/user_model.dart';
import 'package:yum_burger/Views/offers.dart';
import '../Views/menu.dart';
import '../Views/login.dart';
import '../Views/FAQ.dart';
import '../Views/AboutUs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationController notificationController = NotificationController();
  UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    if (userController.getCurrentUser() != null) {
      print('called');
      setupNotifications();
    }
  }

  Future<void> setupNotifications() async {
    await notificationController.requestNotificationPermissions();
    await notificationController.checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Order A YUM\nCombo\nToday!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HoltwoodOneSC',
                      fontSize: 28,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/combo.jpg',
                    width: screenWidth * 0.8,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    },
                    icon: Icon(Icons.shopping_bag),
                    label: Text("Check the menu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                      padding: EdgeInsets.symmetric(
                          horizontal: 26, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign up"),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 26, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Info Cards Grid
              GridView.count(
                crossAxisCount: screenWidth < 600 ? 1 : 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  infoCard(
                    context: context,
                    image: "assets/images/hamburger1.jpg",
                    title: "Check out our latest offers! \n Save up some money for your next meal!",
                    buttonText: "Check Offers",
                    page: LoginPage(),
                  ),
                  infoCard(
                    context: context,
                    image: "assets/images/hamburger4.jpg",
                    title: "Try Out Our Yum\nBacon Burger",
                    buttonText: "Order Now",
                    page: MenuPage(),
                  ),
                  infoCard(
                    context: context,
                    image: "assets/images/hamburger2.jpg",
                    title: "Want to learn how\nwe make our meals?",
                    buttonText: "About Us",
                    page: AboutUsPage(),
                  ),
                  infoCard(
                    context: context,
                    image: "assets/images/questions.jpg",
                    title: "Have any questions?",
                    buttonText: "FAQ",
                    page: FAQPage(),
                  ),
                ],
              ),
              SizedBox(height: 40),
              // Promo Section
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/account.jpg",
                      height: 200,
                      width: screenWidth * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Create your account and\ncheck out the latest promotions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Info Card
Widget infoCard({
  required BuildContext context,
  required String image,
  required String title,
  required String buttonText,
  required Widget page,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.asset(
            image,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}