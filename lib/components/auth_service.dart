import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:wisewave/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //signin with email and password and user details to firestore
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userData = {
          'name': user.displayName,
          'provider': 'google',
          'photoUrl': user.photoURL,
          'email': user.email,
        };

        await _db.collection('users').doc(user.uid).set(userData, SetOptions(merge: true));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(uid: user.uid),
          ),
        );
      }

      return userCredential;

    } catch (e) {
      print('Error occurred using Google Sign-In: $e');
      return null;
    }
  }
}