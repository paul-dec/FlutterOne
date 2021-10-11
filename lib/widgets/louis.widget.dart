import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LouisWidget extends StatefulWidget {
  const LouisWidget({Key? key}) : super(key: key);

  @override
  _LouisWidgetState createState() => _LouisWidgetState();
}

class YahtzeeValues {
  int? ones, twos, threes, fours, fives, sixes, threeOfAKind, fourOfAKind, fullHouse, smallStraight, largeStraight, chance, yahtzee;
  int sum = 0, bonus = 0, total = 0;
}

class _LouisWidgetState extends State<LouisWidget> {

  YahtzeeValues values = YahtzeeValues();
  List<int?> dices = [null, null, null, null, null];
  List<bool> keep = [false, false, false, false, false];
  int step = 0;

  void _reset() {
    setState(() {
      step = 0;
      values.ones = null;
      values.twos = null;
      values.threes = null;
      values.fours = null;
      values.fives = null;
      values.sixes = null;
      values.threeOfAKind = null;
      values.fourOfAKind = null;
      values.fullHouse = null;
      values.smallStraight = null;
      values.largeStraight = null;
      values.chance = null;
      values.yahtzee = null;
      values.sum = 0;
      values.bonus = 0;
      values.total = 0;
      dices = [null, null, null, null, null];
      keep = [false, false, false, false, false];
    });
  }

  void _computeSum() {
    int result = 0;
    result += values.ones ?? 0;
    result += values.twos ?? 0;
    result += values.threes ?? 0;
    result += values.fours ?? 0;
    result += values.fives ?? 0;
    result += values.sixes ?? 0;
    setState(() {
      values.sum = result;
      values.bonus = values.sum >= 63 ? 35 : 0;
      values.total = values.sum + values.bonus;
    });
  }

  void _roll() {
    // if (step > 2) {
    //   return;
    // }
    var rand = Random();
    for (int i = 0; i < 5; ++i) {
      if (!keep[i]) {
        setState(() {
          dices[i] = rand.nextInt(6) + 1;
        });
      }
    }
    setState(() {
      step++;
    });
  }

  void _keep(int id) {
    if (dices[id] != null) {
      setState(() {
        keep[id] = !keep[id];
      });
    }
  }

  int _getNumberSum(int number) {
    int result = 0;
    for (int i = 0; i < 5; ++i) {
      if (dices[i] == number) {
        result += number;
      }
    }
    return result;
  }

  int _getNumberCount(int number) {
    int count = 0;
    for (int i = 0; i < 5; ++i) {
      if (dices[i] == number) {
        count++;
      }
    }
    return count;
  }

  void _set(int number) {
    setState(() {
      if (number == 1) {
        values.ones = _getNumberSum(1);
      }
      if (number == 2) {
        values.twos = _getNumberSum(2);
      }
      if (number == 3) {
        values.threes = _getNumberSum(3);
      }
      if (number == 4) {
        values.fours = _getNumberSum(4);
      }
      if (number == 5) {
        values.fives = _getNumberSum(5);
      }
      if (number == 6) {
        values.sixes = _getNumberSum(6);
      }
      dices = [null, null, null, null, null];
      keep = [false, false, false, false, false];
      step = 0;
    });
    _computeSum();
  }

  void _setNumberOfAKind(int number) {
    int count = 0, result = 0;
    for (int i = 1; i <= 6; ++i) {
      int tmp = _getNumberCount(i);
      if (tmp > count) {
        count = tmp;
      }
    }
    if (number != 5 && count >= number) {
      for (int i = 0; i < 5; ++i) {
        result += dices[i] ?? 0;
      }
    }
    setState(() {
      if (number == 3) {
        values.threeOfAKind = result;
      }
      if (number == 4) {
        values.fourOfAKind = result;
      }
      if (number == 5) {
        values.yahtzee = count >= number ? 50 : 0;
      }
      dices = [null, null, null, null, null];
      keep = [false, false, false, false, false];
      step = 0;
    });
    _computeSum();
  }

  void _fullHouse() {
    bool pair = false, three = false;
    for (int i = 1; i <= 6; ++i) {
      int count = _getNumberCount(i);
      if (count == 2) {
        pair = true;
      } else if (count == 3) {
        three = true;
      }
    }
    setState(() {
      values.fullHouse = pair && three ? 25 : 0;
      dices = [null, null, null, null, null];
      keep = [false, false, false, false, false];
      step = 0;
    });
    _computeSum();
  }

