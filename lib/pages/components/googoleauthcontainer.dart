
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class authanticationcontainer extends StatelessWidget {
  authanticationcontainer(
      {super.key, this.authanticationmethodeimage, this.onTap});
  String? authanticationmethodeimage;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 216, 217, 225), // #EBE4F5

          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black),
        ),
        child: Image.asset(authanticationmethodeimage!),
      ),
    );
  }
}
