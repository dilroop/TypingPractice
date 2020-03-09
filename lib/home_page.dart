import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animated_background.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = new TextEditingController();
  TextEditingController _possibleController = new TextEditingController();
  final allChars = "',.pyfgcrl/=\\aoeuidhtns-zvwmbxkjq;\"<>PYFGCRL_SNTHDIUEOA:QJKXBMWVZA";
  var possible;
  var current, correct = 0, incorrect = 0;
  var typed = "", showCharacterOverride = false;
  var gravity = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    possible = allChars;
    _possibleController.text = possible;
    getNewRandomCharacter();
  }

  getNewRandomCharacter() {
    if (possible.length > 2) {
      var random = new Random();
      var index = random.nextInt(possible.length);
      if (current == possible.codeUnitAt(index)) {
        getNewRandomCharacter();
      } else {
        setState(() {
          current = possible.codeUnitAt(index);
        });
      }
    } else {
      setState(() {
        possible = allChars;
      });
      getNewRandomCharacter();
    }
  }

  _onPossibleChanged(String char) {
    if (char.length > 0) {
      setState(() {
        possible = char;
      });
      _possibleController.selection = TextSelection.fromPosition(
        TextPosition(offset: _possibleController.text.length),
      );
    } else {
      setState(() {
        possible = allChars;
      });
    }
  }

  _onChanged(String char) {
    setState(() {
      typed = char;
    });

    if (char.codeUnitAt(char.length - 1) == current) {
      getNewRandomCharacter();
      setState(() {
        correct++;
      });
    } else {
      setState(() {
        incorrect++;
        gravity = Alignment.topCenter;
      });
    }
    _clearText(_textController);
  }

  _clearText(controller) {
    controller.text = "";
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    setState(() {});
  }

  _resetAlignment() {
    setState(() {
      gravity = Alignment.center;
    });
  }

  @override
  Widget build(BuildContext context) {
    var toBeTyped = String.fromCharCode(current);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Corret: $correct',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: typed.length > 0,
                    child: Text(
                      'You Typed: $typed',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Incorret: $incorrect',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: IconButton(
                  icon: Icon(Icons.format_list_bulleted),
                  onPressed: () {
                    setState(() {
                      showCharacterOverride = !showCharacterOverride;
                    });
                  },
                ),
              ),
              Expanded(
                  child: Visibility(
                visible: showCharacterOverride,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter practice charaters...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  maxLines: 1,
                  controller: _possibleController,
                  onSubmitted: _onPossibleChanged,
                ),
              )),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    getNewRandomCharacter();
                    setState(() {
                      correct = 0;
                      incorrect = 0;
                      typed = "";
                    });
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      child: Text('Type The Charater'),
                      padding: EdgeInsets.only(bottom: 20.0),
                    ),
                    AnimatedBackground(
                      BoxConstraints.expand(height: 90.0, width: 180.0),
                      AnimatedAlign(
                        duration: Duration(milliseconds: 50),
                        alignment: gravity,
                        onEnd: _resetAlignment,
                        child: Text(
                          '$toBeTyped',
                          style: TextStyle(fontSize: 32.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Type the charater',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  counter: Container(),
                  fillColor: Colors.grey[200],
                  filled: true),
              showCursor: true,
              maxLength: 1,
              onChanged: _onChanged,
              controller: _textController,
              autofocus: true,
            ),
          )
        ],
      ),
    );
  }
}
