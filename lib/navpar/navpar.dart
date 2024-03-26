import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/favorate/favorate.dart';
import 'package:sweet_app/pages/upload/uploadscreen.dart';
import 'package:sweet_app/pages/welcomescreen/welcome.dart';

class NavPar extends StatelessWidget {
  NavPar({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuthantication authanticateTheUser = FirebaseAuthantication();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(currentUser?.displayName ?? 'Guest'),
            accountEmail: Text(currentUser?.email ?? 'No Email'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.id);
            },
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.favorite_sharp),
            title: Text("favorate"),
            onTap: () {
              Navigator.pushNamed(context, Favorate.id);
            },
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text("cart"),
            onTap: () {
              Navigator.pushNamed(context, Cart.id);
            },
          ),
          SizedBox(height: 20.0),
          FutureBuilder<String>(
            future: authanticateTheUser
                .getCurrentUserRoleByEmail(), // This should be your method returning Future<String>
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data == "admin") {
                  return ListTile(
                    leading: Icon(Icons.upload_file_outlined),
                    title: Text("add new product"),
                    onTap: () {
                      Navigator.pushNamed(context, Uploadscreen.id);
                    },
                  );
                }
                return SizedBox
                    .shrink(); // User is not admin or role couldn't be determined
              } else {
                return Center(
                    child:
                        CircularProgressIndicator()); // Loading indicator while waiting for future to complete
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () async {
              FirebaseAuthantication().signOut();
              Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
            },
          )
        ],
      ),
    );
  }
}
