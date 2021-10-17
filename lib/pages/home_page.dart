import 'package:flutter/material.dart';
import 'package:flutter_one/widgets/blackjack.dart';
import 'package:flutter_one/widgets/louis.widget.dart';
import 'package:flutter_one/widgets/slotmachine.dart';
import 'package:flutter_one/widgets/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MyBlackjack(),
    LouisWidget(),
    MySlotMachine(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter One'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.casino_outlined),
            label: 'Blackjack',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Yahtzee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_7_outlined),
            label: 'Slot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Tao'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}