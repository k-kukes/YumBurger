import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yum_burger/Models/user_model.dart';

class UserController {
  static final UserController _singleton = UserController._instance();
  UserModel userModel = new UserModel();

  factory UserController() {
    return _singleton;
  }

  UserController._instance();

  Future<CollectionReference<Object?>> getUsersCollection() async {
    CollectionReference<Object?> users = userModel.getUsers();
      return users;
  }

  getCurrentUser() {
    return userModel.getCurrentUser();
  }

  bool checkUsername(String username) {
    try {
      userModel.usernameExists(username);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> validateLogin(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
       await userModel.validateLogin(username, password);
        return true;
      } catch (error) {
        return false;
      }
    }
      return false;
  }

  addUser(String username, String password, String fullName, String email) {
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        fullName.isNotEmpty &&
        email.isNotEmpty
    ) {
      try {
        userModel.addUser(username, password, fullName, email);
      } catch(error) {
        return;
      }
    }
  }

  bool logout() {
    if (getCurrentUser() != null) {
      userModel.logout();
      return true;
    }
    return false;
  }

}
