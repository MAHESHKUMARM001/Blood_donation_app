import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressFromLatLng extends StatefulWidget {
  @override
  _AddressFromLatLngState createState() => _AddressFromLatLngState();
}

class _AddressFromLatLngState extends State<AddressFromLatLng> {
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  String _address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address from LatLng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _latitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Latitude'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _longitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Longitude'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getAddressFromLatLng();
              },
              child: Text('Get Address'),
            ),
            SizedBox(height: 20),
            Text(
              'Address: $_address',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  _getAddressFromLatLng() async {
    double latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    double longitude = double.tryParse(_longitudeController.text) ?? 0.0;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _address = "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
        });
      } else {
        setState(() {
          _address = 'No address found';
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
      setState(() {
        _address = 'Error fetching address';
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: AddressFromLatLng(),
  ));
}
