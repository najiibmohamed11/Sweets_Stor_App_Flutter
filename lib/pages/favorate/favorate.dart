import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/pages/Home/bigcard.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';

class Favorate extends StatefulWidget {
  const Favorate({super.key});
  static String id = "favorate";

  @override
  State<Favorate> createState() => _FavorateState();
}

class _FavorateState extends State<Favorate> {
  @override
  Widget build(BuildContext context) {
    return Consumer<cartopration>(
      builder: (context, value, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
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
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "My favorate",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: false,
                        itemCount: value.addtofavorate.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.5, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return value.addtofavorate.length == 0
                              ? Text("no favorate data")
                              : sweetcard(
                                  name: value.addtofavorate[index]["name"],
                                  // carttap: () => value.addtocart(name, imagepath, price),
                                  imagepath: value.addtofavorate[index]
                                      ["imagepath"],
                                  description: value.addtofavorate[index]
                                      ["ingridents"],
                                  price: value.addtofavorate[index]["price"],
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
