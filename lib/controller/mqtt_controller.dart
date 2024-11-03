import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../model/mqtt_model.dart';

class MqttController extends GetxController {
  final MqttModel mqttModel = MqttModel();
  late MqttServerClient client;
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectToMqtt();
  }

  Future<void> connectToMqtt() async {
    client = MqttServerClient('broker.hivemq.com', 'flutter_client');
    client.port = 1883;
    client.keepAlivePeriod = 20; // Keep the connection alive
    client.autoReconnect = true; // Enable auto-reconnect
    client.logging(on: false);
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      print('Trying to connect...');
      await client.connect();
    } on NoConnectionException catch (e) {
      print('MQTT Client exception: $e');
      reconnect();
    } on SocketException catch (e) {
      print('MQTT Socket exception: $e');
      reconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('Connected to broker');
      isConnected.value = true;

      const topic = 'test/10';
      const payload = '23.44,22.444,14,250';

      // Convert the payload to a Uint8List
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);

      // Publish the message to the specified topic
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      print('Published message: $payload to topic: $topic');

      subscribeToTopic('test/611');
    } else {
      print('Connection failed');
      reconnect();
    }
  }

  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
      final String payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      mqttModel.message.value = payload;
      print('Received message: $payload');
      // Split the payload by comma
      final data = payload.split(',');

      if (data.length >= 4) {
        // Parse each value from the payload
        final latitude = double.tryParse(data[0]) ?? 0.0;
        final longitude = double.tryParse(data[1]) ?? 0.0;
        final satelliteConnection = int.tryParse(data[2]) ?? 0;
        final speed = double.tryParse(data[3]) ?? 0.0;

        print('Latitude: $latitude');
        print('Longitude: $longitude');
        print('Satellite Connection: $satelliteConnection');
        print('Speed: $speed');
      } else {
        print('Received data does not match expected format');
      }
    });
  }

  void reconnect() {
    // Attempt reconnection after a delay if not connected
    if (!isConnected.value) {
      Future.delayed(Duration(seconds: 5), () {
        print('Attempting to reconnect...');
        connectToMqtt();
      });
    }
  }

  void onConnected() {
    print('Connected to the broker');
    isConnected.value = true;
  }

  void onDisconnected() {
    print('Disconnected from the broker');
    isConnected.value = false;
    reconnect(); // Attempt to reconnect when disconnected
  }

  void onSubscribed(String topic) => print('Subscribed to topic: $topic');
  void pong() => print('Ping response received');

  void disconnectFromMqtt() {
    if (isConnected.value) {
      client.disconnect();
      isConnected.value = false;
      print('Manually disconnected from broker');
    }
  }
}
