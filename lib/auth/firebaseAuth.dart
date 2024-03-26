import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthantication {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
}
