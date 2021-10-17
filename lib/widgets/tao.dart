import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

  File? imageFile;

  Future _openGallary(BuildContext context) async {
    try {
      final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture == null) return;

      // final picturefile = File(picture.path);
      final picturefile = await saveImage(picture.path);
      setState(() => this.imageFile = picturefile);
    } on PlatformException catch(e) {
      print('Fail to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future _openCamera(BuildContext context) async {
    try {
      final picture = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picture == null) return;

      final picturefile = File(picture.path);
      setState(() => this.imageFile = picturefile);
    } on PlatformException catch(e) {
      print('Fail to pick image: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            child: imageFile != null ? ClipOval(child: Image.file(imageFile!, width: 200, height: 200, fit: BoxFit.cover)) : Image.asset("assets/user.png", fit: BoxFit.cover,width: 200, height: 200, color: Colors.white,),
          ),
          SizedBox(height: 20,),
          RaisedButton(onPressed: () {
            _showChoiceDialog(context);
            }, child: Text("Select Image"),),
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 15),
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
          ),
        ],
      ),
    );
  }
}