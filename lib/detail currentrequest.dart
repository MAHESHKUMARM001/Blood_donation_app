
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



class RequestDetailsPage extends StatefulWidget {
  final String Name;
  final String request;
  final String hospitalName;
  final String location;
  final String bloodGroup;
  final String dateTimeSubmitted;
  final String contactNumber;
  final String userEmail;
  final String reid;


  RequestDetailsPage({
    required this.Name,
    required this.request,
    required this.hospitalName,
    required this.location,
    required this.bloodGroup,
    required this.dateTimeSubmitted,
    required this.contactNumber,
    required this.userEmail,
    required this.reid,


  });

  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}
class _RequestDetailsPageState extends State<RequestDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Position currentlat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Image.asset(
                      'assets/images/Blood.png',
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Blood Group Container Card
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Group",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${widget.bloodGroup}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Other Information Container Card
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                "Name : ${widget.Name}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Hospital ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.hospitalName}",
                                style: TextStyle(
                                  color: Color.fromARGB(100, 35, 34, 34),
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.request}",
                                style: TextStyle(
                                  color: Color.fromARGB(100, 35, 34, 34),
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Contact No",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.contactNumber}",
                                style: TextStyle(
                                  color: Color.fromARGB(100, 35, 34, 34),
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Location",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.location}",
                                style: TextStyle(
                                  color: Color.fromARGB(100, 35, 34, 34),
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Contact Throw Container
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "-   Contact Throw   -",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(100, 225, 227, 230),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(height: 15),
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
                                  // Add functionality for the call icon here
                                  launch("tel:${widget.contactNumber}");
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
                                  // Add functionality for the call icon here
                                  _launchMail(widget.request);                                },
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  // Add functionality for the call icon here
                                  // _textMe("936029513");
                                  launch("sms:${widget.contactNumber}");

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
            ),
          ),

          // Accept Container
          Align(

            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _getCurrentLatlog();
                      storeAcceptDetails();
                      // Add your onPressed logic here
                      handleDonorAcceptance(context);

                    },
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),


                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      // Add your accept button functionality here
                      _getCurrentLatlog();
                      storeAcceptDetails();


                    },
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),

            ),
          ),
        ],
      ),
    );
  }
  Future<void> storeAcceptDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If there are documents with the specified email, print the name
        querySnapshot.docs.forEach((doc) async {
          var donarname = doc['name']; // Access the 'name' field
          var donarblood = doc['bloodGroup']; // Access the 'name' field

          var donaremail = doc['email'];
          var donarecontact = doc['mobile'];
          var donarlocation = doc['location'];

          print('Name for email' +widget.userEmail+ '$donarname');
          print('Name for email' +widget.userEmail+ '$donarblood');
          print('Name for email' +widget.userEmail+ '$donaremail');
          print('Name for email' +widget.userEmail+ '$donarecontact');
          print('Name for email' +widget.userEmail+ '$donarlocation');

          await _firestore.collection('acceptance').add({
            'requestname': widget.Name,
            'requsetEmail': widget.request,
            'requestconatact': widget.contactNumber,
            'acceptname':'$donarname',
            'acceptblood':'$donarblood',
            'acceptemail':'$donaremail',
            'acceptcontact':'$donarecontact',
            'acceptlocation':'$donarlocation',
            'acceptlat': currentlat.latitude,
            'acceptlon': currentlat.longitude,
            'reid':widget.reid
                      // Add other fields as needed
          });
        });
      } else {
        print('No data found for email email');
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }
  _getCurrentLatlog() async {
    try {
      LocationPermission locationPermission1 = await Geolocator.requestPermission();

      if (locationPermission1 == LocationPermission.always ||
          locationPermission1 == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          currentlat = position;
        });
      }
      else{
        print("location persmisson is denied");
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  Future<void> _launchUrl(String url) async {
    if (!await launch(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void handleDonorAcceptance(BuildContext context) {
    // Replace these coordinates with actual donor and destination coordinates
    double donorLat = currentlat.latitude;
    double donorLng = currentlat.longitude;
    double destinationLat = 6;
    double destinationLng = 6;

    // Construct the Google Maps URL directly in the function
    String mapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=$donorLat,$donorLng&destination=$destinationLat,$destinationLng&travelmode=driving';

    // Open Google Maps
    _launchUrl(mapsUrl);
  }
  // Future<void> storeAcceptDetails() async {
  //   try {
  //     // Get the user data based on the email
  //     String userEmail1 = widget.userEmail;
  //
  //     QuerySnapshot usersSnapshot = await _firestore
  //         .collection('users')
  //         .where('email', isEqualTo: userEmail1)
  //         .get();
  //
  //     // Check if the user with the given email exists
  //     if (usersSnapshot.docs.isNotEmpty) {
  //       // Assuming there is only one user with the given email
  //       var userData = usersSnapshot.docs[0].data();
  //
  //       // Another way to get data
  //       Map<String, dynamic> userDataMap = usersSnapshot.docs[0].data() as Map<String, dynamic>;
  //
  //       // Use square brackets or dot notation to access 'name' property
  //       String userName = userData['email'] as String;
  //
  //       // Check if userName is not null before using it
  //       if (userName != null) {
  //         // Add other fields based on your user data structure
  //
  //         // Now you can store the details in the "acceptance" collection
  //         await _firestore.collection('acceptance').add({
  //           'requestname': widget.Name,
  //           'requsetEmail': widget.request,
  //           'requestconatact': widget.contactNumber,
  //           'acceptname': userName,
  //           // Add other fields as needed
  //         });
  //
  //         print('Request details stored successfully!');
  //       } else {
  //         print('User name is null for email $userEmail1');
  //       }
  //     } else {
  //       print('User with email $userEmail1 not found.');
  //     }
  //   } catch (e) {
  //     // Handle errors
  //     print('Error storing request details: $e');
  //   }
  // }






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