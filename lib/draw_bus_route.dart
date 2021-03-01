import 'dart:async';

import 'package:emddi_bus/map_to_show_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'geolocator_service.dart';

class DrawRoute extends StatefulWidget{

  final Position initialPosition;
  final String routeId;

  DrawRoute({Key key, this.initialPosition, this.routeId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DrawRouteState(text: routeId);

}

class _DrawRouteState extends State<DrawRoute>{

  final geoService = GeolocatorService();
  final String text;

  _DrawRouteState({this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Tuyến: '+text),
      ),
      body: FutureProvider(
        create: (context) => geoService.getInitialLocation(),
        child: Consumer<Position>(builder: (context, position, widget) {
          return (position != null) ? ShowRoute(initialPosition: position,) : Center(child: CircularProgressIndicator(),);
        },),
      ),
    );
  }
}