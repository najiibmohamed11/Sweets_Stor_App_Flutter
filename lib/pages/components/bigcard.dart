import 'package:flutter/material.dart';

class sweetcard extends StatelessWidget {
  sweetcard(
      {super.key,
      this.imagepath,
      this.description,
      this.name,
      this.price,
      this.ontaped,
      this.carttap});
  String? imagepath;
  String? name;
  String? description;
  int? price;
  void Function()? ontaped;
  void Function()? carttap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontaped,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: 180,
        height: 280.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
                  letterSpacing: 2.0,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              description!,
              maxLines: 3, // Adjust the number of lines as per your requirement
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: carttap,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
