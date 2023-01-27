import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas_43a87006190362/screens/home_screen.dart';
import 'package:uas_43a87006190362/screens/login.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Flutterku',
      home: HomeScreen(),
    );
  }
}
