import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutchat/Authenticate/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String errorMessage = '';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account Created Succesful");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } on FirebaseAuthException catch (error) {
    Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Successful");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } on FirebaseAuthException catch (error) {
    Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": "Offline",
    });
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future SendResetPasswordFunction(String email) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    final userEmail = await _auth.sendPasswordResetEmail(email: email);
    print("Reset password sent");
  } catch (e) {
    print("error");
  }
}
