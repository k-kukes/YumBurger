import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/create_account.dart';
import 'package:yum_burger/login.dart';
import 'create_account.dart';
import 'tab_navigation.dart';
import 'login.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  String newPassword = '';
  String confirmPassword = '';
  String username = '';

  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<bool> usernameExists(String checkUsername) async {
    try {
      QuerySnapshot querySnapshot = await users
          .where('username', isEqualTo: checkUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
    } catch (error) {
      print(error);
      print('Error with usernameExists check');
    }
    return false;
  }

  Future<void> resetPassword() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        username.isNotEmpty) {
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Confirm Password and Password don\'t match')),
        );
      } else {
        try {
          if (await usernameExists(username)) {
            QuerySnapshot querySnapshot = await users
                .where('username', isEqualTo: username)
                .get();

            String docId = querySnapshot.docs.first.id;

            await users.doc(docId).update({'password': newPassword});

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset successfully!')),
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
            ).showSnackBar(SnackBar(content: Text('Username does not exist!')));
          }
        } catch (error) {
          print(error);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error resetting password.')));
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Fields can not be empty!')));
    }
  }

  void clearForm() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    usernameController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Go back home'),
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
            Text('Reset Password', style: TextStyle(fontSize: 30)),
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
                      hintText: 'Username',
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
                      hintText: 'Password',
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
                      hintText: 'Confirm Password',
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
                      'Reset Password',
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
                    'Remember the password?',
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
                      'Go to Login',
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
