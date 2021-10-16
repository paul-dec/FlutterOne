import 'dart:io';

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

  late File imageFile;

  _openGallary(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print("No image Selected");
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    var picture = await _picker.pickImage(source: ImageSource.camera);
    this.setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print("No image Selected");
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallary"),
                onTap: () {
                  _openGallary(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: () {
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No image choice");
    } else {
      return Image.file(imageFile, width: 300, height: 300,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          // Container(
          //   color: Colors.blue,
          //   child: Image.asset("assets/user.png", fit: BoxFit.cover,),
          //   width: 300,
          //   height: 300,
          // ),
          SizedBox(height: 10,),
          Row(
            children: [
              // _decideImageView(),
              RaisedButton(onPressed: () {
                _showChoiceDialog(context);
              }, child: Text("Select Image"),)
            ],
          ),
          SizedBox(height: 70,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Gold Coins", style: TextStyle(color: Colors.white),),
              SizedBox(width: 50),
              TextButton(
                onPressed: _Statistics,
                child: Text("Statistics"),
              ),
              SizedBox(width: 50),
              TextButton(
                onPressed: rule_tips,
                child: Text("Rules and Tips"),
              ),
            ],
          )
        ],
      ),
    );
  }
}