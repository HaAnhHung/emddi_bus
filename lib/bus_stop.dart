class BusStop{
  List<int> routeId;
  String name;
  double lat, long;

  BusStop({this.routeId, this.name, this.lat, this.long});

  factory BusStop.fromJson(dynamic json){
    var listRouteId = json['router_id'] as List;
    List<int> _listRouteId = List.from(listRouteId);
    return BusStop(
        routeId: _listRouteId,
        name: json['name'],
        lat: json['latitude'],
        long: json['longitude']
    );
  }
}