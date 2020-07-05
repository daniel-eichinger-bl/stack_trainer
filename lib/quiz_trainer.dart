import 'package:flutter/material.dart';
import 'package:stack_trainer/QuizWidgets/ButtonRow.dart';
import 'package:stack_trainer/QuizWidgets/MistakeDialog.dart';
import 'dart:async';
import 'constants.dart' as CONST;
import 'QuizWidgets/CardDisplay.dart';

class QuizTrainer extends StatefulWidget {
  static const routeName = '/quiz_trainer';

  @override
  State<StatefulWidget> createState() {
    return _QuizTrainerState();
  }
}

class _QuizTrainerState extends State<QuizTrainer> {
  String _randomCard = '';
  var _positions = [];
  int _chosenPosition = -1;

  void setupRandom() {
    final l = List.generate(51, (i) => i+1);
    l.shuffle();
    final randomPositions = [l[1], l[2], l[3], l[4]];

    setState(() {
      _randomCard = CONST.stack.keys.elementAt(randomPositions[0] - 1);
      randomPositions.shuffle();
      _positions = randomPositions;
    });
  }

  Future<void> btnPress(position) async {
    setState(() {
      _chosenPosition = position;
    });

    final correct = CONST.stack[_randomCard] == _chosenPosition;
    if (correct) {
      Timer(new Duration(milliseconds: 250), handleTimeout);
    } else {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              MistakeDialog(position: CONST.stack[_randomCard]));
      setState(() {
        _chosenPosition = -1;
      });
    }
  }

  void handleTimeout() {
    setState(() {
      _chosenPosition = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_chosenPosition == -1) {
      setupRandom();
    }

    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 42, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Stack Trainer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      )),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        'images/icons/card_icon_red.png',
                        width: 60,
                      ))
                ],
              ),
            ),
            CardDisplay(randomCard: _randomCard),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(_chosenPosition, _randomCard, btnPress, _positions.sublist(0,2)),
                ButtonRow(_chosenPosition, _randomCard, btnPress, _positions.sublist(2,4)),
              ],
            )
          ],
        ));
  }
}
