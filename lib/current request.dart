// import 'package:flutter/material.dart';
// // import 'request_details_page.dart';
// import 'detail currentrequest.dart';
// // Model class to represent a request
// class Request {
//   final String patientName;
//   final String hospitalName;
//   final String location;
//   final String bloodGroup;
//   final String contactNumber; // New field
//
//   Request({
//     required this.patientName,
//     required this.hospitalName,
//     required this.location,
//     required this.bloodGroup,
//     required this.contactNumber,
//   });
// }
//
//
// class currentrequest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Current Requests',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   // Sample list of requests
//   final List<Request> requests = [
//     Request(patientName: "John Doe", hospitalName: "City Hospital", location: "New York", bloodGroup: "O+", contactNumber: "1234567890"),
//     Request(patientName: "Jane Smith", hospitalName: "Community Hospital", location: "Los Angeles", bloodGroup: "AB-", contactNumber: "9876543210"),
//     Request(patientName: "Michael Johnson", hospitalName: "General Hospital", location: "Chicago", bloodGroup: "A+", contactNumber: "4567890123"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Current Requests'),
//       ),
//       body: ListView.builder(
//         itemCount: requests.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               title: Text(
//                 requests[index].patientName,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Hospital: ${requests[index].hospitalName}"),
//                   Text("Location: ${requests[index].location}"),
//                   Text("Blood Group: ${requests[index].bloodGroup}"),
//                 ],
//               ),
//               trailing: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.lightGreenAccent, Colors.green],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.transparent,
//                     elevation: 0,
//                     padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onPressed: () {
//                     // Navigate to request details page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RequestDetailsPage(
//                           Name: requests[index].patientName,
//                           hospitalName: requests[index].hospitalName,
//                           location: requests[index].location,
//                           bloodGroup: requests[index].bloodGroup,
//                           dateTimeSubmitted: DateTime.now().toString(), // You can pass the current date and time here
//                           contactNumber: requests[index].contactNumber,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'More Details',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
