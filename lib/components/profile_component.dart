import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_one/widgets/profile_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileComponent extends StatefulWidget {
  const ProfileComponent({Key? key}) : super(key: key);

  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  File? imageFile;
  int myScore = 100;

  @override
  initState() {
    setupVariable();
  }

  Future<void> setupVariable() async {
    final prefs = await SharedPreferences.getInstance();
    final int? counter;
    if(prefs.getInt('counter') != null) {
      counter = prefs.getInt('counter');
    } else {
      prefs.setInt('counter', myScore);
      counter = myScore;
    }
    final pictureFile = await _getOldPicture();
    if (pictureFile.existsSync() == true) {
      setState(() {
        imageFile = pictureFile;
      });
    }

    setState(() {
      myScore = int.parse(counter.toString());
    });
  }

  void _openGallery(BuildContext context) async {
    try {
      final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture == null) return;

      File pictureFile = await saveImage(picture.path);
      setState(() {
        imageFile = pictureFile;
      });
    } on PlatformException catch(e) {
      // print('Fail to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  Future<File> _getOldPicture() async {
    final directory = await getApplicationDocumentsDirectory();
    const name = 'ProfilePicture.jpg';
    final image = File('${directory.path}/$name');
    return File(image.path);
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
    return ProfileWidget(imageFile: imageFile, myScore: myScore, showChoiceDialog: _showChoiceDialog, context: context);
  }
}