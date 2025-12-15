import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
       bool success = await userModel.validateLogin(username, password);
       return success;
      } catch (error) {
        print(error);
      }
    }
      return false;
  }

  Future<String> addUser(String username, String password, String fullName, String email) async {
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        fullName.isNotEmpty &&
        email.isNotEmpty
    ) {
      var validNames = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)+$');
      var validEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!validNames.hasMatch(fullName)) {
        return 'Incorrect value used to write full name!';
      }
      if (!validEmail.hasMatch(email)) {
        return 'Incorrect value used for email!';
      }
      if (password.length < 6) {
        return 'Password length must be at least 7';
      }
      try {
        String result = await userModel.addUser(username, password, fullName, email);
        return result;
      } catch(error) {
        return 'Error while creating account. Please try again!';
      }
    } else {
      return 'Can not leave fields empty!';
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
