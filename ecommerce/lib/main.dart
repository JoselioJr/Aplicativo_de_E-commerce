import 'package:flutter/material.dart';
import 'package:ecommerce/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 236, 232, 229),
      ),
    );
  }
}