import 'package:flutter/material.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final List<FAQ> faqList = [
      FAQ(
        question: t.qOne,
        answer: t.aOne,
      ),
      FAQ(
        question: t.qTwo,
        answer: t.aTwo,
      ),
      FAQ(
        question: t.qThree,
        answer: t.aThree,
      ),
      FAQ(
        question: t.qFour,
        answer: t.aFour,
      ),
      FAQ(
        question: t.qFive,
        answer: t.aFive,
      ),
      FAQ(
        question: t.qSix,
        answer: t.aSix,
      ),
    ];

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


