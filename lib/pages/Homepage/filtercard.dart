import 'package:flutter/material.dart';

class ClickedSweet extends StatelessWidget {
  final bool isSelected;
  final String text;
  final String image;
  final VoidCallback onTap;

  const ClickedSweet({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: isSelected ? 150.0 : 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            Image.asset(image, width: 30.0, height: 30.0),
            if (isSelected) SizedBox(width: 10.0),
            if (isSelected)
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
