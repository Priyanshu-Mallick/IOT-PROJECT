import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const LatLng _GooglePlx = LatLng(20.2961, 85.8245);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey ,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _GooglePlx,
              zoom: 13
            ),
          ),
          Positioned(
            bottom: 0,
            child:  Container(
                height: 100,
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45)
                  ),
                  // border: BoxBorder,
                  color: Colors.white,
                ),
              ),
          )
        ],
      ),
    );
  }
}
