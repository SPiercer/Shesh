import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login {
  Future<void> login(String phone) async {
    http.Response response =
        await http.post("https://mazajasly.com/ar/api/auth/login", body: {
      'phone': phone
    }, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    Map<String, dynamic> body = json.decode(response.body);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(
        'token', "${body['token_type']} ${body['access_token']}");
  }
}
