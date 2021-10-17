import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one/classes/yahtzee_data.dart';
import 'package:flutter_one/widgets/yahtzee_widget.dart';

class YahtzeeComponent extends StatefulWidget {
  const YahtzeeComponent({Key? key}) : super(key: key);

  @override
  _YahtzeeComponentState createState() => _YahtzeeComponentState();
}

class _YahtzeeComponentState extends State<YahtzeeComponent> {

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
    setState(() {
      if (dices[id] != null) {
        setState(() {
          keep[id] = !keep[id];
        });
      }
    });
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
    return YahtzeeWidget(values: values, dices: dices, keep: keep, step: step, reset: _reset, roll: _roll, set: _set, computeSum: _computeSum, keepFunc: _keep, getNumberSum: _getNumberSum, getNumberCount: _getNumberCount, setNumberOfAKind: _setNumberOfAKind, fullHouse: _fullHouse, getStraight: _getStraight, straight: _straight);
  }
}