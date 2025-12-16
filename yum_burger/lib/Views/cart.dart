import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yum_burger/Controllers/burger_controller.dart';
import 'package:yum_burger/Controllers/cart_controller.dart';
import 'package:yum_burger/Controllers/drink_controller.dart';
import 'package:yum_burger/Controllers/user_controller.dart';
import 'package:yum_burger/Views/payment.dart';
import 'package:yum_burger/l10n//app_localizations.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  UserController userController = UserController();
  CartController cartController = CartController();
  BurgerController burgerController = BurgerController();
  DrinkController drinkController = DrinkController();
  CollectionReference<Object?>? cartItems;
  bool userExist = false;
  bool isCartEmpty = true;
  int cartLength = 0;
  double subtotal = 0;
  double tax = 0;
  double total = 0;

  @override
  void initState() {
    checkForUser();
    if (userExist) {
      loadUserCart();
    }
    super.initState();
  }

  void checkForNotifications() {

  }

  void checkForUser() {
    setState(() {
      userExist = userController.getCurrentUser() != null ? true : false;
    });
  }

  Future<void> loadUserCart() async {
    var user = userController.getCurrentUser();
    CollectionReference<Object?>? cart = await cartController
        .getUserCartCollection(user.id);

    bool empty = false;
    int length = 0;
    double _subtotal = 0;
    double _tax = 0;
    double _total = 0;

    if (cart != null) {
      empty = await cartController.isCartEmpty(cart!);
      length = await cartController.getCartLength(cart);
      _subtotal = await cartController.getSubtotal(cart, user.id);
      _tax = await cartController.getTax(cart, user.id);
      _total = await cartController.getTotal(cart, user.id);
    }

    setState(() {
      cartItems = cart;
      isCartEmpty = empty;
      cartLength = length;
      subtotal = _subtotal;
      tax = _tax;
      total = _total;
    });
  }

  Future<void> updateCart(userId) async {
    CollectionReference<Object?>? cart = await cartController
        .getUserCartCollection(userId);
    double newSubtotal = 0;
    int newLength = 0;
    double newTax = 0;
    double newTotal = 0;

    if (cart != null) {
      newSubtotal = await cartController.getSubtotal(cart, userId);
      newLength = await cartController.getCartLength(cart);
      newSubtotal = await cartController.getSubtotal(cart, userId);
      newTax = await cartController.getTax(cart, userId);
      newTotal = await cartController.getTotal(cart, userId);
    }
    setState(() {
      subtotal = newSubtotal;
      cartLength = newLength;
      total = newTotal;
      tax = newTax;
    });
  }

  Widget _buildCartItems(DocumentSnapshot cart, DocumentSnapshot itemInCart) {
    String type = cart['type'];
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
            child: itemInCart['image'].startsWith('assets/')
                ? Image.asset(
              itemInCart['image'],
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            )
                : Image.memory(
              base64Decode(itemInCart['image']),
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemInCart['name'],
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await cartController.addQuantityToCartItem(
                          userController.getCurrentUser().id,
                          cart.id,
                        );
                        await updateCart(userController.getCurrentUser().id);
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
                      "${cart['quantity']}",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 15),
                    TextButton(
                      onPressed: () async {
                        await cartController.decreaseQuantityToCartItem(
                          userController.getCurrentUser().id,
                          cart.id,
                        );
                        await updateCart(userController.getCurrentUser().id);
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
                Builder(
                  builder: (context) {
                    Map<String, dynamic> cartData = cart.data() as Map<String, dynamic>;

                    double finalPrice = (itemInCart['price'] as num).toDouble();

                    if (cartData.containsKey('overridePrice')) {
                      finalPrice = (cartData['overridePrice'] as num).toDouble();
                    }

                    if (finalPrice == 0) {
                      return const Text(
                        "FREE",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    }

                    // 5. Otherwise, show the calculated price
                    return Text(
                      "${(finalPrice * cart['quantity']).toStringAsFixed(2)}\$",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await cartController.deleteCartItem(
                userController.getCurrentUser().id,
                cart.id,
              );
              await updateCart(userController.getCurrentUser().id);
            },
            icon: Icon(Icons.delete, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xfff2e9db),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${t.myCart}($cartLength)",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            !userExist
                ? Expanded(
                    child: Text(
                      t.mustLogin,
                      style: TextStyle(fontSize: 18, color: Colors.brown),
                    ),
                  )
                : isCartEmpty
                ? Expanded(
                    child: Text(
                      t.cartEmpty,
                      style: TextStyle(fontSize: 18, color: Colors.brown),
                    ),
                  )
                : SizedBox(
                    height: 400,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: cartItems?.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text(t.cartEmpty));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot cart = snapshot.data!.docs[index];
                            String itemId = cart['item'];

                            return FutureBuilder<DocumentSnapshot>(
                              future: cart['type'] == 'Burger'
                                  ? burgerController.getBurgerDocumentById(
                                      itemId,
                                    )
                                  : drinkController.getDrinkDocumentById(
                                      itemId,
                                    ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return _buildCartItems(cart, snapshot.data!);
                                }
                                return Text(t.error);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

            //
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.subtotal, style: TextStyle(fontSize: 18)),
                Text(
                  "${(subtotal).toStringAsFixed(2)}\$:",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.deliveryFee, style: TextStyle(fontSize: 18)),
                Text("0.00\$:", style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.tax, style: TextStyle(fontSize: 18)),
                Text(
                  "${(tax).toStringAsFixed(2)}\$:",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.total,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${(total).toStringAsFixed(2)}\$:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                width: 500,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    var user = userController.getCurrentUser();
                    if (total <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.noBuy)));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentView(totalAmount: total, userId: user.id,)));
                    }
                  },
                  child: Text(
                    t.order,
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
