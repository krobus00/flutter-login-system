import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';
import 'package:latihan_request/model/login_model.dart';
import 'package:latihan_request/model/regis_model.dart';
import 'package:latihan_request/model/info_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String baseAPI = "http://192.168.2.101:3000";
  Future doLogin(String username, String password) async {
    String apiURL = baseAPI + "/login";
    var apiResult = await http
        .post(apiURL, body: {"username": username, "password": password});
    final jsonResponse = json.decode(apiResult.body);
    print(jsonResponse);
    Login login = new Login.fromJson(jsonResponse);
    return login;
  }

  Future doRegis(String name, String username, String password) async {
    String apiURL = baseAPI + "/register";
    var apiResult = await http.post(apiURL,
        body: {"name": name, "username": username, "password": password});
    final jsonResponse = json.decode(apiResult.body);
    Regis regis = new Regis.fromJson(jsonResponse);
    return regis;
  }

  Future getInfo(String token) async {
    String apiURL = baseAPI + "/info";
    var apiResult = await http.get(
      apiURL,
      headers: {"Authorization": "Bearer "+token},
    );
    final jsonResponse = json.decode(apiResult.body);
    Info info = new Info.fromJson(jsonResponse);
    return info;
  }
}
