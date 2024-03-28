import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool switchvalue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF9CBDF), // #F9CBDF

          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "notifivations",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: Text(
                "Allow Notifications",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              trailing: Switch(
                  value: switchvalue,
                  onChanged: (value) {
                    setState(() {
                      switchvalue = value;
                    });
                  }),
            ),
          ],
        ));
  }
}
