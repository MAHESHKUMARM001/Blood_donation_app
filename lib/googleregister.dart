import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'Home001.dart';
import 'home0012.dart';
// import 'HomePage.dart';

class GoogleRegistrationPage extends StatefulWidget {
  final String userId;
  final String userEmail;

  GoogleRegistrationPage(this.userId, this.userEmail);

  @override
  _GoogleRegistrationPageState createState() => _GoogleRegistrationPageState();
}

class _GoogleRegistrationPageState extends State<GoogleRegistrationPage> {
  final TextEditingController mobileController = TextEditingController();
  String location = "";

  List<String> bloodGroups = ["A", "B", "AB", "O", "Other"];
  String selectedBloodGroup = "A";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Registration Page'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBloodGroup = newValue!;
                        });
                      },
                      items: bloodGroups.map((String bloodGroup) {
                        return DropdownMenuItem<String>(
                          value: bloodGroup,
                          child: Text(bloodGroup),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Blood Group',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(labelText: 'Mobile Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: TextEditingController(text: location),
                            decoration: InputDecoration(labelText: 'Location'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your location';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: () async {
                            String currentLocation = await getCurrentLocation();
                            setState(() {
                              location = currentLocation;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final userDoc = _firestore.collection('users').doc(widget.userId);

                          // Check if the document exists
                          final userDocSnapshot = await userDoc.get();
                          if (userDocSnapshot.exists) {
                            // If the document exists, update its data
                            await userDoc.update({
                              'bloodGroup': selectedBloodGroup,
                              'mobile': mobileController.text,
                              'location': location,
                            });
                          }
                          // Add navigation logic to your desired home page or any other page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage001(widget.userId,widget.userEmail)),
                          );
                        }
                      },
                      child: Text('Submit'),
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
}
