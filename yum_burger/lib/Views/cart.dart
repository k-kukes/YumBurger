import 'package:flutter/material.dart';
import '../Controllers//cart_controller.dart';
import '../Models/cart_model.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2e9db),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MY CART (${CartController.getCartLength()})",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: CartController.getCartLength(),
                itemBuilder: (context, index) {
                  CartItem currentCart = CartController.getCartItems()[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: _buildCartItems(currentCart, index),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal:", style: TextStyle(fontSize: 18)),
                Text("${(CartController.getSubtotal()).toStringAsFixed(2)}\$:", style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery fee:", style: TextStyle(fontSize: 18)),
                Text("0.00\$:", style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tax:", style: TextStyle(fontSize: 18)),
                Text("${(CartController.getTax()).toStringAsFixed(2)}\$:", style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${(CartController.getTotal()).toStringAsFixed(2)}\$:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "ORDER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCartItems(CartItem cartItem, int index) {
  return Container(
    width: 500,
    height: 125,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12),
          ),
          child: Image.asset(cartItem.image),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartItem.name,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      CartController.increaseQuantity(index);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "${cartItem.quantity}",
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 15),
                  TextButton(
                    onPressed: () {
                      CartController.decreaseQuantity(index);
                    },
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${(cartItem.base_price * cartItem.quantity).toStringAsFixed(2)}\$",
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            CartController.removeCartItem(cartItem);
          },
          icon: Icon(Icons.delete, color: Colors.grey[800]),
        ),
      ],
    ),
  );
}
