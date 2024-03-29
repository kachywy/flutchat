import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutchat/LoginScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDmcz1XeKs2Ym3OmT8s4TkqFUb23GcyWCw",
          appId: "1:712544769551:android:ed5d0e4a1587a4c112357a",
          messagingSenderId: "712544769551",
          projectId: "flutterists-3e57f"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
