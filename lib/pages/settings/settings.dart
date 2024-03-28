import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/appearance/appearance.dart';
import 'package:sweet_app/pages/notifications/notification.dart';
import 'package:sweet_app/pages/profile/profile.dart';
import 'package:sweet_app/pages/welcomescreen/welcome.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9CBDF), // #F9CBDF

        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'search',
                filled: true,
                fillColor: Color(0xffF1F1F1),
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              leading: Icon(
                Icons.person_outline_sharp,
                size: 30.0,
              ),
              title: Text(
                "account",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notifications(),
                    ));
              },
              leading: Icon(
                Icons.notifications_none,
                size: 30.0,
              ),
              title: Text(
                "notifications",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appearance(),
                    ));
              },
              leading: Icon(
                Icons.remove_red_eye_outlined,
                size: 30.0,
              ),
              title: Text(
                "appearance",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.lock_outline_rounded,
                size: 30.0,
              ),
              title: Text(
                "privacy & security",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.support_agent,
                size: 30.0,
              ),
              title: Text(
                "help & support",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.contact_support_outlined,
                size: 30.0,
              ),
              title: Text(
                "about",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                FirebaseAuthantication().signOut();
                Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 30.0,
                color: Colors.red,
              ),
              title: Text(
                "logout",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
