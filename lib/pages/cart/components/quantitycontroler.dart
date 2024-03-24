import 'package:flutter/material.dart';

class quantitycontroler extends StatelessWidget {
  quantitycontroler({super.key, required this.onTap, required this.icon});
  void Function()? onTap;
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffC3CBF3),
            borderRadius: BorderRadius.circular(15.0)),
        width: 50,
        height: 50,
        child: icon,
      ),
    );
  }
}
