import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Methods.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Hello " + user.email!),
          TextButton(
            onPressed: (() => logOut(context)),
            child: Text("LogOut"),
          ),
        ]),
      ),
    );
  }
}
