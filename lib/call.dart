import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Calltheapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Call App Button'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              launch("tel:+91 8489414092"); // Replace with the desired phone number
            },
            child: Text('Open Call App'),
          ),
        ),
      ),
    );
  }
}
