import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "FAQ",
          style: TextStyle(
            fontFamily: 'HoltwoodOneSC',
            fontSize: 28,
            color: Colors.brown,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ExpansionTile(
              title: Text(
                faq.question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(faq.answer),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

final List<FAQ> faqList = [
  FAQ(
    question: "What are your opening hours?",
    answer: "We’re open Monday to Sunday from 11:00 AM to 11:00 PM.",
  ),
  FAQ(
    question: "Do you offer online ordering?",
    answer: "Yes! You can order directly through our website or mobile app for pickup or delivery.",
  ),
  FAQ(
    question: "Are vegetarian or vegan options available?",
    answer: "Absolutely. We have veggie burgers and plant-based patties!",
  ),
  FAQ(
    question: "Do you deliver?",
    answer: "Yes, we deliver through partners like Uber Eats and DoorDash.",
  ),
  FAQ(
    question: "How can I contact customer support?",
    answer: "You can call us at (555) 123‑4567.",
  ),
  FAQ(
    question: "Do you have loyalty rewards?",
    answer: "Yes, sign up for our rewards program to earn points on every purchase.",
  ),
];


