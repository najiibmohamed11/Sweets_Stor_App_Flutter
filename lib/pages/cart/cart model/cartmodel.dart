import 'package:flutter/material.dart';
import 'package:sweet_app/pages/favorate/favorate.dart';
import 'package:sweet_app/themes/theme.dart';

class cartopration extends ChangeNotifier {
  bool _isdark = false;
  List<Map<String, dynamic>> cartinfo = [];
  List<Map<String, dynamic>> addtofavorate = [];
  ThemeData themeData = lightTheme;

  bool getisdark() {
    return _isdark;
  }

void changetheme(bool isdark) {
  _isdark = isdark;
  themeData = isdark ? darktheam : lightTheme; // Corrected typo and simplified logic
  notifyListeners();
}

  void addtocart(String name, String imagepath, int price, {int quantity = 1}) {
    bool checkdublicate = false;
    for (var cart in cartinfo) {
      if (cart["name"] == name &&
          cart["imagepath"] == imagepath &&
          cart["price"] == price) {
        cart["quantity"]++;
        checkdublicate = true;
        break;
      }
    }
    if (!checkdublicate) {
      cartinfo.add({
        "name": name,
        "imagepath": imagepath,
        "price": price,
        "quantity": quantity
      });
    }

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

  void deldefavorate(
      String name, String imagepath, int price, String ingridents) {
    int indexToRemove = -1;
    for (int i = 0; i < addtofavorate.length; i++) {
      if (addtofavorate[i]["name"] == name &&
          addtofavorate[i]["imagepath"] == imagepath &&
          addtofavorate[i]["price"] == price &&
          addtofavorate[i]["ingridents"] == ingridents) {
        indexToRemove = i;
        break;
      }
    }

    if (indexToRemove != -1) {
      addtofavorate.removeAt(indexToRemove);
      print(addtofavorate);
      notifyListeners();
    }
  }

  bool favorateStatus(
      String name, String imagepath, int price, String ingridents) {
    for (var favorate in addtofavorate) {
      if (favorate["name"] == name &&
          favorate["imagepath"] == imagepath &&
          favorate["price"] == price &&
          favorate["ingridents"] == ingridents) {
        return true;
      }
    }
    return false;
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
