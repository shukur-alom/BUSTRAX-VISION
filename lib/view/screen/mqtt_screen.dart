import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MqttScreen extends StatefulWidget {
  const MqttScreen({super.key});

  @override
  State<MqttScreen> createState() => _MqttScreenState();
}

class _MqttScreenState extends State<MqttScreen> {
  final mqttController = Get.find<MqttController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("Latitude: ${mqttController.latitude}")),
            Obx(() => Text("Longitude: ${mqttController.longitude}")),
            Obx(() => Text(
                "Satellite Connection: ${mqttController.satelliteConnection}")),
            Obx(() => Text("Speed: ${mqttController.speed}")),
            ElevatedButton(
                onPressed: () {
                  mqttController.sendMessageToTopic('test/10', '1');
                },
                child: const Text("Tap"))
          ],
        ),
      ),
    );
  }
}
