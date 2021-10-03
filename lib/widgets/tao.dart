import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaoWidget extends StatefulWidget {
  const TaoWidget({Key? key}) : super(key: key);

  @override
  _TaoWidgetState createState() => _TaoWidgetState();
}

class _TaoWidgetState extends State<TaoWidget> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Tao", style: TextStyle(color: Colors.white),),
    );
  }
}