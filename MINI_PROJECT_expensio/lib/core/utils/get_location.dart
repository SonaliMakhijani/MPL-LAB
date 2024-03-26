import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '/domain/exceptions/app_exception.dart';

Future<LocationPermission> _getPermission() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    final permission = await Geolocator.requestPermission();
    return permission;
  } else {
    return permission;
  }
}

Future<Position> determinePosition() async {
  Position? position;
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(msg: "Please enable location service");
    Geolocator.openLocationSettings();
    position = await Geolocator.getLastKnownPosition();
  }

  permission = await _getPermission();

  if (permission != LocationPermission.denied &&
      permission != LocationPermission.deniedForever) {
    position = await Geolocator.getCurrentPosition();
  } else {
    throw LocationNotFound(
        title: 'Location permission is denied',
        message:
            'Your location service is disabled, try again after enabling location permission.');
  }

  return position;
}

Future<String> reverseGeocode(double latitude, double longitude) async {
  if (latitude == 0.0 && longitude == 0.0) {
    return 'N/A';
  }
  final String apiUrl =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('display_name')) {
        return data['display_name'];
      } else {
        throw LocationNotFound();
      }
    } else {
      throw AppException(message: '${response.statusCode}');
    }
  } catch (e) {
    throw AppException(message: e.toString());
  }
}
