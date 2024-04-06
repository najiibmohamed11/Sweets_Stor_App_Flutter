import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/pages/components/bigcard.dart';
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
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary, // #F9CBDF
                    Theme.of(context).colorScheme.secondary,
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
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
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
                      value.addtofavorate.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  "EMPTY💓",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                shrinkWrap: false,
                                itemCount: value.addtofavorate.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.5,
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      10, // Add space between columns
                                ),
                                itemBuilder: (context, index) {
                                  return value.addtofavorate.length == 0
                                      ? Text("no favorate data")
                                      : SweetCard(
                                          name: value.addtofavorate[index]
                                              ["name"],
                                          // carttap: () => value.addtocart(name, imagepath, price),
                                          imagepath: value.addtofavorate[index]
                                              ["imagepath"],
                                          description:
                                              value.addtofavorate[index]
                                                  ["ingridents"],
                                          price: value.addtofavorate[index]
                                              ["price"],
                                        );
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
