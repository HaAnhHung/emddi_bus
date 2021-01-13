import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget{

  final Position initialPosition;

  Map({Key key, this.initialPosition}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MapState();

}

class _MapState extends State<Map>{

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleMap(
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
    );
  }
}