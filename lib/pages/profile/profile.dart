import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late TextEditingController _controller;
  File? imageFile;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    _controller =
        TextEditingController(text: currentUser?.displayName! ?? "jasnkj");
    // TODO: implement initState
    super.initState();
  }

  //upload the image to the firebase
  Future<void> uploadimage() async {
    if (imageFile == null) return;

    try {
      // Create a unique file name for the image
      String fileName = "images/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Upload image to Firebase Storage
      firebase_storage.TaskSnapshot snapshot =
          await storage.ref(fileName).putFile(imageFile!);

      // Get the URL of the uploaded image
      String imageUrl = await snapshot.ref.getDownloadURL();
      currentUser?.updatePhotoURL(imageUrl);
      setState(() {
        currentUser!.reload();
      });
    } catch (e) {
      print(e);
    }
  }

  //pick image fromr any where
  Future<void> imagepicker(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final tempImage = File(image.path);
      setState(() {
        imageFile = tempImage;
      });
    } catch (e) {
      print("Failed to pick an image: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: currentUser?.photoURL != null &&
                                    imageFile == null
                                ? ClipOval(
                                    child: Image.network(
                                      currentUser!.photoURL!,
                                      fit: BoxFit.cover,
                                      width: 90.0,
                                      height: 90.0,
                                    ),
                                  )
                                : imageFile != null
                                    ? ClipOval(child: Image.file(imageFile!))
                                    : CircleAvatar(
                                        backgroundColor: Colors.green[300],
                                        child: Text(
                                          currentUser?.displayName!
                                                  .substring(0, 1) ??
                                              "G",
                                          style: TextStyle(
                                              fontSize: 45.0,
                                              color: Colors.white),
                                        ),
                                      )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: IconButton(
                          onPressed: () async {
                            await imagepicker(ImageSource.camera);
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    currentUser?.displayName! ?? "user",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Your Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                    child: SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      await currentUser?.updateDisplayName(_controller.text);
                      await uploadimage();
                      setState(() {
                        currentUser!.reload();
                      });

                      // Button action
                    },
                    child: Text("EDIT"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black), // Background color
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white), // Text color

                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 16)), // Text style
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
