import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_one/classes/slotmachine_data.dart';
import 'package:flutter_one/widgets/slotmachine_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SlotMachineComponent extends StatefulWidget {
  const SlotMachineComponent({Key? key}) : super(key: key);

  @override
  _SlotMachineComponentState createState() => _SlotMachineComponentState();
}

class _SlotMachineComponentState extends State<SlotMachineComponent> {
  SlotMachineData slotMachineData = SlotMachineData();
  final myController = TextEditingController();

  @override
  initState() {
    super.initState();
    setupVariable();
  }

  Future<void> setupVariable() async {
    final prefs = await SharedPreferences.getInstance();
    final int? counter;
    if (prefs.getInt('counter') != null) {
      counter = prefs.getInt('counter');
    } else {
      prefs.setInt('counter', slotMachineData.myScore);
      counter = slotMachineData.myScore;
    }
    setState(() {
      slotMachineData.myScore = int.parse(counter.toString());
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
        slotMachineData.errorMsg = 'Please add a bet';
      });
      return;
    }
    setState(() {
      slotMachineData.bet = int.parse(myController.text);
    });
    if (slotMachineData.myScore < slotMachineData.bet) {
      setState(() {
        slotMachineData.errorMsg = 'Balance too low, please reduce your bet';
      });
    } else if (slotMachineData.bet == 0) {
      setState(() {
        slotMachineData.errorMsg = "You can't bet 0 coins";
      });
    } else {
      player.play(spinAudioPath);
      slotMachineData.firstNumber = rng.nextInt(10);
      slotMachineData.secondNumber = rng.nextInt(10);
      slotMachineData.thirdNumber = rng.nextInt(10);
      if(slotMachineData.firstNumber == slotMachineData.secondNumber && slotMachineData.secondNumber == slotMachineData.thirdNumber) {
        player.play(jackpotAudioPath);
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          slotMachineData.myScore = slotMachineData.myScore + slotMachineData.bet * 100;
          prefs.setInt('counter', slotMachineData.myScore);
          slotMachineData.errorMsg = 'Jackpot !!!';
        });
      } else if(slotMachineData.firstNumber == slotMachineData.secondNumber ||
          slotMachineData.secondNumber == slotMachineData.thirdNumber ||
          slotMachineData.thirdNumber == slotMachineData.firstNumber) {
        player.play(winAudioPath);
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          slotMachineData.myScore = slotMachineData.myScore + slotMachineData.bet * 10;
          prefs.setInt('counter', slotMachineData.myScore);
          slotMachineData.errorMsg = 'You won !';
        });
      } else {
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          slotMachineData.myScore = slotMachineData.myScore - slotMachineData.bet;
          prefs.setInt('counter', slotMachineData.myScore);
          slotMachineData.errorMsg = 'You loose';
        });
        // you loose
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlotMachineWidget(slotMachineData: slotMachineData,
        spinMachine: _spinMachine,
        myController: myController);
  }
}