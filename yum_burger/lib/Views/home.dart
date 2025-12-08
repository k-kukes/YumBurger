import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Order A YUM\nCombo\nToday!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),

                          const SizedBox(height: 20),

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
                    ),
                    Image.asset('assets/images/combo.jpg', width: 400, height: 200,),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoCard(
                      context: context,
                      image:
                      "assets/images/hamburger4.jpg",
                      title: "Sign up or sign in to\nyour account to make an order!",
                      buttonText: "Sign Up",
                      page: LoginPage(),
                    ),
                    infoCard(
                      context: context,
                      image:
                      "assets/images/hamburger1.jpg",
                      title: "Try Out Our Yum\nBacon Burger",
                      buttonText: "Order Now",
                      page: MenuPage()
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoCard(
                      context: context,
                      image:
                      "assets/images/hamburger2.jpg",
                      title: "Want to learn how\nwe make our meals?",
                      buttonText: "About Us",
                      page: AboutUsPage()
                    ),
                    infoCard(
                      context: context,
                      image:
                      "assets/images/questions.jpg",
                      title: "Have any questions?",
                      buttonText: "FAQ",
                      page: FAQPage()
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "assets/images/account.jpg",
                        height: 280,
                        width: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Create your account and\n"
                            "check out the latest\n"
                            "promotions",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        )
      )
    );

      }
}

Widget infoCard({
  required BuildContext context,
  required String image,
  required String title,
  required String buttonText,
  required Widget page
}) {
  return Container(
    width: 250,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            image,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(14),
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
                      MaterialPageRoute(
                        builder: (context) => page,
                      ),
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
