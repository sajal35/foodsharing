import 'package:flutter/material.dart';
import 'package:food/pages/login.dart';

// String server = "http://192.168.254.13:8080/";
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Meals',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: Login(),
    );
  }
}