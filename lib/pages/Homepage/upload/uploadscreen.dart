import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweet_app/navpar/navpar.dart';

class Uploadscreen extends StatefulWidget {
  const Uploadscreen({super.key});
  static String id = "upload screen";

  @override
  State<Uploadscreen> createState() => _UploadscreenState();
}

class _UploadscreenState extends State<Uploadscreen> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  String? selectedCategory; // Variable to hold the selected category
  File? imageFile;
  int? price;
  String? sweetname;

  final List<String> categories = [
    'chocolate',
    'dunts',
    'candy',
    'cake',
  ]; // Example categories

  Future<void> uploadImage() async {
    if (imageFile == null || selectedCategory == null) {
      print("No image selected or category not specified.");
      return;
    }
    try {
      // Create a unique file name for the image
      String fileName = "images/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Upload image to Firebase Storage
      firebase_storage.TaskSnapshot snapshot =
          await storage.ref(fileName).putFile(imageFile!);

      // Get the URL of the uploaded image
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Get the name and price from your input fields (assuming you have controllers for them)
      // Replace with your actual input field data

      // Store the data in Firestore under the selected category
      await FirebaseFirestore.instance.collection(selectedCategory!).add({
        'name': sweetname,
        'price': price,
        'imagepath': imageUrl,
      });

      print("Upload successful");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> pickImage(ImageSource source) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 217, 225), // #D8D9E1

      appBar: AppBar(
        backgroundColor: Color(0xFFF9CBDF), // #F9CBDF
      ),
      drawer: NavPar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9CBDF), // #F9CBDF
                Color.fromARGB(255, 216, 217, 225), // #D8D9E1
              ],
              stops: [0.1, 0.6],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => pickImage(ImageSource.camera),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.upload),
                  ),
                ),
                SizedBox(height: 80.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      sweetname = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Sweet name",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      price = int.tryParse(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Price",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Select a category',
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  minWidth: 300,
                  color: Color(0xFFF9CBDF), // #F9CBDF

                  onPressed: () async {
                    await uploadImage();
                  },
                  child: Text(
                    "upload",
                    style: TextStyle(fontSize: 20.0, color: Colors.black45),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
