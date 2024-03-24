import 'package:flutter/material.dart';

class cartopration extends ChangeNotifier {
  List<Map<String, dynamic>> cartinfo = [];
  List<Map<String, dynamic>> addtofavorate = [];
  void addtocart(String name, String imagepath, int price, {int quantity = 1}) {
    cartinfo.add({
      "name": name,
      "imagepath": imagepath,
      "price": price,
      "quantity": quantity
    });
    notifyListeners();
  }

  void addtofavorat(
      String name, String imagepath, int price, String ingridents) {
    addtofavorate.add({
      "name": name,
      "imagepath": imagepath,
      "price": price,
      "ingridents": ingridents
    });
    print(addtofavorate);
    notifyListeners();
  }

  void deledefromcart(int index) {
    cartinfo.removeAt(index);
    notifyListeners();
  }
}
