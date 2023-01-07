import 'dart:convert';
import '../local_storage.dart';
import '/Services/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {


  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL+'/login');

    http.Response response = await http.post(
      url,
      headers: header1,
      body: body,
    );
    print("me");
    return response;
  }
  static Future<http.Response> logout() async {

    String? token = await tokenStorage.getToken();

    print('Token : ${token}');


    var url = Uri.parse(baseURL+'/logout');

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'},

    );
    print(response.body);
    return response;
  }


  static Future<http.Response> register(String name,String email,String password,String password_conf) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password_conf,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL+'/register');
    http.Response response = await http.post(
      url,
      headers: header1,
      body: body,
    );
    return response;
  }

}
class Viva {


  static Future<http.Response> create(Map data) async {

    String? token = await tokenStorage.getToken();

    var body = json.encode(data);
    var url = Uri.parse(baseURL+'/newviva');

    http.Response response = await http.post(
      url,
       headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'},
      body: body,
    );
    return response;
  }


  static Future<http.Response> getViva(String code) async {
    var url = Uri.parse(baseURL+'/viva/'+'$code');

    http.Response response = await http.get(
      url,
      headers: header1,
    );
    print("viva by code");
    return response;
  }


  static Future<http.Response> getUserVivas() async {

    String? token = await tokenStorage.getToken();

    var url = Uri.parse(baseURL+'/userviva/');

    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'},
    );
    print('user vivas');
    return response;
  }
}