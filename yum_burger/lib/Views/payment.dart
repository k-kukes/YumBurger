import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
import 'package:yum_burger/Controllers/notifications_controller.dart';
import 'package:yum_burger/Controllers/order_controller.dart';
import 'package:yum_burger/Controllers/payment_controller.dart';

class PaymentView extends StatefulWidget {
  final double totalAmount;
  final String userId;

  const PaymentView({super.key, required this.totalAmount, required this.userId});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  // Initialize the Controller
  final PaymentController _controller = PaymentController();
  CartController cartController = CartController();
  OrderController orderController = OrderController();
  NotificationController notificationController = NotificationController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPayPressed() async {
    setState(() => _isLoading = true);

    bool success = await _controller.handlePayment(context, widget.totalAmount);

    setState(() => _isLoading = false);

    if (success && mounted) {
      orderController.saveOrder(widget.userId, widget.totalAmount);
      cartController.deleteEntireCart(widget.userId);
      notificationController.createNotification('YumBurger', "You recently made a purchase of \$${widget.totalAmount.toStringAsFixed(2)}.");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Payment Successful!"),
          content: Text("You paid \$${widget.totalAmount.toStringAsFixed(2)} and earned points!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Thank you"),
            )
          ],
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Payment Declined. Check Card # (16) or Expiry (MM/YY)."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Checkout"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total: \$${widget.totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            const Text("Card Number", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _controller.cardNumController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              decoration: const InputDecoration(
                hintText: "1234 5678 1234 5678",
                border: OutlineInputBorder(),
                counterText: "",
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expiry Date", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _controller.expiryController,
                        keyboardType: TextInputType.datetime,
                        maxLength: 5,
                        decoration: const InputDecoration(
                          hintText: "MM/YY",
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CVV", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _controller.cvvController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "123",
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onPayPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Confirm Payment", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}