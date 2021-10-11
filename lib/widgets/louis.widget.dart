import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LouisWidget extends StatefulWidget {
  const LouisWidget({Key? key}) : super(key: key);

  @override
  _LouisWidgetState createState() => _LouisWidgetState();
}

class YahtzeeValues {
  int? ones, twos, threes, fours, fives, sixes, threeOfAKind, fourOfAKind, fullHouse, smallStraight, largeStraight, chance, yahtzee;
  int sum = 0, bonus = 0;
}

class _LouisWidgetState extends State<LouisWidget> {

  YahtzeeValues values = YahtzeeValues();

  void _computeSum(YahtzeeValues values) {
    int result = 0;
    result += values.ones ?? 0;
    result += values.twos ?? 0;
    result += values.threes ?? 0;
    result += values.fours ?? 0;
    result += values.fives ?? 0;
    result += values.sixes ?? 0;
    values.sum = result;
    values.bonus = values.sum >= 63 ? 35 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child: Table(
              border: TableBorder.all(color: Colors.white),
              children: <TableRow>[
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.ones == null ? () => {setState((){values.ones = 0;})} : null,
                        child: const Text("Ones", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.ones == null ? '' : values.ones.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.twos == null ? () => {setState((){values.twos = 0;})} : null,
                        child: const Text("Twos", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.twos == null ? '' : values.twos.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.threes == null ? () => {setState((){values.threes = 0;})} : null,
                        child: const Text("Threes", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.threes == null ? '' : values.threes.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.fours == null ? () => {setState((){values.fours = 0;})} : null,
                        child: const Text("Fours", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.fours == null ? '' : values.fours.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.fives == null ? () => {setState((){values.fives = 0;})} : null,
                        child: const Text("Fives", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.fives == null ? '' : values.fives.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 32, child: TextButton(
                        onPressed: values.sixes == null ? () => {setState((){values.sixes = 0;})} : null,
                        child: const Text("Sixes", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.sixes == null ? '' : values.sixes.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const SizedBox(height: 32, child: TextButton(
                        onPressed: null,
                        child: Text("Sum", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.sum.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
                TableRow(children: <TableCell>[
                  TableCell(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const SizedBox(height: 32, child: TextButton(
                        onPressed: null,
                        child: Text("Bonus", style: TextStyle(color: Colors.white)),
                      )),
                      Text(values.bonus.toString(), style: const TextStyle(color: Colors.white)),
                    ],
                  )),
                ],),
              ],
            ),
          ),
        ])
    );
  }
}