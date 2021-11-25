import 'package:flutter/material.dart';
import 'package:funchat/screens/loginScreen.dart';
import 'package:funchat/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> handleLogin() async {
    User user;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    user = authResult.user;

    if (authResult.additionalUserInfo.isNewUser)
      await Database.addUser(user);
  }

  static Future<void> handleLogout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
        builder:(context)=>Login(),
      ), 
      (route) => false
    );
    await _auth.signOut();
    print("logged out");
    
  }
}
