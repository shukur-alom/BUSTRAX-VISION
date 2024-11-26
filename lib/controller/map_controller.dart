import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  bool _isCurrentLocationFetched = false;
  final LatLng _destination = const LatLng(23.888825, 90.322219);
  LatLng get destination => _destination;

  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _currentLocation;
  LocationData? get currentLocation => _currentLocation;
  bool get isCurrentLocationFetched => _isCurrentLocationFetched;

  Future<LocationData?> getCurrentLocation() async {
    try {
      final locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<void> fetchLocation() async {
    bool permissionGranted = await requestPermission();
    if (permissionGranted) {
      LocationData? locationData = await getCurrentLocation();
      if (locationData != null) {
        _currentLocation = locationData;
        _isCurrentLocationFetched = true;
        update(); // Update the UI after fetching the location
      }
    }
  }

  Future<bool> requestPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("Location services are disabled.");
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("Location permission denied.");
        return false;
      }
    }
    return true;
  }
}
