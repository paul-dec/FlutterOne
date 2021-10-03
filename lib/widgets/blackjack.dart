import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class MyBlackjack extends StatefulWidget {
  const MyBlackjack({Key? key}) : super(key: key);

  @override
  _MyBlackjackState createState() => _MyBlackjackState();
}

class _MyBlackjackState extends State<MyBlackjack> {

  List<String> cards = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "V", "Q", "K"];
  List<int> cardsValue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];

  String iaCards = "";
  String myCards = "";
  String result = "";

  int iaScore = 0;
  int myScore = 0;

  var rng = Random();
  static AudioCache player = AudioCache();
  static const alarmAudioPath = "card_slide.mp3";

  void _initGame() {
    _drawCard(false);
    int randomValue = rng.nextInt(13);

    iaScore += cardsValue[randomValue];
    setState(() {
      iaCards += " | " + cards[randomValue] + " | ";
    });
    _drawCard(false);
    if ((myCards.contains("K") || myCards.contains("Q") || myCards.contains("V")) && myCards.contains("| 1 |")) {
      result = "You got a blackjack";
    }
  }

  void _drawCard(bool playSound) {
    if (result != "") {
      return;
    }

    if (playSound == true) {
      player.play(alarmAudioPath);
    }
    int randomValue = rng.nextInt(13);

    myScore += cardsValue[randomValue];
    setState(() {
      myCards += " | " + cards[randomValue] + " | ";
    });

    if (myScore > 21) {
      result = "You lose";
    }
  }

  void _stopDraw() {
    if (result != "") {
      return;
    }
    player.play(alarmAudioPath);
    while(iaScore < 17 && result == "") {
      int randomValue = rng.nextInt(13);

      iaScore += cardsValue[randomValue];
      setState(() {
        iaCards += " | " + cards[randomValue] + " | ";
      });

      if (iaScore > 21) {
        result = "You win";
        return;
      }
    }
    if (iaScore > myScore) {
      result = "You lose";
    }
    if (iaScore == myScore) {
      result = "Draw";
    }
    if (iaScore < myScore) {
      result = "You win";
    }
  }

  void _resetGame() {
    myScore = 0;
    iaScore = 0;
    setState(() {
      myCards = "";
      iaCards = "";
      result = "";
    });
    _initGame();
  }

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage("assets/blackjack_girl.jpeg")),
          const SizedBox(height: 10),
          Text(result, style: const TextStyle(color: Colors.white),),
          Text("Dealer cards:" + iaCards, style: const TextStyle(color: Colors.white),),
          Text("Your cards:" + myCards, style: const TextStyle(color: Colors.white),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => {_drawCard(true)},
                child: const Text("Draw"),
              ),
              TextButton(
                onPressed: _stopDraw,
                child: const Text("Stop"),
              ),
              TextButton(
                onPressed: _resetGame,
                child: const Text("Reset"),
              ),
            ],
          )
        ],
      ),
    );
  }
}