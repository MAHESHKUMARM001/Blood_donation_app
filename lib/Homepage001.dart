import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail currentrequest.dart';
import 'showmorerequesr.dart';

class UserInformation {
  late final String name;
  late final String bloodGroup;

  UserInformation({
    required this.name,
    required this.bloodGroup,
  });
}

class UserData2 {
  final String acname;
  final String acemail;
  final String acbloodGroup;
  final String accontactNo;
  final String accurrentLocation;

  // Add other fields as needed

  UserData2({
    required this.acname,
    required this.acemail,
    required this.acbloodGroup,
    required this.accontactNo,
    required this.accurrentLocation,

    // Add other fields as needed
  });
}

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



class UserData {
  final String name;
  final String email;
  final String bloodGroup;
  final String contactNo;
  final String currentLocation;
  final String hospitalname;
  final String reid;

  // Add other fields as needed

  UserData({
    required this.name,
    required this.email,
    required this.bloodGroup,
    required this.contactNo,
    required this.currentLocation,
    required this.hospitalname,
    required this.reid,

    // Add other fields as needed
  });
}


class HomePage001 extends StatefulWidget {
  final String userId;
  final String userEmail;

  // Constructor
  HomePage001(this.userId, this.userEmail);
  @override
  _HomePage001State createState() => _HomePage001State();
}

class _HomePage001State extends State<HomePage001> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserData userData;
  late UserInformation? userq;

  @override


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,

    body: SingleChildScrollView(
      child: Column(
        children: [

          Stack(
            children: <Widget>[
              // Container(
              //   height: 80,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //
              //     color: Color.fromARGB(255, 187, 18, 18),
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(20),
              //       topLeft: Radius.circular(0),
              //       topRight: Radius.circular(0)
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Center(
                  child: Container(
                    height: 80,
                    width: 300,

                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                          child:  CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.red,
                            child: Text(
                              "",
                              style: TextStyle(color: Colors.white,fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            // Enable text wrapping
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Center(
              child:
              Image.asset(
                'assets/images/banner.jpg',
                height: 200,
                width: 900,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 187, 18, 18),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],

              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 70.0,
                        height: 200.0,
                        child: Image.asset('assets/images/donor logo.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 30, 0),
                    child: Text(
                      'Donor',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(

                    padding: const EdgeInsets.fromLTRB(100, 0, 5, 0),
                    child: TextButton(
                      onPressed: () {
                        print('Text Button Pressed');
                      },

                      child:
                      Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
                future: getUserRequests(widget.userEmail),
                builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<UserData> userList = snapshot.data ?? [];

                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // Horizontal scrolling
                        // itemCount: userList.length > 4 ? 4 : userList.length,
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          UserData user = userList[index];
                          return SizedBox(
                            width: 350,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,10,0),
                              child: Container(

                                 padding: EdgeInsets.all(8.0),
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
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(

                                  children: [
                                    // First Column
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Circle Avatar with Text A+

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30,0,0),
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundColor: Colors.red,
                                            child: Text(
                                              "${user.bloodGroup}",
                                              style: TextStyle(color: Colors.white,fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        )
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
                                          SizedBox(height: 16.0), // Add spacing between rows
                                          // Second Row with Call Icon and Button
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
                                                          // Add functionality for the call icon here
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
                                                        fontWeight: FontWeight.bold
                                                    ),
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
                                                child: Text("More"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );


                        },
                      ),
                    );
                  }
                },
              ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 187, 18, 18),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 50.0,
                        height: 200.0,
                        child: Image.asset('assets/images/Blood_Donation-512.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'Request',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(112, 0, 5, 0),
                    child: TextButton(
                      onPressed: () {
                        print('Text Button Pressed');
                      },
                      child: Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: getUserRequests1(widget.userEmail),
            builder: (context, AsyncSnapshot<List<UserData1>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<UserData1> userList = snapshot.data ?? [];

                return Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    // itemCount: userList.length > 4 ? 4 : userList.length,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      UserData1 user = userList[index];
                      return SizedBox(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Container(

                            padding: EdgeInsets.all(8.0),
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
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: Row(

                              children: [
                              // First Column
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Circle Avatar with Text A+

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 30,0,0),
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      "${user.bloodGroup}",
                                      style: TextStyle(color: Colors.white,fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
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
                                            child: Text("View More Donars Details"),
                                          ),


                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );


                    },
                  ),
                );
              }
            },
          ),

          // Add more widgets as needed
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
      reid:data['reid'] ?? '',

      // Add other fields as needed
    ));
  }

  return userList;
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
  Future<void> nameblood() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      var name = userData['name'];
      var bloodGroup = userData['bloodGroup'];

      // userq.name=name;
      // userq.bloodGroup=bloodGroup;
      // Update nameuser
      // setState(() {
      //   nameuser = name;
      //   blood = bloodGroup;
      // });


    } else {
      print('No user found with the provided email.');

    }
  }

}



