import 'package:facemap_app/utils/session.dart';

class Urls {
  static String _localIp = "http://192.168.0.3:1291/api/user/";
  static String _production =
      "https://face-map-node-server.herokuapp.com/api/user/";
  static final String _baseUrl = Session.isLocalHost ? _localIp : _production;
  static final String _localhost = "http://192.168.0.3:1291/";
  static final String _productionhost = "https://face-map-node-server.herokuapp.com/";

  static final String host = Session.isLocalHost ? _localhost : _productionhost;

  static final String login = _baseUrl + "login";
  static final String dashboard = _baseUrl + "dashboard";

}
