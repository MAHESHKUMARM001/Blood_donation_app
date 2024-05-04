import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail currentrequest.dart';
import 'showmorerequesr.dart';


class UserData1 {
  final String name;
  final String bloodGroup;
  final String contactNo;
  final String reid;

  // final String hospitalname;
  // Add other fields as needed

  UserData1({
    required this.name,
    required this.bloodGroup,
    required this.contactNo,
    required this.reid,


    // required this.hospitalname,
    // Add other fields as needed
  });
}


class RequestHistory extends StatefulWidget {
  final String userId;
  final String userEmail;

  // Constructor
  RequestHistory(this.userId, this.userEmail);



  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserData1 userData1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Requests"),
      ),
      body: FutureBuilder(
        future: getUserRequests1(widget.userEmail),
        builder: (context, AsyncSnapshot<List<UserData1>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<UserData1> userList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                UserData1 user = userList[index];
                return Container(
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
                      // First Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Circle Avatar with Text A+
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
                      SizedBox(width: 16.0), // Add spacing between columns
                      // Second Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Row with Name, Blood Group, and Email
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
                                      " ConatactNo : ${user.contactNo}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0), // Add spacing between rows
                            // Second Row with Call Icon and Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowRequestHistory(
                                          Name: user.name,
                                          Email: widget.userEmail,
                                          // hospitalName: user.hospitalname,
                                          // location: user.currentLocation,
                                          bloodGroup: user.bloodGroup,

                                          contactNumber: user.contactNo,
                                          reid: user.reid
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("More"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );


              },
            );
          }
        },
      ),
    );
  }

  Future<List<UserData1>> getUserRequests1(String currentUserEmail) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('requesthistory')
        .where('requestEmail', isEqualTo: currentUserEmail)
        .get();

    List<UserData1> userList = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      userList.add(UserData1(
        name: data['patientName'] ?? '',
        bloodGroup: data['bloodGroup'] ?? '',
        contactNo: data['conatctno'] ?? '',
        reid: data['reid'] ?? '',
        // currentLocation: data['currentLocation'] ?? '',
        // hospitalname: data['hospitalName'] ?? '',
        // Add other fields as needed
      ));
    }

    return userList;
  }
}
