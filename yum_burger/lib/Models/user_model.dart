import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  static final UserModel _singleton = UserModel._instance();
  var currentUser = null;

  factory UserModel() {
    return _singleton;
  }

  UserModel._instance();

  Future<String> addUser(username, password, fullName, email) async {
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        fullName.isNotEmpty &&
        email.isNotEmpty) {
      if (await usernameExists(username) == false) {
        DocumentReference userDoc = await users.add({
          'username': username,
          'password': password,
          'fullName': fullName,
          'email': email,
          'type': 'customer'
        });
        userDoc.collection('Cart');
        return 'Successfully created your account!';
      } else {
        return 'Username already exists!';
      }
    } else {
      return 'Can not leave fields empty!';
    }
  }

  Future<void> resetPassword(id, newPassword) async {
    if (id.isNotEmpty && newPassword.isNotEmpty) {
      try {
        await users.doc(id).update({'password': newPassword});
      } catch (error) {
        print("{Problem occurred while resetting password}");
      }
    }
  }

  Future<bool> validateLogin(username, password) async {
    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      currentUser = querySnapshot.docs[0];
      print(currentUser['type']);
      return true;
    }

    return false;
  }

  void logout() {
    currentUser = null;
  }

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

  getCurrentUser() {
    return currentUser;
  }

  getUsers() {
    return users;
  }

  String getUsername() {
    if (currentUser != null) {
      return currentUser['username'];
    }
    return '';
  }
}
