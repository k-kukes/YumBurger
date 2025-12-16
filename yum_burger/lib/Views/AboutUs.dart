import 'package:flutter/material.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.homeAboutBtn,
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
                t.aboutWelcome,
                style: TextStyle(
                  fontFamily: 'HoltwoodOneSC',
                  fontSize: 28,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
               t.aboutTxt,
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

