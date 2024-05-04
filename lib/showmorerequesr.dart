import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail currentrequest.dart';
class UserData {
  final String acname;
  final String acemail;
  final String acbloodGroup;
  final String accontactNo;
  final String accurrentLocation;

  // Add other fields as needed

  UserData({
    required this.acname,
    required this.acemail,
    required this.acbloodGroup,
    required this.accontactNo,
    required this.accurrentLocation,

    // Add other fields as needed
  });
}


class ShowRequestHistory extends StatefulWidget {
  final String Name;
  final String Email;
  final String bloodGroup;
  final String contactNumber;
  final String reid;

  // Constructor
  ShowRequestHistory({
    required this.Name,
    required this.Email,
    required this.bloodGroup,
    required this.contactNumber,
    required this.reid,
  });



  @override
  _ShowRequestHistoryState createState() => _ShowRequestHistoryState();
}

class _ShowRequestHistoryState extends State<ShowRequestHistory> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
            "Request Person Details",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 30
            ),
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,20,10,20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5,5,5,5),
                child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Name ${widget.Name}",
                    ),
                    Text(
                      "Email ${widget.Email}",
                    ),
                    Text(
                      'Blood Group ${widget.bloodGroup}'
                    ),
                    Text(
                      "Conatct No ${widget.contactNumber}",
                    ),
                  ],
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,20,10,20),
              child: Text(
                "The acceptance",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,

                ),
              ),
            ),
            Container(
              child:  FutureBuilder(
                future: getUserRequests(widget.reid),
                builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<UserData> userList = snapshot.data ?? [];
                    return Container(
                      height: 300, // Set a fixed height or adjust according to your UI
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          UserData user = userList[index];
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                                "Name: ${user.acname}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Blood Group: ${user.acbloodGroup}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                " Contact No : ${user.accontactNo}",
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
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    launch("tel:${user.accontactNo}");
                                                  },
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.red,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.mail,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    _launchMail(user.acemail);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),

            )
          ],
        ),
      ),
    );
  }
  Future<List<UserData>> getUserRequests(String reid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('acceptance')
        .where('reid', isEqualTo: reid)
        .get();

    List<UserData> userList = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      userList.add(UserData(
        acname: data['acceptname'] ?? '',
        acemail: data['acceptemail'] ?? '',
        acbloodGroup: data['acceptblood'] ?? '',
        accontactNo: data['acceptcontact'] ?? '',
        accurrentLocation: data['acceptlocation'] ?? '',
        // Add other fields as needed
      ));
    }

    return userList;
  }

  _launchMail(String toEmail) async {
    String email = Uri.encodeComponent(toEmail);
    String subject = Uri.encodeComponent("Hello Flutter");
    String body = Uri.encodeComponent("Hi! I'm comming");
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}
