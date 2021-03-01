import 'dart:async';

import 'package:emddi_bus/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'const_value.dart';
import 'info_user.dart';

class OSMap extends StatefulWidget {
  final Position initialPosition;

  OSMap({Key key, this.initialPosition}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OSMapState();
}

class _OSMapState extends State<OSMap> with SingleTickerProviderStateMixin {
  // Completer<GoogleMapController> _controller = Completer();

  bool isOpened = false;
  AnimationController _animationController;
  Animation degOneTranslationAnimation;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 48.0;

  Location location = new Location();
  LocationData currentLocation;

  var controller = MapController();

  @override
  void initState() {
    // _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    // degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: Colors.amber, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -20.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.1, curve: _curve)));
    // TODO: implement initState
    super.initState();
    // _animationController.addListener(() {
    //   setState(() {
    //
    //   });
    // });
    _getCurrentAddress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buttonSearch() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
        heroTag: "Search",
        child: Icon(Icons.directions_bus),
      ),
    );
  }
  Widget buttonUser() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InfoUser()));
        },
        heroTag: "User",
        child: Icon(Icons.person),
      ),
    );
  }

  Widget buttonHotline() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: _launchCaller,
        heroTag: "Hotline",
        child: Icon(Icons.phone),
      ),
    );
  }
  Widget buttonHelp() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed:(){},
        heroTag: "Help",
        child: Icon(Icons.help_outline),
      ),
    );
  }
  Widget buttonFeedback() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: (){},
        heroTag: "Feedback",
        child: Icon(Icons.feedback),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        // onPressed: (){
        //   if(_animationController.isCompleted)
        //     _animationController.reverse();
        //   else _animationController.forward();
        // },
        onPressed: animate,
        heroTag: "Toggle",
        // child: Icon(Icons.menu),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
      ),
    );
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  _launchCaller() async {
    const url = "tel:1800 8888";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getCurrentAddress() async {
    currentLocation = await location.getLocation();
  }

  double getRadiansFromDegree(double degree){
    double unitRadian = 57.295779513;
    return degree/unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //       target: LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude), zoom: 15), //20.986207, 105.7971309
      //   myLocationEnabled: true,
      //   myLocationButtonEnabled: false,
      //   zoomControlsEnabled: false,
      //   onMapCreated: (GoogleMapController controller) {
      //     setState(() {
      //       _controller.complete(controller);
      //     });
      //   },
      //   // padding: EdgeInsets.only(top: 150),
      // ),
      body: Container(
        child: Stack(children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              center: LatLng(widget.initialPosition.latitude,
                  widget.initialPosition.longitude),
              zoom: 16,
              maxZoom: 18,
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayerOptions(markers: [
                Marker(
                  point: LatLng(widget.initialPosition.latitude,
                      widget.initialPosition.longitude),
                  builder: (controller) => Icon(
                    Icons.location_on,
                  ),
                )
              ]),
            ],
          ),
          // Positioned(
          //     bottom: 20,
          //     left: 15,
          //     child: Container(
          //       child: Stack(
          //         alignment: Alignment.bottomLeft,
          //         children: [
          //           IgnorePointer(
          //             child: Container(
          //               color: Colors.black.withOpacity(
          //                   0.0), // comment or change to transparent color
          //               height: 150.0,
          //               width: 150.0,
          //             ),
          //           ),
          //           Transform.translate(
          //             offset: Offset.fromDirection(getRadiansFromDegree(270),
          //                 degOneTranslationAnimation.value * 120),
          //             child: buttonUser(),
          //           ),
          //           Transform.translate(
          //               offset: Offset.fromDirection(
          //                   getRadiansFromDegree(292.5),degOneTranslationAnimation.value * 120),
          //               child: buttonSearch()),
          //           Transform.translate(
          //               offset: Offset.fromDirection(getRadiansFromDegree(315),
          //                   degOneTranslationAnimation.value * 120),
          //               child: buttonFeedback()),
          //           Transform.translate(
          //               offset: Offset.fromDirection(getRadiansFromDegree(337.5),
          //                   degOneTranslationAnimation.value * 120),
          //               child: buttonHelp()),
          //           Transform.translate(
          //               offset: Offset.fromDirection(getRadiansFromDegree(360),
          //                   degOneTranslationAnimation.value * 120),
          //               child: buttonHotline()),
          //           buttonToggle(),
          //         ],
          //       ),
          //     ))
          Positioned(
            bottom: 20,
            left: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IgnorePointer(
                  child: Container(
                    color: Colors.black.withOpacity(
                        0.0), // comment or change to transparent color
                    height: 400,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, _translateButton.value * 5.0, 0.0),
                  child: buttonFeedback(),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, _translateButton.value * 4.0, 0.0),
                  child: buttonHelp(),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, _translateButton.value * 3.0, 0.0),
                  child: buttonHotline(),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, _translateButton.value * 2.0, 0.0),
                  child: buttonUser(),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, _translateButton.value, 0.0),
                  child: buttonSearch(),
                ),
                buttonToggle()
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
          onPressed: _centerScreen,
        ),
    );
  }

  Future<void> _centerScreen() async {
    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //     target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 15)));
    LatLng center = LatLng(currentLocation.latitude, currentLocation.longitude);
    controller.move(center, 18);
  }
}
class CircularButton extends StatelessWidget {
  final double width, height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton({this.width, this.height, this.color, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick,),
    );
  }
  
}
