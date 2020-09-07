import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Orders {
  Future<Map<String, dynamic>> newOrders(int page) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        "https://mazajasly.com/ar/api/driver/orders?status=new&page=${page + 1}",
        headers: {
          'Accept': 'application/json',
          'Authorization': pref.getString('token')
        });
    print('RESPONDED');
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> oldOrders(int page) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        "https://mazajasly.com/ar/api/driver/orders?status=old&page=${page + 1}",
        headers: {
          'Accept': 'application/json',
          'Authorization': pref.getString('token')
        });
    print('RESPONDED');
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> finishOrder(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.put(
        "https://mazajasly.com/ar/api/driver/orders/$id/update_status",
        headers: {
          'Accept': 'application/json',
          'Authorization': pref.getString('token'),
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    return json.decode(response.body);
  }
}
