import 'package:flutter/material.dart';

class sweetcard extends StatelessWidget {
  sweetcard(
      {super.key, this.imagepath, this.description, this.name, this.price});
  String? imagepath;
  String? name;
  String? description;
  double? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      width: 180,
      height: 280.0,
      decoration: BoxDecoration(
        color: Color(0xFFEBE4F5),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100.0,
              height: 100.0,
              child: Image.network(imagepath!),
            ),
          ),
          Text(
            name!,
            style: TextStyle(
                letterSpacing: 2.0, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(description!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price!.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.shopping_cart_outlined),
              )
            ],
          )
        ],
      ),
    );
  }
}
