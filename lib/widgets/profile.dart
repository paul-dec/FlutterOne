import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  File? imageFile;

  Future _openGallery(BuildContext context) async {
    try {
      final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture == null) return;

      final pictureFile = await saveImage(picture.path);
      setState(() => imageFile = pictureFile);
    } on PlatformException catch(e) {
      // print('Fail to pick image: $e');
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

      final pictureFile = File(picture.path);
      setState(() => imageFile = pictureFile);
    } on PlatformException catch(e) {
      // print('Fail to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: const Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: const Text("Camera"),
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
          const SizedBox(height: 50,),
          Container(
            child: imageFile != null ? ClipOval(child: Image.file(imageFile!, width: 200, height: 200, fit: BoxFit.cover)) : Image.asset("assets/user.png", fit: BoxFit.cover,width: 200, height: 200, color: Colors.white,),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            _showChoiceDialog(context);
          }, child: const Text("Select Image"),),
          const SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 15),
              Text("Gold Coins", style: TextStyle(color: Colors.white),),
            ],
          ),
        ],
      ),
    );
  }
}