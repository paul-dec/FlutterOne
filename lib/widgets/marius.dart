import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MariusWidget extends StatefulWidget {
  const MariusWidget({Key? key}) : super(key: key);

  @override
  _MariusWidgetState createState() => _MariusWidgetState();
}

class _MariusWidgetState extends State<MariusWidget> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Marius", style: TextStyle(color: Colors.white),),
    );
  }
}