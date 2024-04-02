import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFFF9CBDF),
  colorScheme: ColorScheme.light(
    primary: Color(0xFFF9CBDF),
    secondary: Color.fromARGB(255, 216, 217, 225),
    background: Colors.white,
    onPrimary: Colors.black, // Text color on top of primary color
    onSecondary: Colors.black, // Text color on top of secondary color
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Color(0xFFF9CBDF),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
  ),
);
final ThemeData darktheam = ThemeData(
  primaryColor: Colors.black,
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.black,
    background: Color(0xFFF9CBDF),
    onPrimary: Colors.white, // Text color on top of primary color
    onSecondary: Colors.black, // Text color on top of secondary color
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Color(0xFFF9CBDF),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
);
