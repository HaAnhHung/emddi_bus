import 'package:emddi_bus/bus_stop.dart';

class DataBusStop{
  int code;
  String message;
  List<BusStop> listBusStop;

  DataBusStop({this.code, this.message, this.listBusStop});
  factory DataBusStop.fromJson(dynamic json){
    var listBusStop = json['data']['bus_stop'] as List;
    List<BusStop> _listBusStop = listBusStop.map((e) => BusStop.fromJson(e)).toList();
    return DataBusStop(
      code: json['code'],
      message: json['message'],
      listBusStop: _listBusStop
    );
  }
}