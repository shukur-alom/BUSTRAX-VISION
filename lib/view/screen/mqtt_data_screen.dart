import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MqttDataScreen extends StatefulWidget {
  const MqttDataScreen({super.key});

  @override
  State<MqttDataScreen> createState() => _MqttDataScreenState();
}

class _MqttDataScreenState extends State<MqttDataScreen> {
  final MqttController mqttController = Get.find<MqttController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Received Message: ${mqttController.mqttModel.message.value}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => mqttController.isConnected.value
                  ? ElevatedButton(
                      onPressed: mqttController.disconnectFromMqtt,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Disconnect'),
                    )
                  : ElevatedButton(
                      onPressed: mqttController.connectToMqtt,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text('Connect'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
