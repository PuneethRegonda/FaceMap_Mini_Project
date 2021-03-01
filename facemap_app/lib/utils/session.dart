import 'package:facemap_app/models/camera_locations.dart';

import '../api/auth.dart';
import 'result.dart';

class Session {
  // this is just for development
  static bool isLocalHost = true;
  static String authToken = "";
  static Map<String, CameraLocations> cameraLocations = {};

  static Future<bool> startSession() async {
    print(".........starting session..........");
    Result result = await AuthApi.login();
    if (result.isSuccess) {
      authToken = result.data['auth-token'];
      cameraLocations = CameraLocations.fromJSONList(result.data['location']);
    }
    return result.isSuccess;
  }
}
