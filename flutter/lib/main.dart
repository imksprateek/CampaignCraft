import 'package:camoa/Screens/screen2.dart';
import 'package:camoa/Screens/screen3.dart';
import 'package:flutter/material.dart';

import 'Screens/screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen1(),
    );
  }
}
