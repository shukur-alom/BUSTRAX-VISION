import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  final LatLng _destination = const LatLng(23.888825, 90.322219);
  LatLng get destination => _destination;
  late final LocationData? _currentLocation;
  LocationData? get currentLocation => _currentLocation;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      _currentLocation = location;
    });
  }
}
