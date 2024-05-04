// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class MyHomePage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//
//   void _sendWhatsAppMessage(BuildContext context) async {
//     String phoneNumber = _phoneNumberController.text;
//     String message = _messageController.text;
//
//     // Format the WhatsApp URL with the phone number and message
//     String uri = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
//
//     try {
//       await launch(uri);
//     } catch (e) {
//       // Handle error, for example, show an error dialog.
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Could not open WhatsApp.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send WhatsApp Message'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: 'WhatsApp Phone Number'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(labelText: 'Message'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _sendWhatsAppMessage(context),
//               child: Text('Send WhatsApp Message'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
