import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/favorate/favorate.dart';
import 'package:sweet_app/pages/settings/settings.dart';
import 'package:sweet_app/pages/upload/uploadscreen.dart';
import 'package:sweet_app/pages/welcomescreen/welcome.dart';

class NavPar extends StatelessWidget {
  NavPar({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuthantication authanticateTheUser = FirebaseAuthantication();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF9CBDF),
              ),
              accountName: Text(
                currentUser?.displayName ?? 'Guest',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                currentUser?.email ?? 'No Email',
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
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
                        currentUser?.displayName!.substring(0, 1) ?? "G",
                        style: TextStyle(fontSize: 45.0, color: Colors.white),
                      ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Home.id);
              },
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(
                Icons.favorite_sharp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                "favorate",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Favorate.id);
              },
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                "cart",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
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
                      leading: Icon(
                        Icons.upload_file_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      title: Text(
                        "add new product",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
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
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                "settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                "Exit",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () async {
                FirebaseAuthantication().signOut();
                Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
