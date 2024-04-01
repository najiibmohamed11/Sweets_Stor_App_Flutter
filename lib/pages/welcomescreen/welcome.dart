import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_app/pages/Login/login.dart';
import 'package:sweet_app/pages/SignIn/signIn.dart';
import 'package:sweet_app/pages/components/athanticationbuttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String id = "welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9CBDF), // #F9CBDF
                Color.fromARGB(255, 216, 217, 225), // #EBE4F5
              ],
              stops: [0.1, 0.4],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 350,
                  height: 350,
                  child: Image.asset("images/firstapp.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Welcome to Flutter Sweets',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                        fontSize: 35.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Satisfy your cravings with our exquisite selection of treats, meticulously crafted for your enjoyment.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: athenticationbuttons(
                    name: "  Logign",
                    color: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    textcolor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: athenticationbuttons(
                    name: "  Register",
                    color: Color(0xffAFAFAF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    textcolor: Colors.black,
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
