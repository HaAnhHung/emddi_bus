import 'dart:async';

import 'package:emddi_bus/address_from.dart';
import 'package:emddi_bus/address_to.dart';
import 'package:emddi_bus/history_search_way.dart';
import 'package:emddi_bus/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'geolocator_service.dart';
import 'menu.dart';

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabState();
}

class _TabState extends State<Tabs> {

  Completer<GoogleMapController> controller = Completer();
  final geoService = GeolocatorService();
  // Location location = new Location();
  // LocationData currentLocation;

  bool _isVisibleSearchLocation = true;
  bool _isVisibleSearchWay = false;

  String addressFrom = "Điểm bắt đầu";
  String addressTo = "Điểm kết thúc";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getCurrentAddress();
  // }
  //
  // _getCurrentAddress() async {
  //   currentLocation = await location.getLocation();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        iconTheme: IconThemeData(color: Colors.black),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "EMDDIBUS",
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
        bottom: TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabs: [
            Tab(
              child: Row(
                children: [
                  Icon(
                    Icons.directions_bus,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text("Theo dõi xe"))
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  Icon(Icons.search),
                  Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text("Tìm đường"))
                ],
              ),
            ),
          ],
          onTap: (int i) {
            setState(() {
              if (i == 0) {
                _isVisibleSearchLocation = true;
                _isVisibleSearchWay = false;
              } else if (i == 1) {
                _isVisibleSearchLocation = false;
                _isVisibleSearchWay = true;
              }
            });
          },
        ),
      ),
      body: Stack(
        children: [
          //google map
          FutureProvider(
            create: (context) => geoService.getInitialLocation(),
              child: Consumer<Position>(builder: (context, position, widget) {
                return (position != null) ? Map(initialPosition: position,) : Center(child: CircularProgressIndicator(),);
              },),
          ),
          //search location
          Visibility(
            visible: _isVisibleSearchLocation,
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 10, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300],
                  width: 0.5,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm điểm dừng",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, top: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                  suffixIcon: Icon(
                    Icons.cancel,
                    size: 20,
                    color: Colors.grey[400],
                  )
                ),
              ),
            ),
          ),
          //search for the way
          Visibility(
            visible: _isVisibleSearchWay,
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 10, right: 15),
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey[300]),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      //choose start and finish location
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 8),
                          child: Column(
                            children: [
                              //choose address start
                              GestureDetector(
                                onTap: ()async{
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddressFrom()),
                                  );
                                  setState(() {
                                    if (result != null){
                                      addressFrom = result;
                                    }
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          addressFrom,
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                indent: 30,
                              ),
                              //choose address where you wanna go
                              GestureDetector(
                                onTap: ()async{
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddressTo()),
                                  );
                                  setState(() {
                                    if (result != null)
                                      addressTo = result;
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                        size: 25,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          addressTo,
                                          style: TextStyle(
                                            fontSize: 16
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //swap between start and finish location
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.swap_vert,
                            color: Colors.amber,
                          ),
                          iconSize: 35,
                        ),
                      )
                    ],
                  ),
                  //history of searching for the way
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(8),
                    color: Colors.amber[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistorySearch(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.grey,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text("Lịch sử tìm đường")),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "TÌM ĐƯỜNG",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.amber,
      //   child: Icon(Icons.my_location, color: Colors.black,),
      //   onPressed: _centerScreen,
      // ),
    );
  }
  // Future<void> _centerScreen() async {
  //   final GoogleMapController _controller = await controller.future;
  //   _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 15)));
  // }
}
