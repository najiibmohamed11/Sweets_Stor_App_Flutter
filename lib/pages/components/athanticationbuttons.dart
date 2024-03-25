import 'package:flutter/material.dart';

class athenticationbuttons extends StatelessWidget {
  athenticationbuttons(
      {super.key, this.name, this.color, this.onTap, this.textcolor});
  String? name;
  Color? color;
  Color? textcolor;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Center(
          child: Text(
            name!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: textcolor, // Change the color here
            ),
          ),
        ),
      ),
    );
  }
}
