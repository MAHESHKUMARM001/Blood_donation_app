import 'package:flutter/material.dart';

class EmailList extends StatefulWidget {
  @override
  _EmailListState createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  List<String> emailAddresses = [
    'email1@example.com',
    'email2@example.com',
    'email3@example.com',
    // Add more email addresses as needed
  ];

  List<String> selectedEmails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email List'),
      ),
      body: ListView.builder(
        itemCount: emailAddresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(emailAddresses[index]),
            leading: Checkbox(
              value: selectedEmails.contains(emailAddresses[index]),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedEmails.add(emailAddresses[index]);
                  } else {
                    selectedEmails.remove(emailAddresses[index]);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          printSelectedEmails();
        },
        child: Icon(Icons.send),
      ),
    );
  }

  void printSelectedEmails() {
    print('Selected Emails:');
    for (String email in selectedEmails) {
      print(email);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: EmailList(),
  ));
}
