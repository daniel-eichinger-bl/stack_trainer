import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/ButtonRow.dart';
import 'package:stack_trainer/PositionTrainerWidgets/MistakeDialog.dart';
import 'dart:async';
import 'constants.dart' as CONST;
import 'PositionTrainerWidgets/CardDisplay.dart';

class PositionTrainer extends StatefulWidget {
  static const routeName = '/quiz_trainer';

  @override
  State<StatefulWidget> createState() {
    return _PositionTrainerState();
  }
}

class _PositionTrainerState extends State<PositionTrainer> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _randomCard = '';
  var _positions = [];
  int _chosenPosition = -1;

  void setupRandom() {
    final l = List.generate(52, (i) => i + 1);
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
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 4, 7, 1.0),
          leading: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: IconButton(
              icon: Icon(Icons.settings,size: 26,),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
              color: Colors.grey,
            ),
          ),
          titleSpacing: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Stack Trainer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    )),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'images/icons/card_icon_red.png',
                      width: 60,
                    )),
              ],
            ),
          ),
        ),
        drawer: Drawer(child: Text("hello")),
        body: Column(
          children: <Widget>[
            CardDisplay(randomCard: _randomCard),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ButtonRow(_chosenPosition, _randomCard, btnPress,
                    _positions.sublist(0, 2)),
                ButtonRow(_chosenPosition, _randomCard, btnPress,
                    _positions.sublist(2, 4)),
              ],
            )
          ],
        ));
  }
}
