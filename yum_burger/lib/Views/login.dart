import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Controllers/admin_tab_navigation.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/account.dart';
import 'package:yum_burger/Views/admin_home.dart';
import 'package:yum_burger/Views/create_account.dart';
import 'package:yum_burger/Views/menu.dart';
import 'package:yum_burger/Views/reset_password.dart';
import 'package:yum_burger/Models/user_model.dart';
import '../Controllers/tab_navigation.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController userController = new UserController();
  String username = '';
  String password = '';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    setState(() {
      username = '';
      password = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
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
      backgroundColor: Color(0xFFEEE8DE),
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
            Text(t.login, style: TextStyle(fontSize: 30)),
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      t.resetPassword,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (await userController.validateLogin(
                        username,
                        password,
                      )) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.successLogin)),
                        );
                        clearForm();
                        var user = await userController.getCurrentUser();
                        if (user['type'] == 'customer') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountSettingsPage(),
                            ),
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AdminTabNavigation()),
                              (route) => false
                          );
                          return;
                        }
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(t.failedLogin)));
                        clearForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      t.login,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(t.notMember, style: TextStyle(fontSize: 20)),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountPage(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      t.createAccount,
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
          ],
        ),
      ),
    );
  }
}
