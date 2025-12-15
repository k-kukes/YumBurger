import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/login.dart';
import 'package:yum_burger/Models/user_model.dart';
import '../Controllers/tab_navigation.dart';
import 'offers.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigation(),
    );
  }
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  UserController userController = new UserController();

  String username = '';
  String password = '';
  String fullName = '';
  String email = '';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();


  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    fullNameController.clear();
    emailController.clear();
    setState(() {
      username = '';
      password = '';
      fullName = '';
      email = '';
    });

  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFEEE8DE),
      appBar: AppBar(
        backgroundColor: Color(0xFFEEE8DE),
        leading: TextButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyNavigation()),
          ),
          label: Icon(Icons.arrow_back),
        ),
        title: Text(t.goBackHome),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 150,
                  color: Colors.black,
                ),
                radius: 75,
                backgroundColor: Colors.white,
              ),
            ),
            Text(t.createAccount, style: TextStyle(fontSize: 30)),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: usernameController,
                    onChanged: (value) => username = value,
                    decoration: InputDecoration(
                      hintText: t.username,
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: passwordController,
                    onChanged: (value) => password = value,
                    decoration: InputDecoration(
                      hintText: t.password,
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: fullNameController,
                    onChanged: (value) => fullName = value,
                    decoration: InputDecoration(
                      hintText: t.fullName,
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: emailController,
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                      hintText: t.email,
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  String result = await userController.addUser(username, password, fullName, email);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  clearForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  t.homeSignUp,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(t.alreadyHaveAccount, style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                t.login,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
