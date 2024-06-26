import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/navpar/navpar.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/cart/components/quantitycontroler.dart';
import 'package:sweet_app/pages/profile/profile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  static String id = "cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  int howmuch = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<cartopration>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        drawer: NavPar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: InvertedCurveClipper(),
                // borderRadius:
                // BorderRadius.vertical(bottom: Radius.circular(200.0)),
                child: Container(
                    width: double.infinity,
                    height: 500,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadiusDirectional.vertical(
                      //     bottom: Radius.circular(200.0)),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.menu_outlined,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                }),
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
                                          currentUser?.displayName!
                                                  .substring(0, 1) ??
                                              "G",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.white),
                                        )),
                            ),
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
                        value.cartinfo.length == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: Center(
                                    child: Text(
                                  "no data in the cart👏",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              )
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
                                            Container(
                                              width: 150,
                                              child: Text(
                                                value.cartinfo[index]["name"],
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow
                                                    .ellipsis, // This will show ellipsis on overflow
                                                maxLines:
                                                    3, // Adjust the number of lines as per your requirement
                                                softWrap:
                                                    true, // Prevents wrapping to a new line
                                                // Ensures the text does not exceed one line
                                              ),
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
                                                onTap: value.cartinfo[index]
                                                            ["quantity"] <=
                                                        1
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
                                                value.cartinfo[index]
                                                        ["quantity"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                              SizedBox(width: 6.0),
                                              quantitycontroler(
                                                icon: Icon(Icons.add),
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
                              )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 35.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SubTotal",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: Colors.grey[600]),
                        ),
                        Text(
                          "\$${value.total()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: Colors.grey[600]),
                        ),
                        Text(
                          "- 0%",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DashedLine(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1.0,
                              color: Colors.grey[800]),
                        ),
                        Text(
                          "\$${value.total()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1.0,
                              color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xff445BEF),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text(
                          "checkout",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DashedLine({
    Key? key,
    this.height = 1,
    this.color = Colors.grey,
    this.dashWidth = 10,
    this.dashSpace = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}

class InvertedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // The distance the curve should go above the bottom
    double curveHeight = 50;

    path.lineTo(
        0,
        size.height -
            curveHeight); // Start from the left bottom minus curve height
    // The control points for the bezier curve
    var controlPoint1 = Offset(size.width / 4, size.height + curveHeight);
    var controlPoint2 = Offset(3 * size.width / 4, size.height + curveHeight);
    // The end point of the bezier curve
    var endPoint = Offset(size.width, size.height - curveHeight);

    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, size.width / 2, size.height);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0); // Go up to the top right corner
    path.close(); // Closes the path to the beginning of the draw
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
