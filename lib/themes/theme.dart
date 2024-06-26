import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFFEFEEF7),
  colorScheme: ColorScheme.light(
      primary: Color(0xFFF9CBDF),
      secondary: Color.fromARGB(255, 216, 217, 225),
      background: Colors.white,
      onPrimary: Colors.black, // Text color on top of primary color
      onSecondary: Colors.black, // Text color on top of secondary color
      onSurface: Color(0xffF1F1F1)),
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
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.white, // Your desired background color
  ),
);
final ThemeData darktheam = ThemeData(
  primaryColor: Color(0xFFF9CBDF),
  colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.black,
      background: Color(0xFFF9CBDF),
      onPrimary: Colors.white, // Text color on top of primary color
      onSecondary: Colors.black, // Text color on top of secondary color
      onSurface: Color(0xFFF9CBDF)),

  scaffoldBackgroundColor: Colors.grey,
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

  // Define the default brightness and colors.
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.black, // Your desired background color
  ),
);
