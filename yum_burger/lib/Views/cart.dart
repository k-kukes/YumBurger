import 'package:flutter/material.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Hamburger 1",
      "quantity": 2,
      "base_price": 12.99,
      "image": null,
    },
    {
      "name": "Hamburger 2",
      "quantity": 1,
      "base_price": 45.99,
      "image": null,
    },
    {
      "name": "Hamburger 3",
      "quantity": 12,
      "base_price": 1.99,
      "image": null,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2e9db),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MY CART",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(bottom:15),
                    child: _buildCartItems(cartItems[index]),
                  );
                  }
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal:", style: TextStyle(fontSize: 18),),
                Text("19.99\$:", style: TextStyle(fontSize: 18),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery fee:", style: TextStyle(fontSize: 18),),
                Text("3.99\$:", style: TextStyle(fontSize: 18),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tax:", style: TextStyle(fontSize: 18),),
                Text("2.99\$:", style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                Text("149.99\$:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                    child: Text("ORDER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildCartItems(Map<String, dynamic> cartItem) {
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
          child: cartItem['image'] == null ? Icon(Icons.image) : Image.network(cartItem['image']),
        ),
        SizedBox(width: 15,),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${cartItem['name']}",
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
                ),
                Row(
                  children: [
                    Text("+", style:TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                    SizedBox(width: 15,),
                    Text("${cartItem['quantity']}", style:TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),),
                    SizedBox(width: 15,),
                    Text("-", style:TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),)
                  ],
                ),
                Text("${cartItem['base_price'] * cartItem['quantity']}\$",style:TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
                )
              ],
            ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: Colors.grey[800],))
      ],
    ),
  );
}
