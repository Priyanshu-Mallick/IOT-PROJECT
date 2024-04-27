import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class DeviceData {
  final String deviceId; // Change type to String
  final double latitude;
  final double longitude;
  final double decisionValue;

  DeviceData({
    required this.deviceId,
    required this.latitude,
    required this.longitude,
    required this.decisionValue,
  });
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  List<DeviceData> deviceDataList = [];

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    final channel = IOWebSocketChannel.connect('ws://192.168.2.72:3000');
    channel.stream.listen((message) {
      print('Received message: $message');
      try {
        final List<dynamic> parsedDataList = jsonDecode(message);
        print('Parsed data: $parsedDataList');
        setState(() {
          // Clear existing device data list
          deviceDataList.clear();

          // Iterate over each device data object in the parsed list
          parsedDataList.forEach((parsedData) {
            deviceDataList.add(DeviceData(
              deviceId: parsedData['deviceId'], // Direct assignment, no need for toString()
              latitude: parsedData['location'][0].toDouble(),
              longitude: parsedData['location'][1].toDouble(),
              decisionValue: parsedData['decision_value'].toDouble(),
            ));
          });

        });
      } catch (e) {
        print('Error parsing message: $e');
      }
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Data'),
      ),
      body: ListView.builder(
        itemCount: deviceDataList.length,
        itemBuilder: (context, index) {
          final deviceData = deviceDataList[index];
          return Card(
            child: ListTile(
              title: Text('Device ID: ${deviceData.deviceId}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Latitude: ${deviceData.latitude.toStringAsFixed(2)}'),
                  Text('Longitude: ${deviceData.longitude.toStringAsFixed(2)}'),
                  Text(
                      'Decision Value: ${deviceData.decisionValue.toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
