import 'package:diu_bus_tracking/controller/bus_status_controller.dart';
import 'package:diu_bus_tracking/controller/custom_icon_loader_controller.dart';
import 'package:diu_bus_tracking/controller/map_controller.dart';
import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:diu_bus_tracking/controller/person_identification_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MqttController());
    Get.put(MapController());
    Get.put(PersonIdentificationController());
    Get.put(BusStatusController());
    Get.put(CustomIconLoaderController());
  }
}
