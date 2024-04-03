import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    return Consumer<cartopration>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
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
                    leading: value.getisdark() == false
                        ? Icon(
                            Icons.light_mode,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.dark_mode,
                            color: Colors.grey,
                          ),
                    title: Text(
                      "light & darl mode",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    trailing: Switch(
                        activeColor: Colors.white,
                        value: value.getisdark(),
                        onChanged: (v) {
                          print(v);
                          value.changetheme(v);
                        }),
                  ),
                ],
              ),
            ));
  }
}
