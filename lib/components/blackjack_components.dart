import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_one/classes/blackjack_data.dart';
import 'package:flutter_one/widgets/blackjack_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlackJackComponent extends StatefulWidget {
  const BlackJackComponent({Key? key}) : super(key: key);

  @override
  _BlackJackComponentState createState() => _BlackJackComponentState();
}

class _BlackJackComponentState extends State<BlackJackComponent> {

  BlackJackData blackJackData = BlackJackData();
  late SharedPreferences prefs;

  List<String> cards = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "V", "Q", "K"];
  List<int> cardsValue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];

  var rng = Random();
  static AudioCache player = AudioCache();
  static const alarmAudioPath = "card_slide.mp3";

  void _initGame() async {
    prefs = await SharedPreferences.getInstance();
    final int? counter;
    if (prefs.getInt('counter') != null) {
      counter = prefs.getInt('counter');
    } else {
      prefs.setInt('counter', blackJackData.myMoney);
      counter = blackJackData.myMoney;
    }
    setState(() {
      blackJackData.myMoney = int.parse(counter.toString());
    });

    _drawCard(false);
    int randomValue = rng.nextInt(13);

    blackJackData.iaScore += cardsValue[randomValue];
    setState(() {
      blackJackData.iaCards += " | " + cards[randomValue] + " | ";
    });
    _drawCard(false);
    if ((blackJackData.myCards.contains("K") || blackJackData.myCards.contains("Q") || blackJackData.myCards.contains("V")) && blackJackData.myCards.contains("| 1 |")) {
      blackJackData.result = "You got a blackjack";
      blackJackData.myMoney += 15;
      prefs.setInt('counter', blackJackData.myMoney);
    }
  }

  void _drawCard(bool playSound) {
    if (blackJackData.result != "") {
      return;
    }

    if (playSound == true) {
      player.play(alarmAudioPath);
    }
    int randomValue = rng.nextInt(13);

    blackJackData.myScore += cardsValue[randomValue];
    setState(() {
      blackJackData.myCards += " | " + cards[randomValue] + " | ";
    });

    if (blackJackData.myScore > 21) {
      blackJackData.result = "You lose";
      blackJackData.myMoney -= 10;
      prefs.setInt('counter', blackJackData.myMoney);
    }
  }

  void _stopDraw() {
    if (blackJackData.result != "") {
      return;
    }
    player.play(alarmAudioPath);
    while(blackJackData.iaScore < 17 && blackJackData.result == "") {
      int randomValue = rng.nextInt(13);

      blackJackData.iaScore += cardsValue[randomValue];
      setState(() {
        blackJackData.iaCards += " | " + cards[randomValue] + " | ";
      });

      if (blackJackData.iaScore > 21) {
        blackJackData.result = "You win";
        blackJackData.myMoney += 10;
        prefs.setInt('counter', blackJackData.myMoney);
        return;
      }
    }
    if (blackJackData.iaScore > blackJackData.myScore) {
      blackJackData.result = "You lose";
      blackJackData.myMoney -= 10;
      prefs.setInt('counter', blackJackData.myMoney);
    }
    if (blackJackData.iaScore == blackJackData.myScore) {
      blackJackData.result = "Draw";
    }
    if (blackJackData.iaScore < blackJackData.myScore) {
      blackJackData.result = "You win";
      blackJackData.myMoney += 10;
      prefs.setInt('counter', blackJackData.myMoney);
    }
  }

  void _resetGame() {
    blackJackData.myScore = 0;
    blackJackData.iaScore = 0;
    setState(() {
      blackJackData.myCards = "";
      blackJackData.iaCards = "";
      blackJackData.result = "";
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
    return BlackJackWidget(blackJackData: blackJackData, drawCard: _drawCard, stopDraw: _stopDraw, resetGame: _resetGame);
  }
}