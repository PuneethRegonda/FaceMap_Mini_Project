import 'dart:convert';

import 'package:facemap_app/utils/session.dart';
import 'package:http/http.dart';

import '../utils/result.dart';
import '../utils/urls.dart';

class AuthApi {
  static Future<Result> login() async {
    print("auth login");
    var payload = {
      "username": "facemap_admin",
      "password": "facemap_admin1291"
    };
    if (Session.isLocalHost) {
      payload = {'username': 'puneeth', 'password': 'password'};
    }

    Response response = await post(Urls.dashboard, body: payload);
    Result result = Result();
    if (response.statusCode == 200) {
      
      result.isSuccess = true;
      result.message = "Login Succesful";
      result.data = {
        'auth-token': response.headers["auth-token"],
        'location': json.decode(response.body)['data']['location']
      };
    } else {
      result.isSuccess = false;
      result.message = "Login failed";
      result.data = json.decode(response.body);
    }
    print(result);
    return result;
  }
}
