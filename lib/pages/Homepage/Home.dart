import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sweet_app/pages/Homepage/bigcard.dart';
import 'package:sweet_app/pages/Homepage/filtercard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedSweet = "donuts";

  void switchSweet(String sweet) {
    setState(() {
      selectedSweet = sweet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Icon(Icons.menu_outlined),
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
                      isSelected: selectedSweet == "donuts",
                      text: "Donuts",
                      image: "images/donut-icon.png",
                      onTap: () => switchSweet("donuts"),
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
                      isSelected: selectedSweet == "chuckulate",
                      text: "chuckulate",
                      image: "images/chuckulate icon.png",
                      onTap: () => switchSweet("chuckulate"),
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
              Expanded(
                child: ListView(
                  children: [
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10,
                      children: [
                        sweetcard(
                          imagepath: "images/strawberry_blast.webp",
                          name: "Pink Donutes",
                          description:
                              "sugar,flour,butter, \nstrawberry jam,\npink glaze",
                          price: 5.0,
                        ),
                        sweetcard(
                            imagepath: "images/creamy_nonsense.webp",
                            name: "White Donut",
                            price: 4.0,
                            description: "sugar,flour,butter,white glaze"),
                        sweetcard(
                            imagepath: "images/chocolate_dream.webp",
                            name: "Choco Donut",
                            price: 5.0,
                            description:
                                "sugar,flour,butter,chocolate topping"),
                        sweetcard(
                          imagepath: "images/strawberry_blast.webp",
                          name: "Pink Donutes",
                          description:
                              "sugar,flour,butter, \nstrawberry jam,\npink glaze",
                          price: 5.0,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
