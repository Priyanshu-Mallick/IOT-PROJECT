import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double latitude = 0.0;
  double longitude = 0.0;
  double decisionValue = 0.0;

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    final channel = IOWebSocketChannel.connect('ws://192.168.148.238:3000');
    channel.stream.listen((message) {
      print('Received message: $message');
      try {
        final parsedData = jsonDecode(message);
        print('Parsed data: $parsedData');
        setState(() {
          latitude = parsedData['location'][0].toDouble();
          longitude = parsedData['location'][1].toDouble();
          decisionValue = parsedData['decision_value'].toDouble();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latitude: ${latitude.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'Longitude: ${longitude.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'Decision Value: ${decisionValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
