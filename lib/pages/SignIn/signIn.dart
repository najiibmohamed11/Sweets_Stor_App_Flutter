import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/Login/login.dart';
import 'package:sweet_app/pages/components/athanticationbuttons.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? name;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Text(
                  'Register account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    sepratorline(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    sepratorline(),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                // Google or Facebook authentication

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    authanticationcontainer(
                      authanticationmethodeimage: "images/google.png",
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    authanticationcontainer(
                      authanticationmethodeimage: "images/facebook.png",
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Sig in",
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                athenticationbuttons(
                  name: "register",
                  color: Colors.black,
                  onTap: () async {
                    if (email == null || password == null) {
                      // Show some error message to the user
                      print("Email and password must be filled.");
                      return;
                    }

                    User? signedUser = await FirebaseAuthantication()
                        .signin(email!, password!);
                    if (signedUser == null) {
                      // Handle the case where the sign in failed
                      print("Sign in failed.");
                      return;
                    }
                    print(signedUser);

                    // If sign in was successful, navigate to the Home page
                    Navigator.pushNamed(context, Home.id);
                  },
                  textcolor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///facebook and google

class authanticationcontainer extends StatelessWidget {
  authanticationcontainer({super.key, this.authanticationmethodeimage});
  String? authanticationmethodeimage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 217, 225), // #EBE4F5

        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black),
      ),
      child: Image.asset(authanticationmethodeimage!),
    );
  }
}

//lines
class sepratorline extends StatelessWidget {
  const sepratorline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );
  }
}
