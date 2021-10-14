import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TaoWidget extends StatefulWidget {
  const TaoWidget({Key? key}) : super(key: key);

  @override
  _TaoWidgetState createState() => _TaoWidgetState();
}

void _Statistics () {
  return;
}

void rule_tips() {
  return;
}

class _TaoWidgetState extends State<TaoWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 30,),
              Text("Profile", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700),),
              Expanded(child: Container()),
              Icon(Icons.home, size: 40, color: Colors.white,),
              SizedBox(width: 30,)
            ],
          ),
          SizedBox(height: 50,),
          Container(
            color: Colors.blue,
            width: 300,
            height: 300,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(150),
            // ),
            child: Image(image: AssetImage("assets/user.png")
            ),
          ),
          SizedBox(height: 70,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gold Coins", style: TextStyle(color: Colors.white),),
              SizedBox(width: 50),
              TextButton(
                onPressed: _Statistics,
                child: const Text("Statistics"),
              ),
              SizedBox(width: 50),
              TextButton(
                onPressed: rule_tips,
                child: const Text("Rules and Tips"),
              ),
            ],
          )
        ],
      ),
    );
  }
}