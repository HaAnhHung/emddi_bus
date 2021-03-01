class RouterBus {
  final String name, description, distance, startTime, endTime, startPoint, endPoint, city;
  final int routerId, officeId;

  RouterBus({
      this.routerId,
      this.name,
      this.description,
      this.distance,
      this.startTime,
      this.endTime,
      this.startPoint,
      this.endPoint,
      this.officeId,
      this.city});
  factory RouterBus.fromJson(dynamic json){
    return RouterBus(routerId: json['router_id'],
        name: json['name'],
        description: json['description'],
        distance: json['distance'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        startPoint: json['start_point'],
        endPoint: json['end_point'],
        officeId: json['office_id'],
        city: json['city']);
  }
}