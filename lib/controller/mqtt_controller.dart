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

  // Flag to track if the client has connected at least once
  bool hasConnectedOnce = false;

  // Reconnect attempt counter
  int reconnectAttempts = 0;
  final int maxReconnectAttempts = 3; // Max number of reconnection attempts

  // Define Rx variables for latitude, longitude, satelliteConnection, and speed
  final RxDouble _latitude = 23.876835.obs;
  final RxDouble _longitude = 90.320223.obs;
  final RxInt _satelliteConnection = 1.obs;
  final RxDouble _speed = 0.0.obs;

  // Getters to expose these variables
  double get latitude => _latitude.value;
  double get longitude => _longitude.value;
  int get satelliteConnection => _satelliteConnection.value;
  double get speed => _speed.value;

  Future<void> connectToMqtt() async {
    if (hasConnectedOnce) {
      // If already connected, skip the connection logic
      print('Already connected, skipping connection attempt.');
      return;
    }

    client = MqttServerClient('broker.emqx.io', 'flutter_mqtt_client');
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.autoReconnect = false; // Disable auto-reconnect
    client.logging(on: false);
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    client.setProtocolV311();

    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier("flutter_mqtt_client")
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('Client disconnected unexpectedly')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

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
      hasConnectedOnce = true; // Set the flag after a successful connection

      // Subscribe to topic after connection is established
      subscribeToTopic('gps/53384');
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

      // Automatically process received data and update Rx variables
      processReceivedData(payload);
    });
  }

  /// Method to process received data and update Rx variables
  void processReceivedData(String payload) {
    final data = payload.split(',');

    if (data.length >= 4) {
      // Update the Rx variables when data is received
      _latitude.value = double.tryParse(data[0]) ?? 0.0;
      _longitude.value = double.tryParse(data[1]) ?? 0.0;
      _satelliteConnection.value = int.tryParse(data[2]) ?? 0;
      _speed.value = double.tryParse(data[3]) ?? 0.0;

      print('Latitude: $latitude');
      print('Longitude: $longitude');
      print('Satellite Connection: $satelliteConnection');
      print('Speed: $speed');
    } else {
      print('Received data does not match expected format');
    }

    // Trigger GetX update to notify listeners
    update();
  }

  void reconnect() {
    if (reconnectAttempts < maxReconnectAttempts) {
      reconnectAttempts++;
      Future.delayed(Duration(seconds: 5), () {
        print(
            'Attempting to reconnect ($reconnectAttempts/$maxReconnectAttempts)...');
        connectToMqtt();
      });
    } else {
      print('Max reconnect attempts reached. Stopping further attempts.');
    }
  }

  void onConnected() {
    print('Connected to the broker');
    isConnected.value = true;
  }

  void onDisconnected() {
    print('Disconnected from the broker');
    isConnected.value = false;
    if (!hasConnectedOnce) {
      reconnect(); // Only reconnect if it has not connected successfully before
    }
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

  void sendMessageToTopic(String topic, String payload) {
    // Ensure the client is connected before publishing
    if (isConnected.value) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);

      // Publish the message to the specified topic
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      print('Published message: $payload to topic: $topic');
    } else {
      print('Cannot publish, MQTT client is not connected.');
    }
  }
}
