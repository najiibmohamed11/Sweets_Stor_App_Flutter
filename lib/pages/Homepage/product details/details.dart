import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/pages/Homepage/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/Homepage/cart/components/quantitycontroler.dart';

class Details extends StatefulWidget {
  const Details({
    super.key,
    this.imagepath,
    this.caleri,
    this.components,
    this.description,
    this.price,
    this.name,
  });
  final String? imagepath;
  final String? name;
  final String? components;
  final int? caleri;
  final String? description;
  final int? price;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool? favortStatus = false;

  int howmuch = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<cartopration>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Color(0xffF6F6FB),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadiusDirectional.vertical(
                      //     bottom: Radius.circular(200.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF9CBDF), // #F9CBDF
                          Color.fromARGB(255, 216, 217, 225), // #EBE4F5
                        ],
                        stops: [0.1, 0.4],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back_ios)),
                                  Spacer(),
                                  favortStatus!
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              favortStatus = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              value.addtofavorate(
                                                  widget.name!,
                                                  widget.imagepath!,
                                                  widget.price!,
                                                  widget.components!


                                                 );

                                              favortStatus = true;
                                            });
                                          },
                                          icon: Icon(Icons.favorite_border))
                                ],
                              ),
                              Container(
                                width: 250,
                                height: 250,
                                child: Image.network(widget.imagepath!),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name!,
                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.components!,
                        style: TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 18.0,
                            color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "⭐ 5.0",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "🔥 ${widget.caleri} cal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "⏰ 5-10minuts",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 350.0,
                        child: Text(
                          widget.description!,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$ ${widget.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          Spacer(),
                          quantitycontroler(
                            icon: Icon(Icons.remove),
                            onTap: howmuch <= 1
                                ? null
                                : () {
                                    setState(() {
                                      howmuch--;
                                    });
                                  },
                          ),

                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            howmuch.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          // GestureDetector(

                          //   child:
                          quantitycontroler(
                            icon: Icon(Icons.add),
                            onTap: () {
                              setState(() {
                                howmuch++;
                              });
                            },
                          ),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 55.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          value.addtocart(
                              widget.name!, widget.imagepath!, widget.price!,
                              quantity: howmuch);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xff445BEF),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                              child: Text(
                            "add to bag",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from the top left corner
    path.lineTo(0, 0);

    // Draw a line across the top to the top right corner
    path.lineTo(size.width, 0);

    // Draw a line down the right side to the bottom right corner
    path.lineTo(
        size.width, size.height * 0.7); // Only draw down to 80% of the height

    // Create the curve
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(0, size.height * 0.7);

    // Add the bezier curve for the bottom
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    // Close the path by connecting the bottom left corner back to the top left corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
