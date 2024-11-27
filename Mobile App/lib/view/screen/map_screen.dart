import 'dart:async';

import 'package:diu_bus_tracking/controller/bus_status_controller.dart';
import 'package:diu_bus_tracking/controller/custom_icon_loader_controller.dart';
import 'package:diu_bus_tracking/controller/map_controller.dart';
import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:diu_bus_tracking/controller/person_identification_controller.dart';
import 'package:diu_bus_tracking/view/screen/auth/identity_verification_screen.dart';
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
  final identityController =
      Get.find<PersonIdentificationController>().isStudent;

  @override
  void initState() {
    super.initState();

    // Ensure icons are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<CustomIconLoaderController>().loadCustomIcons();
      await Get.find<MapController>().fetchLocation();
    });
  }

  Future<void> _moveToCurrentLocation() async {
    final mapController = Get.find<MapController>();
    if (mapController.isCurrentLocationFetched &&
        mapController.currentLocation != null) {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            mapController.currentLocation!.latitude!,
            mapController.currentLocation!.longitude!,
          ),
          zoom: 15,
        ),
      ));
    } else {
      Get.snackbar('Location Error', 'Unable to fetch current location');
    }
  }

  Future<void> _displayBusInfoSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: Get.find<PersonIdentificationController>().isStudent == true
              ? 300
              : 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section with Image and Bus Info
              Container(
                color: identityController
                    ? Colors.deepPurple.withOpacity(0.3)
                    : Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shurjomukhi - 10",
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Get.find<PersonIdentificationController>()
                                          .isStudent ==
                                      true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GetBuilder<BusStatusController>(
                              builder: (statusController) {
                            return Row(
                              children: [
                                Icon(
                                  statusController.isBusMoving
                                      ? Icons.directions_bus
                                      : Icons.stop_circle,
                                  color: statusController.isBusMoving
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  statusController.isBusMoving
                                      ? 'Moving'
                                      : 'Static',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    color:
                                        Get.find<PersonIdentificationController>()
                                                    .isStudent ==
                                                true
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(
                            20), // Match the bottom sheet radius
                      ),
                      child: Container(
                        width: 200,
                        height: 90, // Adjust height to look proportional
                        color: Colors.white, // Background to match the sheet
                        child: Image.asset(
                          AssetsPath.diuBus,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 20),

              // Location & Speed Info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<MqttController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.location_pin,
                              color: identityController
                                  ? Colors.deepPurple
                                  : Colors.black87),
                          Text(
                              "Lat: ${controller.latitude.toStringAsFixed(4)}"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.location_pin,
                              color: identityController
                                  ? Colors.deepPurple
                                  : Colors.black87),
                          Text(
                              "Lon: ${controller.longitude.toStringAsFixed(4)}"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.satellite,
                              color: identityController
                                  ? Colors.deepPurple
                                  : Colors.black87),
                          Text("Sat: ${controller.satelliteConnection}"),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.speed,
                              color: identityController
                                  ? Colors.deepPurple
                                  : Colors.black87),
                          Text("Speed: ${controller.speed} km/h"),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              const Divider(height: 20),

              // Departure & Destination
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dhanmondi - Dhaka",
                            style: GoogleFonts.outfit(fontSize: 16)),
                        Text("Departed: 7:00 am",
                            style: GoogleFonts.outfit(fontSize: 14)),
                      ],
                    ),
                    Image.asset(
                      AssetsPath.busSpeedIcon,
                      color: identityController
                          ? Colors.deepPurple
                          : Colors.black87,
                      width: 50,
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DSC - Khagan",
                            style: GoogleFonts.outfit(fontSize: 16)),
                        Text("Arrived: 7:50 am",
                            style: GoogleFonts.outfit(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Action Buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<BusStatusController>(
                    builder: (busStatusController) {
                  return Get.find<PersonIdentificationController>().isStudent ==
                          false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (busStatusController.isBusMoving) {
                                  mqttController.sendMessageToTopic(
                                      'gps/61179', '0');
                                } else {
                                  mqttController.sendMessageToTopic(
                                      'gps/61179', '1');
                                }
                                busStatusController
                                    .changeBusStatus(); // Trigger update
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: busStatusController.isBusMoving
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              child: Text(
                                busStatusController.isBusMoving
                                    ? 'Stop Bus'
                                    : 'Start Bus',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.snackbar(
                                    "Bus Schedule", "Showing bus schedule...");
                              },
                              child: const Text("View Schedule"),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.snackbar(
                                    "Bus Schedule", "Showing bus schedule...");
                              },
                              child: Text(
                                "View Schedule",
                                style: TextStyle(
                                    color: identityController
                                        ? Colors.deepPurple
                                        : Colors.black87),
                              ),
                            ),
                          ],
                        );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Bus',
            style: GoogleFonts.outfit(color: Colors.white)),
        backgroundColor: identityController
            ? Colors.deepPurple.withOpacity(0.8)
            : Colors.black87,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Get.offAll(() => const IdentityVerificationScreen()),
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await Get.find<MapController>().fetchLocation(),
        child: Stack(
          children: [
            // Render map only when assets are loaded
            GetBuilder<CustomIconLoaderController>(
              builder: (customIconLoaderController) {
                if (!customIconLoaderController.areAssetsLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GetBuilder<MapController>(builder: (mapController) {
                  if (!mapController.isCurrentLocationFetched ||
                      mapController.currentLocation == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GetBuilder<MqttController>(builder: (mqttController) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          mapController.currentLocation!.latitude!,
                          mapController.currentLocation!.longitude!,
                        ),
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId("Current Position"),
                          position: LatLng(
                            mapController.currentLocation!.latitude!,
                            mapController.currentLocation!.longitude!,
                          ),
                          icon: customIconLoaderController.customMarkerIcon,
                          infoWindow:
                              const InfoWindow(title: "Current Location"),
                        ),
                        Marker(
                          markerId: const MarkerId("Bus"),
                          position: LatLng(mqttController.latitude,
                              mqttController.longitude),
                          icon: customIconLoaderController.customBusIcon,
                          onTap: () => _displayBusInfoSheet(context),
                        ),
                        Marker(
                          markerId: const MarkerId("Destination"),
                          position: mapController.destination,
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow:
                              const InfoWindow(title: "Daffodil Smart City"),
                        ),
                      },
                    );
                  });
                });
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _moveToCurrentLocation,
                backgroundColor: identityController
                    ? Colors.deepPurple.withOpacity(0.8)
                    : Colors.black87,
                child: const Icon(Icons.my_location, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
