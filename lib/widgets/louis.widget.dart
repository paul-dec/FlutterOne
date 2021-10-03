import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LouisWidget extends StatefulWidget {
  const LouisWidget({Key? key}) : super(key: key);

  @override
  _LouisWidgetState createState() => _LouisWidgetState();
}

class _LouisWidgetState extends State<LouisWidget> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Louis", style: TextStyle(color: Colors.white),),
    );
  }
}