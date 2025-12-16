import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/create_account.dart';
import 'package:yum_burger/Views/login.dart';
import 'package:yum_burger/Models/user_model.dart';
import 'create_account.dart';
import '../Controllers/tab_navigation.dart';
import 'login.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  UserController userController = new UserController();
  String newPassword = '';
  String confirmPassword = '';
  String username = '';

  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> resetPassword() async {
    final t = AppLocalizations.of(context)!;
    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        username.isNotEmpty) {
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.passNoMatch)),
        );
      } else {
        try {
          if (await userController.checkUsername(username)) {
            CollectionReference<Object?>? users = await userController.getUsersCollection();
            QuerySnapshot querySnapshot = await users
                .where('username', isEqualTo: username)
                .get();

            String docId = querySnapshot.docs.first.id;

            await users.doc(docId).update({'password': newPassword});

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(t.passResetSuccess)),
            );

            clearForm();
            setState(() {
              newPassword = '';
              confirmPassword = '';
              username = '';
            });
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(t.usernameNoExist)));
          }
        } catch (error) {
          print(error);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.errorResetPass)));
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.fillFields)));
    }
  }

  void clearForm() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    usernameController.clear();
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
            Text(t.resetPassword, style: TextStyle(fontSize: 24)),
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
                    controller: newPasswordController,
                    onChanged: (value) => newPassword = value,
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
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: confirmPasswordController,
                    onChanged: (value) => confirmPassword = value,
                    decoration: InputDecoration(
                      hintText: t.confPass,
                      filled: true,
                      fillColor: Colors.grey[350],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      resetPassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      t.resetPassword,
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
                  Text(
                    t.rememberPass,
                    style: TextStyle(fontSize: 20),
                  ),
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
                      t.goToLogin,
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
          ],
        ),
      ),
    );
  }
}
