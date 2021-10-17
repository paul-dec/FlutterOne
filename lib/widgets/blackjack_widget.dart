import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one/classes/blackjack_data.dart';

class BlackJackWidget extends StatelessWidget {

  final BlackJackData blackJackData;
  final Function drawCard;
  final VoidCallback stopDraw;
  final VoidCallback resetGame;

  const BlackJackWidget({Key? key, required this.blackJackData, required this.drawCard, required this.stopDraw, required this.resetGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage("assets/blackjack_girl.jpeg")),
          const SizedBox(height: 10),
          Text(blackJackData.result, style: const TextStyle(color: Colors.white),),
          Text("Dealer cards:" + blackJackData.iaCards, style: const TextStyle(color: Colors.white),),
          Text("Your cards:" + blackJackData.myCards, style: const TextStyle(color: Colors.white),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => {drawCard(true)},
                child: const Text("Draw"),
              ),
              TextButton(
                onPressed: stopDraw,
                child: const Text("Stop"),
              ),
              TextButton(
                onPressed: resetGame,
                child: const Text("Reset"),
              ),
            ],
          )
        ],
      ),
    );
  }
}