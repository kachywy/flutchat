import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutchat/Authenticate/LoginScreen.dart';
import 'package:flutter/material.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password));

    if (userCredential != null) {
      print("account created");

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "Unavailable",
      });
    } else {
      print("account not created");
    }
    return userCredential.user;
  }  catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Successful");
    // _firestore
    //     .collection('users')
    //     .doc(_auth.currentUser!.uid)
    //     .get()
    //     .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  } catch (e) {
    print(e);
  }
}
