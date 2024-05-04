import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class DonationRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Request'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate donor acceptance
            handleDonorAcceptance(context);
          },
          child: Text('Accept Donation Request'),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launch(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void handleDonorAcceptance(BuildContext context) {
    // Replace these coordinates with actual donor and destination coordinates
    double donorLat = 9.4826643;
    double donorLng = 77.520111;
    double destinationLat = 9.4825895;
    double destinationLng = 77.5143518;

    // Construct the Google Maps URL directly in the function
    String mapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=$donorLat,$donorLng&destination=$destinationLat,$destinationLng&travelmode=driving';

    // Open Google Maps
    _launchUrl(mapsUrl);
  }
}
