import 'package:facemap_app/models/camera_locations.dart';
import 'package:facemap_app/models/location.dart';
import 'package:facemap_app/models/recognized_face.dart';
import 'package:facemap_app/utils/session.dart';
import 'package:flutter/foundation.dart';

class RecognizedFacesProvider extends ChangeNotifier {
  Map<String, Location> _locations = {};

  Map<String, Location> get locations => _locations;

  // adding old_faces '
  set addOldFacesToLocations(List old_faces) {
    print(old_faces);
  }

  // adding new_faces
  set addRealTimeFacesToLocations(RecognizedFace newFaces) {
    // check location is present?

    if (_locations[newFaces.location] != null) {
      // yes check this face already present?
      // if ( != null) {
      //   //  not present so add
      //   _locations[newFaces.location]
      //       .realTimeFaces[newFaces.name] = newFaces;
      // } else {
      //   // present so remove last and update new
      //   _locations[newFaces.location].realTimeFaces[newFaces.name] =
      //         newFaces;

      // }
      _locations[newFaces.location].realTimeFaces[newFaces.name] = newFaces;
      notifyListeners();
    } else {
      // No add the Location
      CameraLocations _camLoc = Session.cameraLocations[newFaces.location];
      _locations[newFaces.location] = Location(
          lat: _camLoc.lat,
          long: _camLoc.long,
          name: _camLoc.name,
          realTimeFaces: {},
          totalFaces: []);
    }
    notifyListeners();
  }

  List<RecognizedFace> _allrecognizedFaces = [];

  List get allrecognizedFaces => _allrecognizedFaces;

  set allrecognizedFaces(List value) {
    _allrecognizedFaces = value;
    notifyListeners();
  }

  List<RecognizedFace> _recognizedFaces = [];

  List get recognizedFaces => _recognizedFaces;

  set recognizedFaces(List value) {
    _recognizedFaces = value;
    notifyListeners();
  }

  set addNewFaces(RecognizedFace face) {
    print('addingd $recognizedFaces');
    bool t = false;

    for (RecognizedFace recognizedface in recognizedFaces) {
      if (recognizedface.location == face.location) {
        recognizedface.location = face.location;
        recognizedface.time = face.time;
        t = true;
        notifyListeners();
        break;
      }
    }

    if (!t) {
      print("adding");
      recognizedFaces.add(face);
      notifyListeners();
    }
  }
}
