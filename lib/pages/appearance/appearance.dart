import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  bool switchvalue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF9CBDF), // #F9CBDF

          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "appearance",
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
                "light & darl mode",
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
