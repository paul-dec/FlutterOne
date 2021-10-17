import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MySlotMachine extends StatefulWidget {
  const MySlotMachine({Key? key}) : super(key: key);

  @override
  _MySlotMachineState createState() => _MySlotMachineState();
}

class _MySlotMachineState extends State<MySlotMachine> {
  int firstNumber = 0;
  int secondNumber = 0;
  int thirdNumber = 0;
  int myScore = 100;
  int bet = 1;
  String errorMsg = '';
  final myController = TextEditingController();


  @override
  initState() {
    setupVariable();
  }

  Future<void> setupVariable() async {
    final prefs = await SharedPreferences.getInstance();
    final int? counter;
    if (prefs.getInt('counter') != null) {
      counter = prefs.getInt('counter');
    } else {
      prefs.setInt('counter', myScore);
      counter = myScore;
    }
    setState(() {
      myScore = int.parse(counter.toString());
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  var rng = Random();
  static AudioCache player = AudioCache();
  static const jackpotAudioPath = "jackpot.mp3";
  static const winAudioPath = "win.mp3";
  static const spinAudioPath = "spin.mp3";

  Future<void> _spinMachine() async {
    if (myController.text == null || myController.text == "") {
      setState(() {
        errorMsg = 'Please add a bet';
      });
      return;
    }
    setState(() {
      bet = int.parse(myController.text);
    });
    if (myScore < bet) {
      setState(() {
        errorMsg = 'Balance too low, please reduce your bet';
      });
    } else if (bet == 0) {
      setState(() {
        errorMsg = "You can't bet 0 coins";
      });
    } else {
      player.play(spinAudioPath);
      firstNumber = rng.nextInt(10);
      secondNumber = rng.nextInt(10);
      thirdNumber = rng.nextInt(10);
      if(firstNumber == secondNumber && secondNumber == thirdNumber) {
        player.play(jackpotAudioPath);
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          myScore = myScore + bet * 100;
          prefs.setInt('counter', myScore);
          errorMsg = 'Jackpot !!!';
        });
      } else if(firstNumber == secondNumber ||
          secondNumber == thirdNumber ||
          thirdNumber == firstNumber) {
        player.play(winAudioPath);
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          myScore = myScore + bet * 10;
          prefs.setInt('counter', myScore);
          errorMsg = 'You won !';
        });
      } else {
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          myScore = myScore - bet;
          prefs.setInt('counter', myScore);
          errorMsg = 'You loose';
        });
        // you loose
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(firstNumber.toString(), style: const TextStyle(color: Colors.white),),
              Text(secondNumber.toString(), style: const TextStyle(color: Colors.white),),
              Text(thirdNumber.toString(), style: const TextStyle(color: Colors.white),)
            ],
          ),
          // add input button bet
          TextButton(
            onPressed: _spinMachine,
            child: const Text("Spin"),
          ),
          Text(errorMsg, style: const TextStyle(color: Colors.white),),
          Text("My coins: " + myScore.toString(), style: const TextStyle(color: Colors.white),),
          SizedBox(
            height: 60,
            width: 150,
            child:
              TextField(
                controller: myController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bet',
                  labelStyle: TextStyle(
                      color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
          ),
        ]
      )
    );
  }
}