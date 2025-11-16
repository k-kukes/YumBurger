import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tab_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBEjH28dcF1J6iGhrb8H7jpgWVkSG5vpjQ",
      appId: "1:697511557856:android:7f2f11f0491ff62c9e2e85",
      messagingSenderId: "697511557856",
      projectId: "yumburger-44e34",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyNavigation());
  }
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  String username = '';
  String password = '';
  String fullName = '';
  String email = '';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> addUser() async {
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        fullName.isNotEmpty &&
        email.isNotEmpty) {
      try {
        await users.add({
          'username': username,
          'password': password,
          'fullName': fullName,
          'email': email,
        });
      } catch (error) {
        print("{Problem occurred while creating account}");
      }

      setState(() {
        username = '';
        password = '';
        fullName = '';
        email = '';
      });
    }
  }

  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    fullNameController.clear();
    emailController.clear();
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
            MaterialPageRoute(builder: (context) => HomePage()),
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
            Text('Create Account', style: TextStyle(fontSize: 30)),
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
                    controller: passwordController,
                    onChanged: (value) => password = value,
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: fullNameController,
                    onChanged: (value) => fullName = value,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
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
                      hintText: 'Email',
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
                onPressed: () {
                  addUser();
                  clearForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text('Already have an account?', style: TextStyle(fontSize: 20)),
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
                'Login',
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Login Page')));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Home'));
  }
}

//
//           ElevatedButton(
//             onPressed: () {
//               addEmployee();
//               clearForm();
//             },
//             child: Text('Add employee to FS'),
//           ),
//           SizedBox(height: 10),
