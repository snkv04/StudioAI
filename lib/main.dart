import 'package:flutter/material.dart';
import "package:studioai/homescreen.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF323232)),
      home: HomeScreen(),
    );
  }
}
