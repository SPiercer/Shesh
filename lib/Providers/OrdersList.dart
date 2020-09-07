import 'package:flutter/material.dart';
import 'package:shesha/Models/Order.dart';

class OrderListProvider extends ChangeNotifier {
  final List<Order> _newOrderList = List<Order>();
  final List<Order> _oldOrderList = List<Order>();

  List<Order> get newOrderList => _newOrderList;
  List<Order> get oldOrderList => _oldOrderList;

  void removeOld(int id) {
    _oldOrderList.removeAt(id);
  }

  void removeNew(int id) {
    _newOrderList.removeAt(id);
  }
}
