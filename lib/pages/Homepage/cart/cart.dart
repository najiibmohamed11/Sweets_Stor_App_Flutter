import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/navpar/navpar.dart';
import 'package:sweet_app/pages/Homepage/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/Homepage/cart/components/quantitycontroler.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  static String id = "cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int howmuch = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavPar(),
      body: SafeArea(
          child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 500,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(200.0)),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      "My Cart",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Consumer<cartopration>(
                    builder: (context, value, child) {
                      return value.cartinfo.length == 0
                          ? Text("no data in the cart")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: value.cartinfo.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEBE4F5),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: ListTile(
                                      leading: Image.network(
                                          value.cartinfo[index]["imagepath"]),
                                      title: Row(
                                        children: [
                                          Text(
                                            value.cartinfo[index]["name"],
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text(
                                              "\$${value.cartinfo[index]["price"]}")
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          children: [
                                            quantitycontroler(
                                              icon: Icon(Icons.remove),
                                              onTap: howmuch <= 1
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        value.cartinfo[index]
                                                            ["quantity"]--;
                                                      });
                                                    },
                                            ),
                                            SizedBox(width: 6.0),
                                            Text(
                                              value.cartinfo[index]["quantity"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(width: 6.0),
                                            quantitycontroler(
                                              icon: Icon(Icons.remove),
                                              onTap: () {
                                                setState(() {
                                                  value.cartinfo[index]
                                                      ["quantity"]++;
                                                });
                                              },
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  value.deledefromcart(index);
                                                },
                                                icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )),
        ],
      )),
    );
  }
}
