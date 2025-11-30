import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import '../Controllers/tab_navigation.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPage();
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  UserController userController = UserController();
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    var currentUser = await userController.getCurrentUser();
    setState(() {
      user = currentUser;
      print(user);
    });
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
            Text('Account Info', style: TextStyle(fontSize: 30)),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  Text('Username', style: TextStyle(fontSize: 25),),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: user == null ? Text('username') : Text("${user['username']}", style: TextStyle(color: Colors.black, fontSize: 25),),
                  ),
                  SizedBox(height: 15),
                  Text('Password', style: TextStyle(fontSize: 25),),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: user == null ? Text('password') : Text("${user['password']}", style: TextStyle(color: Colors.black, fontSize: 25),),
                  ),
                  SizedBox(height: 15),
                  Text('Full Name', style: TextStyle(fontSize: 25),),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: user == null ? Text('full name') : Text("${user['fullName']}", style: TextStyle(color: Colors.black, fontSize: 25),),
                  ),
                  SizedBox(height: 15),
                  Text('Email', style: TextStyle(fontSize: 25),),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: user == null ? Text('email') : Text("${user['email']}", style: TextStyle(color: Colors.black, fontSize: 25),),
                  ),
                  SizedBox(height: 15),
                  Text('Settings', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.light_mode, size: 40,),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.language, size: 40,),
                      ),
                    ],
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
