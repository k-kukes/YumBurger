import 'package:flutter/material.dart';

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
            SizedBox(height: 25),
            Text("MY CART",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),
            ),
            SizedBox(height: 20),
            _buildCartItems(),
            SizedBox(height: 15,),
            _buildCartItems(),
            SizedBox(height: 15,),
            _buildCartItems(),
            SizedBox(height: 30,),
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

Widget _buildCartItems() {
  return Container(
    width: 500,
    height: 125,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadiusGeometry.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadiusGeometry.circular(5),
            border: Border.all(color: Colors.black12),
          ),
          child: Icon(Icons.image, color: Colors.black38,),
        ),
        SizedBox(width: 15,),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("HAMBURGER 1",
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
                    Text("2", style:TextStyle(
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
                Text("90.99\$",style:TextStyle(
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
