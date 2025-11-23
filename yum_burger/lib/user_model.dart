import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');

Future<void> addUser(username, password, fullName, email) async {
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
  }
}

Future<void> resetPassword(id, newPassword) async {
  if (id.isNotEmpty && newPassword.isNotEmpty) {
    try {
      await users.doc(id).update({
        'password': newPassword
      });
    } catch (error) {
      print("{Problem occurred while resetting password}");
    }
  }
}

Future<bool> validateLogin(username, password) async {
  if (username.isNotEmpty && password.isNotEmpty) {
    try {
      QuerySnapshot querySnapshot = await users
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
    } catch (error) {
      print(error);
      print('Problem occurred with login');
    }
  }
  return false;
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
