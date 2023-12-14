import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:io';

import 'package:flutter/services.dart';

class GuessTheNumber extends StatefulWidget {
  const GuessTheNumber({super.key});
  
  @override
  State<GuessTheNumber> createState() => _GuessTheNumber();
  
}

class _GuessTheNumber extends State<GuessTheNumber> {

  final _number2Guess = Random().nextInt(99) + 1;
  final _fieldText = TextEditingController();

  var _labelText = "Guess the Number";

  int? _userInput;


  String _compareValues() {
    return (_userInput! == _number2Guess) ? "You got it! Congratulations" :
      (_userInput! > _number2Guess) ? "You're High" : "You're Low";
  }

  void _onLabelValueChanged(value) {
    if (int.tryParse(value) != null) {
      setState(() {
        _userInput = int.parse(value);
      });
    }
  }

  void _clearText() {
    _fieldText.clear();
  }

  Future<void> _waitThenExit() async {
    await Future.delayed(const Duration(seconds: 3));
    //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guess The Number")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_labelText),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: _onLabelValueChanged,
                controller: _fieldText,
              ),
              const SizedBox(height: 12,),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _labelText = (_userInput != null) ? _compareValues() : "Invalid input detected";
                      _clearText();

                      if (_userInput == _number2Guess) {
                        _waitThenExit().then((value) {
                          exit(0);
                        });
                      }
                    });
                  },
                  child: const Text("Guess")
              )
            ],
          ),
        ),
      ),
    );
  }
}