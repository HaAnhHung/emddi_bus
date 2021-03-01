import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'geolocator_service.dart';

class ShowRoute extends StatefulWidget{

  final Position initialPosition;

  ShowRoute({Key key, this.initialPosition}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ShowRouteState();

}

class _ShowRouteState extends State<ShowRoute>{

  // Completer<GoogleMapController> _controller = Completer();

  final String text;
  _ShowRouteState({this.text});

  Location location = new Location();
  LocationData currentLocation;

  final geoService = GeolocatorService();

  var listPoints = <LatLng>[
    LatLng(20.98717,105.79730),
    LatLng(20.98914,105.80009),
    LatLng(20.98920,105.80026),
    LatLng(20.99090,105.80266),
    LatLng(20.99084,105.80348),
    LatLng(20.989491284692786, 105.80443937488687),
    LatLng(20.989489406517237, 105.80444205709603),
    LatLng(20.989344762337577, 105.80455703871401),
    LatLng(20.989491284692786, 105.80443937488687),
    LatLng(20.98418005054364, 105.80845110921884),
    LatLng(20.983227452826046, 105.80911565111698),
    LatLng(20.982250527495193, 105.80988052241356),
    LatLng(20.97980808615658, 105.81163874344695),
    LatLng(20.977999725420766, 105.8116761792586),
    LatLng(20.969996991592453, 105.8065614675472),
    LatLng(20.969377327063523, 105.80608823662686),
  ];

  var controller = MapController();

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
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          center: LatLng(20.98717,105.79730),
          zoom: 16,
          maxZoom: 18,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayerOptions(
              markers: [
                Marker(
                  point: LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude),
                  builder: (controller) => Icon(Icons.location_on,),
                )
              ]
          ),
          PolylineLayerOptions(
              polylines: [
                Polyline(
                  strokeWidth: 2,
                  points: listPoints,
                )
              ]
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.my_location, color: Colors.black,),
        onPressed: _centerScreen,
      ),
    );
  }

  Future<void> _centerScreen() async {
    LatLng center = LatLng(currentLocation.latitude, currentLocation.longitude);
    controller.move(center, 18);
  }
}