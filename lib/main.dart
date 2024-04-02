import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/firebase_options.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/favorate/favorate.dart';
import 'package:sweet_app/pages/upload/uploadscreen.dart';
import 'package:sweet_app/pages/welcomescreen/welcome.dart';
import 'package:sweet_app/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user from FirebaseAuth
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Determine the initial route based on the authentication status
    final String initialRoute =
        currentUser == null ? WelcomeScreen.id : Home.id;

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => cartopration())],
      child: MaterialApp(
        theme: darktheam,
        initialRoute: initialRoute, // Use the determined route
        routes: {
          Uploadscreen.id: (context) => Uploadscreen(),
          Home.id: (context) => Home(),
          Cart.id: (context) => Cart(),
          Favorate.id: (context) => Favorate(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          // You might need to add a route for signing out that leads to the WelcomeScreen
        },
      ),
    );
  }
}