  int _getStraight() {
    for (int i = 0; i < 5; ++i) {
      if (dices[i] == null) {
        return 0;
      }
    }
    List<int> sorted = List.from(dices);
    sorted.sort((a, b) => a.compareTo(b));
    int j = 0;
    for (int i = 0; i < 4; ++i) {
      if (sorted[i] + 1 != sorted[i + 1]) {
        if (i == 0 || i == 3) {
          ++j;
        } else {
          return 0;
        }
      }
    }
    return j != 0 ? 2 : 1;
  }

  void _straight(bool isSmall) {
    setState(() {
      if (isSmall) {
        values.smallStraight = _getStraight() >= 1 ? 30 : 0;
      } else {
        values.largeStraight = _getStraight() == 1 ? 40 : 0;
      }
      dices = [null, null, null, null, null];
      keep = [false, false, false, false, false];
      step = 0;
    });
    _computeSum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          children: [
            Column(children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.6,
                child: Column(children: [
                  TextButton(onPressed: _reset, child: const Text('Reset')),
                  TextButton(onPressed: _roll, child: const Text('Roll dices')),
                  TextButton(
                      onPressed: () => { setState((){ _keep(0); }) },
                      child: Text('Dice 1: ' + (dices[0] == null ? '' : dices[0].toString())),
                      style: TextButton.styleFrom(primary: keep[0] ? Colors.amber : Colors.blue)
                  ),
                  TextButton(
                      onPressed: () => { setState((){ _keep(1); }) },
                      child: Text('Dice 2: ' + (dices[1] == null ? '' : dices[1].toString())),
                      style: TextButton.styleFrom(primary: keep[1] ? Colors.amber : Colors.blue)
                  ),
                  TextButton(
                      onPressed: () => { setState((){ _keep(2); }) },
                      child: Text('Dice 3: ' + (dices[2] == null ? '' : dices[2].toString())),
                      style: TextButton.styleFrom(primary: keep[2] ? Colors.amber : Colors.blue)
                  ),
                  TextButton(
                      onPressed: () => { setState((){ _keep(3); }) },
                      child: Text('Dice 4: ' + (dices[3] == null ? '' : dices[3].toString())),
                      style: TextButton.styleFrom(primary: keep[3] ? Colors.amber : Colors.blue)
                  ),
                  TextButton(
                      onPressed: () => { setState((){ _keep(4); }) },
                      child: Text('Dice 5: ' + (dices[4] == null ? '' : dices[4].toString())),
                      style: TextButton.styleFrom(primary: keep[4] ? Colors.amber : Colors.blue)
                  ),
                ],),
              )
            ]),
            Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width / 2,
                child: Table(
                  border: TableBorder.all(color: Colors.white),
                  children: <TableRow>[
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.ones == null ? () => { _set(1) } : null,
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
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.twos == null ? () => { _set(2) } : null,
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
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.threes == null ? () => { _set(3) } : null,
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
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.fours == null ? () => { _set(4) } : null,
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
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.fives == null ? () => { _set(5) } : null,
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
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.sixes == null ? () => { _set(6) } : null,
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
                          const SizedBox(height: 30, child: TextButton(
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
                          const SizedBox(height: 30, child: TextButton(
                            onPressed: null,
                            child: Text("Bonus", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.bonus.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.threeOfAKind == null ? () => { _setNumberOfAKind(3) } : null,
                            child: const Text("Three of a kind", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.threeOfAKind == null ? '' : values.threeOfAKind.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.fourOfAKind == null ? () => { _setNumberOfAKind(4) } : null,
                            child: const Text("Four of a kind", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.fourOfAKind == null ? '' : values.fourOfAKind.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.fullHouse == null ? () => { _fullHouse() } : null,
                            child: const Text("Full house", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.fullHouse == null ? '' : values.fullHouse.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.smallStraight == null ? () => { _straight(true) } : null,
                            child: const Text("Small straight", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.smallStraight == null ? '' : values.smallStraight.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.largeStraight == null ? () => { _straight(false) } : null,
                            child: const Text("Large straight", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.largeStraight == null ? '' : values.largeStraight.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 30, child: TextButton(
                            onPressed: values.yahtzee == null ? () => { _setNumberOfAKind(5) } : null,
                            child: const Text("Yahtzee", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.yahtzee == null ? '' : values.yahtzee.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                    TableRow(children: <TableCell>[
                      TableCell(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const SizedBox(height: 30, child: TextButton(
                            onPressed: null,
                            child: Text("Total", style: TextStyle(color: Colors.white)),
                          )),
                          Text(values.total.toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      )),
                    ],),
                  ],
                ),
              ),
            ])
          ],
        ),
    );
  }
}