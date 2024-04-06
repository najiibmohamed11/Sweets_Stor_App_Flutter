import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/navpar/navpar.dart';
import 'package:sweet_app/pages/components/bigcard.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/components/filtercard.dart';
import 'package:sweet_app/pages/product%20details/details.dart';
import 'package:sweet_app/pages/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  final User? currentUser = FirebaseAuth.instance.currentUser;

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
        backgroundColor: Color(0xFFF9CBDF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0), // Adjust radius here
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        },
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.black,
        ),
      ),
      body: Consumer<cartopration>(
        builder: (context, value, child) => SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                stops: [0.1, 0.4],
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green[300],
                        child: currentUser?.photoURL != null
                            ? ClipOval(
                                child: Image.network(
                                  currentUser!.photoURL!,
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                ),
                              )
                            : Text(
                                _auth.currentUser?.displayName!
                                        .substring(0, 1) ??
                                    "G",
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Text(
                  "HI, ${_auth.currentUser?.displayName!.split(" ").first ?? "user"}👋",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search..",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSecondary,
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
                SizedBox(height: 20.0),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(selectedSweet)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No Data'));
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1 / 1.5,
                        ),
                        itemBuilder: (context, index) {
                          var cardData =
                              snapshot.data!.docs.reversed.toList()[index];
                          String documentId = cardData.id;
                          String name = cardData["name"];
                          int price = cardData["price"].toInt();
                          int calori = cardData["calors"].toInt();
                          String imagepath = cardData["imagepath"];
                          String description = cardData["description"];
                          String components = cardData["components"];
                          return SweetCard(
                            collection: selectedSweet,
                            id: documentId,
                            carttap: () {
                              value.addtocart(name, imagepath, price);
                            },
                            imagepath: imagepath,
                            name: name,
                            description: components,
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
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
