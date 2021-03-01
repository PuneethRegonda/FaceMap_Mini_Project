import 'package:facemap_app/models/recognized_face.dart';

class Location {
  String name;
  String lat, long;
  List<RecognizedFace> totalFaces = [];
  Map<String, RecognizedFace> realTimeFaces = {};
  // List<RecognizedFace> realTimeFaces=[];
  Location(
      {this.name, this.lat, this.long, this.realTimeFaces, this.totalFaces});
}
