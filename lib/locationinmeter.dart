import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';



class LiveLocationTracker extends StatefulWidget {
  @override
  _LiveLocationTrackerState createState() => _LiveLocationTrackerState();
}

class _LiveLocationTrackerState extends State<LiveLocationTracker> {
  late LocationData _currentLocation;
  late Location _locationService;
  late double _distanceToDestination;

  final double destinationLatitude = 9.4825895; // Replace with your destination coordinates
  final double destinationLongitude = 77.5143518;

  @override
  void initState() {
    super.initState();
    _locationService = Location();
    _currentLocation = LocationData.fromMap({
      "latitude": 0.0,
      "longitude": 0.0,
    });
    _distanceToDestination = 0.0;

    _startLocationTracking();
  }

  _startLocationTracking() async {
    var hasPermission = await _locationService.requestPermission();
    if (hasPermission != PermissionStatus.granted) {
      // Handle case when location permission is not granted
      return;
    }

    _locationService.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
        _calculateDistance();
      });
    });
  }

  _calculateDistance() {
    double distance = Geolocator.distanceBetween(
      _currentLocation.latitude!,
      _currentLocation.longitude!,
      destinationLatitude,
      destinationLongitude,
    );

    setState(() {
      _distanceToDestination = distance;
    });
  }

  _onAcceptButtonPressed() {
    // You can perform any action here when the "Accept" button is pressed.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Accepted'),
          content: Text('Do something with the accepted location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_currentLocation.latitude}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Longitude: ${_currentLocation.longitude}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Distance to Destination: $_distanceToDestination meters',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onAcceptButtonPressed,
              child: Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
