import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {

  final File? imageFile;
  final int myScore;
  final Function showChoiceDialog;
  final BuildContext context;

  const ProfileWidget({Key? key, required this.imageFile, required this.myScore, required this.showChoiceDialog, required this.context}) : super(key: key);

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
            showChoiceDialog(context);
          }, child: const Text("Select Image"),),
          const SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gold Coins: " + myScore.toString(), style: const TextStyle(color: Colors.white),),
            ],
          ),
        ],
      ),
    );
  }
}