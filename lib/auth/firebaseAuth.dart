import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthantication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //creat user
  Future<User?> register(String email, String password) async {
    try {
      UserCredential newuser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newuser.user;
    } catch (e) {
      print(e);
    }
  }

  //sign in

  Future<User?> signin(String email, String password) async {
    try {
      UserCredential authrade_user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authrade_user.user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //sign in with google

    Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } else {
      return null;
    }
  }

  //facebook authantication






  //rule of the user

  Future<String> getCurrentUserRoleByEmail() async {
    String role = 'user';
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.email != null) {
        // Assuming your documents are keyed by email
        final querySnapshot = await _firestore
            .collection('users')
            .where('Email', isEqualTo: currentUser.email)
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty &&
            querySnapshot.docs.first.data().containsKey('Role')) {
          role = querySnapshot.docs.first.data()['Role'];
        }
      }
    } catch (e) {
      print("Error getting user role: $e");
    }
    print("$role this is role of this user ");
    return role;
  }
}
