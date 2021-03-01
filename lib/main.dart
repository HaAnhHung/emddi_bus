

import 'dart:convert';

import 'package:emddi_bus/data_api_route.dart';
import 'package:emddi_bus/login.dart';
import 'package:emddi_bus/route.dart';
import 'package:emddi_bus/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'const_value.dart';
import 'package:http/http.dart' as http;

import 'data_bus_stop.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  user = await auth.currentUser();
  if (user != null) {
    PHONE = user.phoneNumber;
  }
  runApp(MyApp());
  getListRoute();
  getListBusStop();
}

getListBusStop()async{
  final data = await rootBundle.loadString('json/api_busstop.json');
  DataBusStop dataBusStop = DataBusStop.fromJson(jsonDecode(data));
  LIST_BUS_STOP = dataBusStop.listBusStop;
}

getListRoute() async {
  final response =
      await http.get('https://emdbusapi.emddi.com/api/router', headers: {
    "x-access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXJfaWQiOjMsImZ1bGxfbmFtZSI6IlRFU1QgMDEiLCJwaG9uZV9udW1iZXIiOiIwMzM0MTA2NTg3IiwicGFzc3dvcmQiOiIkMmEkMTAkakhwWjBNRDN4NTBpaEY1Ui5rLlI1ZWZMVzNkNWwzQllIN09uUS5TSlhWUWRjMktYNURHUDYiLCJzdGF0dXMiOjAsImxvY2tlZCI6MCwiYmlydGhkYXkiOiIxOTk2LTA2LTIxIiwibGFzdF9sb2dpbiI6MTYxMTU2MzE3NDYxNSwib2ZmaWNlX2lkIjoyLCJpYXQiOjE2MTE1NjMxNzR9.hvM-B7GxSZ88qMEwc1QIV6EDzxP2HCEC8ycp6WkYgkQ"
  });
  DataRoute dataRoute = DataRoute.fromJson(jsonDecode(response.body));
  LIST_ROUTE = dataRoute.data;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: "EMDDI BUS",
        ),
        //Login(),
        //InfoUser(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: //MyHomePage(title: "EMDDI BUS",),
            Login(),
        //InfoUser(),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initialPosition}) : super(key: key);

  final String title;
  final Position initialPosition;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Tabs(),
      ),
    );
  }
}
