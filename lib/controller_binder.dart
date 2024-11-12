import 'package:diu_bus_tracking/controller/map_controller.dart';
import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MqttController());
    Get.put(MapController());
  }
}
