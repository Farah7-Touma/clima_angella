import 'package:clima_13_angella/screens/loading_screen.dart';
import 'package:clima_13_angella/screens/location_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  LoadingScreen(),
    );
  }
}
