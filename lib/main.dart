import 'package:flutter/material.dart';
import 'package:flutter_one/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GamblingApp",
      theme: ThemeData(
          primaryColor: const Color(0xFF202020),
          scaffoldBackgroundColor: const Color(0xFF171819),
          canvasColor: const Color(0xFF202020), // Drawer
      ),
      home: const MyHomePage(),
    );
  }
}