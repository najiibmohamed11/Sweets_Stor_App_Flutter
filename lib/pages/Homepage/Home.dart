import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/navpar/navpar.dart';
import 'package:sweet_app/pages/Homepage/bigcard.dart';
import 'package:sweet_app/pages/Homepage/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/Homepage/filtercard.dart';
import 'package:sweet_app/pages/Homepage/product%20details/details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedSweet = "dunts";
  // String colectionsweet = "dunts";

  void switchSweet(String sweet) {
    setState(() {
      selectedSweet = sweet;
      // colectionsweet = sweet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavPar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Adjust radius here
        ),
        onPressed: () {},
        child: Icon(Icons.shopping_cart_outlined),
      ),
      body: SafeArea(
        child: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.menu_outlined),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      }),
                  CircleAvatar(
                    child: Icon(Icons.person),
                  )
                ],
              ),
              SizedBox(height: 40.0),
              Text(
                "HI, Anna👋",
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search..",
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickedSweet(
                      isSelected: selectedSweet == "dunts",
                      text: "Donuts",
                      image: "images/donut-icon.png",
                      onTap: () => switchSweet("dunts"),
                    ),
                    SizedBox(width: 10.0),
                    ClickedSweet(
                      isSelected: selectedSweet == "candy",
                      text: "Candy",
                      image: "images/candy.png",
                      onTap: () => switchSweet("candy"),
                    ),
                    SizedBox(width: 10.0),
                    ClickedSweet(
                      isSelected: selectedSweet == "chocolate",
                      text: "chuckulate",
                      image: "images/chuckulate icon.png",
                      onTap: () => switchSweet("chocolate"),
                    ),
                    SizedBox(width: 10.0),
                    ClickedSweet(
                      isSelected: selectedSweet == "cake",
                      text: "cake",
                      image: "images/cake.png",
                      onTap: () => switchSweet("cake"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(child: Consumer<cartopration>(
                builder: (context, value, child) {
                  return ListView(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(selectedSweet)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading indicator while waiting for data
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text(
                                'No Data'); // Placeholder for empty data
                          }
                          // If we reach here, we have data
                          List<Widget> sweetCards = [];
                          for (var cardData in snapshot.data!.docs.reversed) {
                            // Assuming "name" is the correct field name in Firestore
                            String name = cardData[
                                "name"]; // Adjust field name if necessary
                            int price = cardData["price"]
                                .toInt(); // Make sure this is an int
                            int calori = cardData["calors"]
                                .toInt(); // Make sure this is an int
                            String imagepath = cardData["imagepath"];
                            String description = cardData["description"];
                            String components = cardData["components"];
                            // Add a new sweetcard widget to the list
                            sweetCards.add(
                              sweetcard(
                                  carttap: () {
                                    value.addtocart(name, imagepath, price);
                                  },
                                  imagepath: imagepath,
                                  name: name, // Use retrieved name
                                  description:
                                      "sugar,flour,butter,\nstrawberry jam,\npink glaze",
                                  price: price,
                                  ontaped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          imagepath: imagepath,
                                          caleri: calori,
                                          name: name,
                                          description: description,
                                          components: components,
                                          price: price,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                          // Return the list of sweetcard widgets wrapped in a Column
                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10,
                            children: sweetCards,
                          );
                        },
                      )
                    ],
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
