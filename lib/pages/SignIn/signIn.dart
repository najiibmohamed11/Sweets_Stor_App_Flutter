import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sweet_app/auth/firebaseAuth.dart';
import 'package:sweet_app/pages/Home/Home.dart';
import 'package:sweet_app/pages/Login/login.dart';
import 'package:sweet_app/pages/components/athanticationbuttons.dart';
import 'package:sweet_app/pages/components/googoleauthcontainer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? name;
  String? password;
  bool _saving = false;
  final _firstore = FirebaseFirestore.instance;
  FirebaseAuthantication allathantications = FirebaseAuthantication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SafeArea(
          child: Container(
            height: double.infinity,
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
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
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
                        onTap: () async {
                          UserCredential? usersdata =
                              await allathantications.signInWithGoogle();
                          if (usersdata != null && usersdata.user != null) {
                            setState(() {
                              _saving = true;
                            });
                            try {
                              await _firstore.collection("users").add({
                                "Email": usersdata.user!
                                    .email, // Safe to use ! since we checked for null
                                "Name": usersdata.user!.displayName,
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
                          setState(() {
                            _saving = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
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
                      setState(() {
                        _saving = true;
                      });
                      if (email == null || password == null || name == null) {
                        // Show some error message to the user
                        print("Email, password, and name must be filled.");
                        return;
                      }

                      User? createUser =
                          await allathantications.register(email!, password!);

                      if (createUser == null) {
                        // Handle the case where the sign in failed
                        print("Sign in failed.");
                        return;
                      }

                      try {
                        await createUser.updateDisplayName(name);
                        await _firstore.collection("users").add({
                          "Email": createUser.email,
                          "Name": name,
                          "Role": "user"
                          // Store the user ID instead of the whole user object
                        });
                        print(createUser);
                        // If sign in was successful, navigate to the Home page
                        Navigator.pushNamed(context, Home.id);
                      } catch (e) {
                        print("Error updating profile: $e");
                        // Handle error updating profile
                      }
                      setState(() {
                        _saving = false;
                      });
                    },
                    textcolor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///facebook and google

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
