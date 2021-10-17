import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one/classes/yahtzee_data.dart';

class YahtzeeWidget extends StatefulWidget {

  final YahtzeeValues values;
  List<int?> dices;
  List<bool> keep;
  int step;
  final VoidCallback reset;
  final VoidCallback roll;
  final Function set;
  final Function computeSum;
  final Function keepFunc;
  final Function getNumberSum;
  final Function getNumberCount;
  final Function setNumberOfAKind;
  final Function fullHouse;
  final Function getStraight;
  final Function straight;

  YahtzeeWidget({
    Key? key,
    required this.values,
    required this.dices,
    required this.keep,
    required this.step,
    required this.reset,
    required this.roll,
    required this.set,
    required this.computeSum,
    required this.keepFunc,
    required this.getNumberSum,
    required this.getNumberCount,
    required this.setNumberOfAKind,
    required this.fullHouse,
    required this.getStraight,
    required this.straight
  }) : super(key: key);

  @override
  State<YahtzeeWidget> createState() => _YahtzeeWidgetState();
}

class _YahtzeeWidgetState extends State<YahtzeeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.6,
            child: Column(
              children: [
                TextButton(onPressed: widget.reset, child: const Text('Reset')),
                TextButton(onPressed: widget.roll, child: const Text('Roll dices')),
                _widgetDice(0, widget.keepFunc, widget.dices[0], widget.keep[0]),
                _widgetDice(1, widget.keepFunc, widget.dices[1], widget.keep[1]),
                _widgetDice(2, widget.keepFunc, widget.dices[2], widget.keep[2]),
                _widgetDice(3, widget.keepFunc, widget.dices[3], widget.keep[3]),
                _widgetDice(4, widget.keepFunc, widget.dices[4], widget.keep[4]),
              ],
            ),
          ),
          Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width / 2,
              child: Table(
                border: TableBorder.all(color: Colors.white),
                children: <TableRow>[
                  _tableRow("Ones", widget.values.ones, widget.values.ones == null ? () => { widget.set(1) } : null),
                  _tableRow("Twos", widget.values.twos, widget.values.twos == null ? () => { widget.set(2) } : null),
                  _tableRow("Threes", widget.values.threes, widget.values.threes == null ? () => { widget.set(3) } : null),
                  _tableRow("Fours", widget.values.fours, widget.values.fours == null ? () => { widget.set(4) } : null),
                  _tableRow("Fives", widget.values.fives, widget.values.fives == null ? () => { widget.set(5) } : null),
                  _tableRow("Sixes", widget.values.sixes, widget.values.sixes == null ? () => { widget.set(6) } : null),
                  _tableRow("Sum", widget.values.sum, null),
                  _tableRow("Bonus", widget.values.bonus, null),
                  _tableRow("Three of a kind", widget.values.threeOfAKind, widget.values.threeOfAKind == null ? () => { widget.setNumberOfAKind(3) } : null),
                  _tableRow("Four of a kind", widget.values.fourOfAKind, widget.values.fourOfAKind == null ? () => { widget.setNumberOfAKind(4) } : null),
                  _tableRow("Full house", widget.values.fullHouse, widget.values.fullHouse == null ? () => { widget.fullHouse() } : null),
                  _tableRow("Small straight", widget.values.smallStraight, widget.values.smallStraight == null ? () => { widget.straight(true) } : null),
                  _tableRow("Large straight", widget.values.largeStraight, widget.values.largeStraight == null ? () => { widget.straight(false) } : null),
                  _tableRow("Yahtzee", widget.values.yahtzee, widget.values.yahtzee == null ? () => { widget.setNumberOfAKind(5) } : null),
                  _tableRow("Total", widget.values.total, null),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}

Widget _widgetDice(int number, Function keepFunc, int? dice, bool keep) {
  return TextButton(
      onPressed: () => { keepFunc(number) },
      child: Text('Dice 1: ' + (dice == null ? '' : dice.toString())),
      style: TextButton.styleFrom(primary: keep ? Colors.amber : Colors.blue)
  );
}

TableRow _tableRow(String text, int? value, dynamic _func) {
  return TableRow(
    children: <TableCell>[
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: _func,
                child: Text(text, style: const TextStyle(color: Colors.white)),
              )
            ),
            Text(value == null ? "" : value.toString(), style: const TextStyle(color: Colors.white)),
          ],
        )
      ),
    ],
  );
}