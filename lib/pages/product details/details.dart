import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/cart/components/quantitycontroler.dart';

class Details extends StatefulWidget {
  const Details(
      {super.key,
      this.imagepath,
      this.caleri,
      this.components,
      this.description,
      this.price,
      this.name});
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
  int howmuch = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<cartopration>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background, // #F9CBDF
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(
                        bottom: Radius.circular(200.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary, // #F9CBDF
                        Theme.of(context).colorScheme.secondary, // #F9CBDF
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
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    )),
                                Spacer(),
                                value.favorateStatus(
                                        widget.name!,
                                        widget.imagepath!,
                                        widget.price!,
                                        widget.components!)
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            value.deldefavorate(
                                                widget.name!,
                                                widget.imagepath!,
                                                widget.price!,
                                                widget.components!);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            value.addtofavorat(
                                                widget.name!,
                                                widget.imagepath!,
                                                widget.price!,
                                                widget.components!);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary, // #F9CBDF
                                        ))
                              ],
                            ),
                            Container(
                              width: 300,
                              height: 300,
                              child: Image.network(widget.imagepath!),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.components!,
                        style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "🔥 ${widget.caleri} cal",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "⏰ 5-10minuts",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 350.0,
                        child: Text(
                          widget.description!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$ ${widget.price}",
                            style: TextStyle(
                              color: Colors.black,
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
                              color: Colors.grey,
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
                        height: 15.0,
                      ),
                      Consumer<cartopration>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              value.addtocart(widget.name!, widget.imagepath!,
                                  widget.price!,
                                  quantity: howmuch);
                              Navigator.pushNamed(context, Cart.id);
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
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              )),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
