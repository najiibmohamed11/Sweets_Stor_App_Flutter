import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_app/firebase_options.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/cart/cart%20model/cartmodel.dart';
import 'package:sweet_app/pages/cart/cart.dart';
import 'package:sweet_app/pages/favorate/favorate.dart';
import 'package:sweet_app/pages/upload/uploadscreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => cartopration())],
      child: MaterialApp(
        initialRoute: Home.id,
        routes: {
          Uploadscreen.id: (context) => Uploadscreen(),
          Home.id: (context) => Home(),
          Cart.id: (context) => Cart(),
          Favorate.id: (context) => Favorate()
        },
      ),
    );
  }
}
