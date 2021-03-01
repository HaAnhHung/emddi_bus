import 'package:emddi_bus/route.dart';
import 'dart:core';
class DataRoute{
  int code;
  String message;
  List<RouterBus> data;
  DataRoute({this.code, this.message, this.data});
  factory DataRoute.fromJson(Map<String, dynamic> json){
    var listRoute = json['data']['list_routes'] as List;
    List<RouterBus> list = listRoute.map((e) => RouterBus.fromJson(e)).toList();
    return DataRoute(code: json['code'], message: json['message'], data: list);
  }
}