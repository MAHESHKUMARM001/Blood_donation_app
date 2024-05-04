import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail currentrequest.dart';

class UserData {
  final String name;
  final String email;
  final String bloodGroup;
  final String contactNo;
  final String currentLocation;
  final String hospitalname;
  final String reid;

  UserData({
    required this.name,
    required this.email,
    required this.bloodGroup,
    required this.contactNo,
    required this.currentLocation,
    required this.hospitalname,
    required this.reid,
  });
}

class Comerequest extends StatefulWidget {
  final String userId;
  final String userEmail;

  Comerequest(this.userId, this.userEmail);

  @override
  _ComerequestState createState() => _ComerequestState();
}

class _ComerequestState extends State<Comerequest> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
             // Set the background color of the container to red
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Received Requests",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                ),
              ),
            ),
            SizedBox(height: 15), // Add some spacing between the title and the list
            Expanded(
              child: FutureBuilder(
                future: getUserRequests(widget.userEmail),
                builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<UserData> userList = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        UserData user = userList[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        "${user.bloodGroup}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name: ${user.name}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Blood Group: ${user.bloodGroup}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                " Location : Sankarankovl",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.green,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.call,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    onPressed: () {
                                                      launch("tel:${user.contactNo}");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Call",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => RequestDetailsPage(
                                                    Name: user.name,
                                                    request: user.email,
                                                    hospitalName: user.hospitalname,
                                                    location: user.currentLocation,
                                                    bloodGroup: user.bloodGroup,
                                                    dateTimeSubmitted: DateTime.now().toString(),
                                                    contactNumber: user.contactNo,
                                                    userEmail: widget.userEmail,
                                                    reid: user.reid,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text("more"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<UserData>> getUserRequests(String currentUserEmail) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('requests')
        .where('donorEmails', isEqualTo: currentUserEmail)
        .get();

    List<UserData> userList = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      userList.add(UserData(
        name: data['submittedBy'] ?? '',
        email: data['requestEmail'] ?? '',
        bloodGroup: data['bloodGroup'] ?? '',
        contactNo: data['contactNo'] ?? '',
        currentLocation: data['currentLocation'] ?? '',
        hospitalname: data['hospitalName'] ?? '',
        reid: data['reid'] ?? '',
      ));
    }

    return userList;
  }
}
