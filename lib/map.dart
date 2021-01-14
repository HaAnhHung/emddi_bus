import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget{

  final Position initialPosition;

  Map({Key key, this.initialPosition}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MapState();

}

class _MapState extends State<Map>{

  Completer<GoogleMapController> _controller = Completer();

  Location location = new Location();
  LocationData currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentAddress();
  }

  _getCurrentAddress() async {
    currentLocation = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude), zoom: 15), //20.986207, 105.7971309
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller.complete(controller);
          });
        },
        // padding: EdgeInsets.only(top: 150),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.my_location, color: Colors.black,),
        onPressed: _centerScreen,
      ),
    );
  }

  Future<void> _centerScreen() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 15)));
  }
}