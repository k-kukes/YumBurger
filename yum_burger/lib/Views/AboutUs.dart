import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautiful Lake'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage('asset/lake-widget-sample.jpg'), width: 300, height: 300,),
                Image(image: AssetImage('asset/lake-widget-sample2.jpg'), width: 300, height: 300,),
                Image(image: AssetImage('asset/lake-widget-sample3.jpg'), width: 300, height: 300,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.mail_lock,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 7.5,),
                    Text('Call'),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.podcasts,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 7.5,),
                    Text('Share'),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.beach_access,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 7.5,),
                    Text('Route'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

