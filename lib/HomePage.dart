import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:mahesh651/Location.dart';
// import 'package:mahesh651/RequestPage.dart';
import 'Home001.dart';
import 'LoginPage.dart';
import 'Request.dart';
import 'call.dart';
import 'comedetail.dart';
import 'comerequests.dart';
import 'current request.dart';
import 'emailcheckbox.dart';
import 'location to address.dart';
import 'locationinmeter.dart';
import 'locationmap.dart';
import 'requsethistory.dart';
import 'slider.dart';


// import 'Message.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String userEmail;

  HomePage(this.userId, this.userEmail);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Successful'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80.0,
            ),
            SizedBox(height: 16.0),
            Text(
              "Registration Successful!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Thank you for registering with us. Your account has been successfully created.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add navigation logic if needed
              },
              child: Text("Continue"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Logout"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiveLocationTracker()),
                );
              },
              child: Text("Location"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calltheapp()),
                );
              },
              child: Text("Call"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationRequestScreen()),
                );
              },
              child: Text("locationmap"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailList()),
                );
              },
              child: Text("Checked emails"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressFromLatLng()),
                );
              },
              child: Text("Location to Address"),
            ),
            ElevatedButton(
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubmitFormPage(widget.userId,widget.userEmail)),
                );
              },
              child: Text("Request"),
            ),
            ElevatedButton(
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Comerequest(
                      widget.userId,widget.userEmail)),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => currentrequest()),
                // );
              },
              child: Text("accept"),
            ),
            ElevatedButton(
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyForm()),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => currentrequest()),
                // );
              },
              child: Text("design request"),
            ),
            ElevatedButton(
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestHistory(widget.userId,widget.userEmail)),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => currentrequest()),
                // );
              },
              child: Text("requesthistory"),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MyHomePage()),
            //     );
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => currentrequest()),
            //     // );
            //   },
            //   child: Text("Home Design"),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => Comerequest(widget.userId,widget.userEmail)),
            //     // );
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MyHomePage()),
            //     );
            //   },
            //   child: Text("Home"),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     // Call the sending_SMS function with the desired message and recipients
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => MyHomePage()),
            //     );
            //     },
            //   child: Text("message"),
            // ),


            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => MyForm()),
            //     );
            //   },
            //   child: Text("Request"),
            // ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => OrderTrackingPage()),
            //     );
            //   },
            //   child: Text("Request"),
            // ),
          ],
        ),
      ),
    );
  }
}
