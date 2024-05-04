
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class NotificationSender extends StatefulWidget {
  @override
  _NotificationSenderState createState() => _NotificationSenderState();
}

class _NotificationSenderState extends State<NotificationSender> {
  TextEditingController _tokenController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send FCM Notification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(labelText: 'FCM Token'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                sendNotification(
                  _tokenController.text,
                  _titleController.text,
                  _bodyController.text,
                );
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendNotification(String to, String title, String body) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final serverKey = 'AAAATwZ8Vo0:APA91bHllel8eCUy226qYceXCa66h78PDF8C0M0OZGi7z2JAV7THcw-6azQHpv6l3Y4Xuq-9nvWFqxgyg3sz-Ycg6z0hgatgZtJVn5BOk0uEW4wQh9eLxSpXmlRMuKMhEM9iP_UWPQm5';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final payload = {
      'notification': {'title': title, 'body': body},
      'to': to,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification sent successfully')),
      );
    } else {
      print('Failed to send notification. Error: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification')),
      );
    }
  }
}
