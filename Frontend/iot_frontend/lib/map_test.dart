import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MapTest extends StatefulWidget {
  const MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex; // Make it nullable
  final List<Marker> _markers = <Marker>[];
  bool _isLoading = true; // Indicator for initial loading

  // final String apiEndpoint = '${Config.fetchDisriLocUrl}';

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getUserCurrentLocation();

    await _fetchAndSetMarkers();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));

    // Set isLoading to false to hide the CircularProgressIndicator
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      print("error" + error.toString());
    });

    Position currentPosition = await Geolocator.getCurrentPosition();

    _kGooglePlex = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 16,
    );

    // Add marker for current location (blue color)
    _markers.add(
      Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: InfoWindow(
          title: 'Your Location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  Future<void> _fetchAndSetMarkers() async {
    try {
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex ?? CameraPosition(target: LatLng(0, 0), zoom: 1),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}