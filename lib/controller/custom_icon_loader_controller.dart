import 'package:diu_bus_tracking/view/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomIconLoaderController extends GetxController {
  bool _areAssetsLoaded = false;
  bool get areAssetsLoaded => _areAssetsLoaded;
  late BitmapDescriptor _customMarkerIcon;
  late BitmapDescriptor _customBusIcon;

  BitmapDescriptor get customMarkerIcon => _customMarkerIcon;
  BitmapDescriptor get customBusIcon => _customBusIcon;

  Future<void> loadCustomIcons() async {
    // Load custom icons asynchronously
    _customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(45, 45)),
      AssetsPath.currentLocation,
    );

    _customBusIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(45, 45)),
      AssetsPath.busIcon,
    );
    _areAssetsLoaded = true;
    update();
    // Update the UI after icons are loaded
  }
}
