// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// const String googleApiKey = "AIzaSyDPVnhUNq4W_9_fe_BjUrPyMUuvBS2RErU"; // Replace with your actual API key
// const Color primaryColor = Color(0xFF7B61FF);
// const double defaultPadding = 16.0;
//
//
//
// class OrderTrackingPage extends StatefulWidget {
//   const OrderTrackingPage({Key? key}) : super(key: key);
//
//   @override
//   State<OrderTrackingPage> createState() => OrderTrackingPageState();
// }
//
// class OrderTrackingPageState extends State<OrderTrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   static const LatLng destination = LatLng(37.33429383, -122.06600055);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Track order",
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(
//           target: sourceLocation,
//           zoom: 14.0,
//         ),
//         markers: {
//           Marker(markerId: MarkerId('source'), position: sourceLocation),
//           Marker(markerId: MarkerId('destination'), position: destination),
//         },
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }