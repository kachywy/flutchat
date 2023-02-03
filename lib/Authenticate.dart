import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutchat/HomeScreen.dart';
import 'package:flutchat/LoginScreen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  // const MyWidget({super.key});

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
