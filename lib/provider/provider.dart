import 'package:demo/provider/item.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get item => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void delete(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
