// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }
//
// class _MyFormState extends State<MyForm> {
//   TextEditingController locationController = TextEditingController();
//   String currentLocation = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: locationController,
//                 decoration: InputDecoration(labelText: 'Location'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _getUserLocation();
//                 },
//                 child: Text('Get Location'),
//               ),
//               SizedBox(height: 20),
//               Text('Current Location: $currentLocation'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getUserLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       // Access position.latitude and position.longitude
//       double latitude = position.latitude;
//       double longitude = position.longitude;
//
//       setState(() {
//         currentLocation = 'Latitude: $latitude, Longitude: $longitude';
//         locationController.text = currentLocation;
//       });
//     } catch (e) {
//       // Handle errors
//       print("Error getting location: $e");
//     }
//   }
// }
