import 'dart:async';

import 'package:diu_bus_tracking/controller/map_controller.dart';
import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:diu_bus_tracking/view/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final mqttController = Get.find<MqttController>();
  late BitmapDescriptor customMarkerIcon;

  @override
  void initState() {
    super.initState();
    loadCustomMarkerIcon();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MapController>().fetchLocation();
    });
  }

  Future<void> loadCustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsPath.currentLocation,
    );
  }

  Future<void> _moveToCurrentLocation() async {
    final mapController = Get.find<MapController>();
    // Check if location is fetched
    if (mapController.isCurrentLocationFetched &&
        mapController.currentLocation != null) {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            mapController.currentLocation!.latitude!,
            mapController.currentLocation!.longitude!,
          ),
          zoom: 12, // Adjust zoom level as needed
        ),
      ));
    } else {
      Get.snackbar('Location Error', 'Unable to fetch current location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Your Bus',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GetBuilder<MapController>(builder: (controller) {
            // If the location is not fetched yet, show a loading indicator
            if (!controller.isCurrentLocationFetched ||
                controller.currentLocation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // Location data is available; show the map
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  controller.currentLocation!.latitude!,
                  controller.currentLocation!.longitude!,
                ),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              markers: {
                // Marker for MQTT location
                Marker(
                  markerId: const MarkerId("MQTT Position"),
                  position: LatLng(
                    mqttController.latitude,
                    mqttController.longitude,
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                ),
                // Marker for current location
                Marker(
                  markerId: const MarkerId("Current Position"),
                  position: LatLng(
                    controller.currentLocation!.latitude!,
                    controller.currentLocation!.longitude!,
                  ),
                  icon: customMarkerIcon,
                  infoWindow: const InfoWindow(
                    title: "Current Location",
                  ),
                ),
              },
            );
          }),

          // Floating action button at the top-right corner
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _moveToCurrentLocation,
              backgroundColor: Colors.deepPurple,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
