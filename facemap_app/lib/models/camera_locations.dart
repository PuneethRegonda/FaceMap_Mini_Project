class CameraLocations {
  String long;
  String lat;
  String name;

  CameraLocations({this.lat, this.long, this.name});

  factory CameraLocations.fromJSON(map) {
    return CameraLocations(
        lat: map['lat'], long: map['long'], name: map['name']);
  }

  static Map<String, CameraLocations> fromJSONList(data) {
    Map<String, CameraLocations> outmap = {};
    for (dynamic map in data) {
      outmap[map['name']] = CameraLocations.fromJSON(map);
    }
    return outmap;
  }
}
