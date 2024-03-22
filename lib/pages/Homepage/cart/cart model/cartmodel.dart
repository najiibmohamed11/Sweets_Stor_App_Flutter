import 'package:flutter/material.dart';

class cartopration extends ChangeNotifier {
  List<Map<String, dynamic>> cartinfo = [];
  void addtocart(String name, String imagepath, int price, {int quantity = 1}) {
    cartinfo.add({
      "name": name,
      "imagepath": imagepath,
      "price": price,
      "quantity": quantity
    });
    print(cartinfo);
  }

  void deledefromcart(int index) {
    cartinfo.removeAt(index);
    notifyListeners();
  }
}
