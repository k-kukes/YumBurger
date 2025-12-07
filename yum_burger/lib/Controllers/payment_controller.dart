import 'package:flutter/material.dart';
import '../Controllers/user_controller.dart';
import '../controllers/reward_controller.dart';

class PaymentController {

  final TextEditingController cardNumController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final RewardsController _rewardsController = RewardsController();
  final UserController _userController = UserController();

  Future<bool> handlePayment(BuildContext context, double totalAmount) async {
    String cardNum = cardNumController.text;
    String expiry = expiryController.text;
    String cvv = cvvController.text;

    if (!_isValidCardNumber(cardNum)) {
      _showError(context, "Invalid Card Number. Must be 16 digits.");
      return false;
    }

    if (!_isValidCVV(cvv)) {
      _showError(context, "Invalid CVV. Must be 3 digits.");
      return false;
    }

    if (!_isValidExpiryDate(expiry)) {
      _showError(context, "Invalid or Expired Date (MM/YY).");
      return false;
    }

    await Future.delayed(const Duration(seconds: 2));

    final user = _userController.getCurrentUser();
    if (user != null) {
      await _rewardsController.addPointsAfterCheckout(user.id, totalAmount);
    }

    return true;
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }


  bool _isValidCardNumber(String number) {
    String cleanNumber = number.replaceAll(RegExp(r'\D'), '');
    return RegExp(r'^[0-9]{16}$').hasMatch(cleanNumber);
  }

  bool _isValidCVV(String cvv) {
    return RegExp(r'^[0-9]{3}$').hasMatch(cvv);
  }

  bool _isValidExpiryDate(String date) {
    if (!RegExp(r'^[0-9]{2}/[0-9]{2}$').hasMatch(date)) {
      return false;
    }

    try {
      List<String> parts = date.split('/');
      int month = int.parse(parts[0]);
      int year = int.parse(parts[1]);

      if (month < 1 || month > 12) return false;

      DateTime now = DateTime.now();
      int currentYear = now.year % 100;
      int currentMonth = now.month;
      // Check if expired
      if (year < currentYear) return false;
      if (year == currentYear && month < currentMonth) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    cardNumController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }
}