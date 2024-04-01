import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/SignIn/signIn.dart';
import 'package:sweet_app/pages/components/athanticationbuttons.dart';
import 'package:sweet_app/pages/components/googoleauthcontainer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;
  final _firstore = FirebaseFirestore.instance;
  FirebaseAuthantication allathantications = FirebaseAuthantication();

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
                  'Let\'s sign in',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'welcome back \nyou\'ve been missed!',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                    letterSpacing: 1.5,
                    fontSize: 21.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
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
                      onTap: () async {
                        UserCredential? usersdata =
                            await allathantications.signInWithGoogle();
                        if (usersdata != null && usersdata.user != null) {
                          try {
                            await _firstore.collection("users").add({
                              "Email": usersdata.user!
                                  .email, // Safe to use ! since we checked for null
                              "Name": usersdata.user!
                                  .displayName ,
                              "Role": "user"
                            });
                            // If sign in and data addition was successful, navigate to the Home page
                            Navigator.pushNamed(context, Home.id);
                          } catch (e) {
                            print("Error adding user data to Firestore: $e");
                            // Handle error adding user data to Firestore
                          }
                        } else {
                          print(
                              "Google sign-in failed or was cancelled by the user.");
                          // Handle the case where Google sign-in failed or was cancelled
                        }
                      },
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
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                athenticationbuttons(
                  name: "Login",
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
