class RecognizedFace {
  String name, location, time,lastLocation;
  RecognizedFace({this.name, this.time, this.location,this.lastLocation = ""});

  factory RecognizedFace.fromOldFacesJSON(map) {
    if (map == null) return null;
    return RecognizedFace(
        name: map["name"],
        location: map["current_location"],
        time: map["createdAt"]);
  }

  factory RecognizedFace.fromKnownFaces(map) {
    if (map == null) return null;
    return RecognizedFace(
        name: map["name"],
        location: map["current_location"],
        time: map["createdAt"],
        lastLocation: map["last_location"]
      );
  }

  static List<RecognizedFace> fromOldFacesJsonList(
      List<dynamic> list) {
    List<RecognizedFace> _out = [];
    for (dynamic map in list) {
      _out.add(RecognizedFace.fromOldFacesJSON(map));
    }
    return _out;
  }

  @override
  String toString() {
    return "RecognizedFace{name: $name, location: $location, time: $time,lastLocation: $lastLocation}";
  }


}
