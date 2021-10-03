import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEmojiDictionary extends StatefulWidget {
  const MyEmojiDictionary({Key? key}) : super(key: key);

  @override
  _MyEmojiDictionaryState createState() => _MyEmojiDictionaryState();
}

class _MyEmojiDictionaryState extends State<MyEmojiDictionary> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("😀"),
    );
  }
}