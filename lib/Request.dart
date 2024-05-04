import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:uuid/uuid.dart';

class SubmitFormPage extends StatefulWidget {
  final String userId;
  final String userEmail;

  SubmitFormPage(this.userId, this.userEmail);

  @override
  _SubmitFormPageState createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {
  final TextEditingController submittedByController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();

  late Position currentlat;
  String currentLocation = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 50,
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Request for Blood",
                          style: TextStyle(
                            fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold
                          ),),
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
                    TextFormField(
                      controller: submittedByController,
                      decoration: InputDecoration(
                        labelText: 'Submitted By',
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person,color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the submitter\'s name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: patientNameController,
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        hintText: 'Enter patient\'s name',
                        prefixIcon: Icon(Icons.person,color: Colors.red,),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the patient\'s name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: bloodGroupController,
                      decoration: InputDecoration(
                        labelText: 'Blood Group',
                        hintText: 'Enter blood group',
                        prefixIcon: Icon(Icons.opacity,color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the blood group';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: hospitalNameController,
                      decoration: InputDecoration(
                        labelText: 'Hospital Name',
                        hintText: 'Enter hospital name',
                        prefixIcon: Icon(Icons.local_hospital,color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the hospital name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: contactNoController,
                      decoration: InputDecoration(
                        labelText: 'Contact No',
                        hintText: 'Enter contact number',
                        prefixIcon: Icon(Icons.phone,color: Colors.red),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the contact number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: TextEditingController(text: currentLocation),
                            decoration: InputDecoration(
                              labelText: 'Current Location',
                              hintText: 'Enter current location',
                              prefixIcon: Icon(Icons.location_on,color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the current location';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.location_on,color: Colors.red),
                          onPressed: () async {
                            String location = await getCurrentLocation();
                            setState(() {
                              currentLocation = location;
                            });
                            _getCurrentLatlog();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Store the details in the request collection
                          await storeRequestDetails();

                          // You can add navigation logic to your desired page
                          // For example, navigate back to the home page
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Set the background color to red
                        onPrimary: Colors.white, // Set the text color to white
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
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

  Future<String> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = placemarks.first.toString();
      return address;
    } catch (e) {
      print('Error getting current location: $e');
      return "";
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
        print("location permisson denide");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> storeRequestDetails() async {
    try {
      // Get the blood group entered in the form
      String requestedBloodGroup = bloodGroupController.text;

      // Query users with the same blood group
      QuerySnapshot usersSnapshot = await _firestore.collection('users').where('bloodGroup', isEqualTo: requestedBloodGroup).get();

      // Extract emails of potential donors
      List<String> donorEmails = usersSnapshot.docs.map((doc) => doc['email'] as String).toList();

      print(currentlat.latitude);
      print(currentlat.longitude);
      String uniqueId = generateUniqueId();
      print('Unique ID: $uniqueId');

      for(var i=0;i<donorEmails.length;i++) {
        if (widget.userEmail != donorEmails[i]) {
          // Store the request details in the 'requests' collection
          await _firestore.collection('requests').add({
            'submittedBy': submittedByController.text,
            'requestEmail': widget.userEmail, //get the current login use email
            'patientName': patientNameController.text,
            'bloodGroup': requestedBloodGroup,
            'hospitalName': hospitalNameController.text,
            'contactNo': contactNoController.text,
            'currentLocation': currentLocation,
            'donorEmails': donorEmails[i],
            // 'submittedUserId': widget.userId,
            "relocationlat":currentlat.latitude,
            "relocationlog":currentlat.longitude,
            'reid':uniqueId
          });
          sendEmail(donorEmails[i],requestedBloodGroup);
        }
      }
      await _firestore.collection('requesthistory').add({
        'submittedBy': submittedByController.text,
        'requestEmail': widget.userEmail, //get the current login use email
        'patientName': patientNameController.text,
        'bloodGroup': requestedBloodGroup,
        'hospitalName': hospitalNameController.text,
        'conatctno': contactNoController.text,
        'reid':uniqueId
      });
      // for(var i=0;i<donorEmails.length;i++) {
      // await EmailService.sendEmail(recipientEmail, subject, body);
      // }
      // Print success message
      print('Request details stored successfully!');
    } catch (e) {
      // Handle errors
      print('Error storing request details: $e');
    }
  }
  String generateUniqueId() {
    var uuid = Uuid();
    return uuid.v4();
  }

  Future<void> sendEmail(String recipientEmail, String blood) async {
    final String senderEmail = '953621104025@ritrjpm.ac.in'; // Replace with your email
    final String senderPassword = 'mahesh001M'; // Replace with your password

    final smtpServer = gmail(senderEmail, senderPassword);

    final message = Message()
      ..from = Address(senderEmail, 'Blood Donation App')
      ..recipients.add(recipientEmail)
      ..subject = "This is the email"
      ..text = "require blood "+blood;

    try {
      await send(message, smtpServer);
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
