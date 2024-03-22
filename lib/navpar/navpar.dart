import 'package:flutter/material.dart';
import 'package:sweet_app/pages/Homepage/Home.dart';
import 'package:sweet_app/pages/Homepage/cart/cart.dart';
import 'package:sweet_app/pages/Homepage/upload/uploadscreen.dart';

class NavPar extends StatelessWidget {
  const NavPar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("abdinajib"),
              accountEmail: Text("abdinaji@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              )),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.id);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.favorite_sharp),
            title: Text("favorate"),
            onTap: () {},
          ),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text("cart"),
            onTap: () {
              Navigator.pushNamed(context, Cart.id);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.upload_file_outlined),
            title: Text("add new product"),
            onTap: () {
              Navigator.pushNamed(context, Uploadscreen.id);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
