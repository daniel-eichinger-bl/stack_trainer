import 'package:flutter/material.dart';
import 'package:stack_trainer/QuizWidgets/MistakeDialog.dart';
import 'dart:math';
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
    var randomPositions =
        List.generate(4, (_) => Random().nextInt(CONST.stack.length - 1) + 1);

    setState(() {
      _randomCard = CONST.stack.keys.elementAt(randomPositions[0] - 1);
      randomPositions.shuffle();
      _positions = randomPositions;
    });
  }

  Color _getButtonColor(ele, correct, context) {
    if (_chosenPosition == ele) {
      return correct ? Colors.green : Colors.red;
    } else {
      return Theme.of(context).accentColor;
    }
  }

  Widget _generateButtons(elements, context) {
    final disabled = _chosenPosition != -1 ? true : false;
    var correct = false;
    if (_chosenPosition != -1) {
      correct = CONST.stack[_randomCard] == _chosenPosition;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(elements.length, (idx) {
        final ele = elements[idx];

        return Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.all(10),
            width: 150,
            height: 70,
            child: RaisedButton(
              onPressed: disabled ? null : () => btnPress(ele, context),
              disabledElevation: 1,
              disabledTextColor: Colors.black,
              disabledColor: _getButtonColor(ele, correct, context),
              child: Text(
                '$ele',
                style: TextStyle(fontSize: 18),
              ),
              color: Theme.of(context).accentColor,
            ));
      }),
    );
  }

  Future<void> btnPress(position, context) async {
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
                _generateButtons(_positions.sublist(0, 2), context),
                _generateButtons(_positions.sublist(2, 4), context)
              ],
            )
          ],
        ));
  }
}
