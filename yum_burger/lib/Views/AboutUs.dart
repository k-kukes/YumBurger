import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About Us",
          style: TextStyle(
            fontFamily: 'HoltwoodOneSC',
            fontSize: 28,
            color: Colors.brown,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Yum Burger!",
                style: TextStyle(
                  fontFamily: 'HoltwoodOneSC',
                  fontSize: 28,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "At Yum Burger, we believe a great burger is more than just a meal, it’s an experience. "
                    "Created with fresh ingredients and bold flavors, we serve handcrafted burgers made to satisfy every craving.\n\n"
                    "From our delicious beef patties to our plant‑based creations, every bite is cooked with care and served with a smile. "
                    "Whether you’re dining in, ordering online, or grabbing a quick bite on the go, Yum Burger is here to make your day better.\n\n"
                    "We’re proud to be part of the community, offering friendly service, sustainable practices, and a menu that brings people together. "
                    "So come hungry, leave happy, and remember: life’s too short for boring burgers!",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/account.jpg',
                    width:  400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}

