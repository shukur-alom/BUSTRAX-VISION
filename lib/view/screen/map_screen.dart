import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _destination = LatLng(23.888825, 90.322219);
  static const LatLng _dhanmondiBus =
      LatLng(23.755140315302626, 90.3765273962015);
  LatLng? _currentP;
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAP'),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body: _currentP == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: const CameraPosition(
                zoom: 14,
                target: _destination,
              ),
              markers: {
                Marker(
                    markerId: const MarkerId('currentPosition'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentP!),
                const Marker(
                    markerId: MarkerId('destination'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _destination),
                const Marker(
                    markerId: MarkerId('Dhanmondi Bus'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _dhanmondiBus),
              },
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition =
        CameraPosition(target: position, zoom: 18);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionStatus;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionStatus = await _locationController.hasPermission();

    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _locationController.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}
