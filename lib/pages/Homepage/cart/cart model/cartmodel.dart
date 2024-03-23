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
    notifyListeners();
    print(total());
  }

  void deledefromcart(int index) {
    cartinfo.removeAt(index);
    notifyListeners();
  }

  int total() {
    int accumulator = 0; // Initialize accumulator with 0
    for (var cart in cartinfo) {
      accumulator += (cart["price"] as int) *
          (cart["quantity"] as int); // Explicitly cast to int
    }

    return accumulator;
  }
}
