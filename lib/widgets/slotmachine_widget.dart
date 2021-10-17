import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_one/classes/slotmachine_data.dart';

class SlotMachineWidget extends StatelessWidget {

  final SlotMachineData slotMachineData;
  final VoidCallback spinMachine;
  final TextEditingController myController;

  const SlotMachineWidget({Key? key, required this.slotMachineData, required this.spinMachine, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(slotMachineData.firstNumber.toString(), style: const TextStyle(color: Colors.white),),
                  Text(slotMachineData.secondNumber.toString(), style: const TextStyle(color: Colors.white),),
                  Text(slotMachineData.thirdNumber.toString(), style: const TextStyle(color: Colors.white),)
                ],
              ),
              // add input button bet
              TextButton(
                onPressed: spinMachine,
                child: const Text("Spin"),
              ),
              Text(slotMachineData.errorMsg, style: const TextStyle(color: Colors.white),),
              Text("My coins: " + slotMachineData.myScore.toString(), style: const TextStyle(color: Colors.white),),
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