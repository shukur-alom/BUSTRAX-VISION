import 'dart:async';

import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final mqttController = Get.find<MqttController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAP'),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(23.876456, 90.321839), zoom: 13),
        markers: {
          Marker(
              markerId: const MarkerId("Initial position"),
              position:
                  LatLng(mqttController.latitude, mqttController.longitude),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {})
        },
      ),
    );
  }
}
