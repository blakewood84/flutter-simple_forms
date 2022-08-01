import 'package:flutter/material.dart';
import 'package:simple_forms/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Forms',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}
