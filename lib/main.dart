import 'package:flutchat/Authenticate/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDmcz1XeKs2Ym3OmT8s4TkqFUb23GcyWCw",
          appId: "1:712544769551:android:ed5d0e4a1587a4c112357a",
          messagingSenderId: "712544769551",
          projectId: "flutterists-3e57f",
          storageBucket: "gs://flutterists-3e57f.appspot.com"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Authenticate());
  }
}
