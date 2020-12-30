import 'package:flutter/material.dart';
import 'screens/anasayfa.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.white,
      fontFamily: 'Georgia',
    ),
    home: MyApp(),
  ));
}
